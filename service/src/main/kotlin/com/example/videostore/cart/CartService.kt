package com.example.videostore.cart

import com.example.videostore.cart.dto.SalesOrderDTO
import com.example.videostore.cart.historicalSalesOrder.HistoricalSalesOrder
import com.example.videostore.cart.historicalSalesOrder.HistoricalSalesOrderLine
import com.example.videostore.cart.historicalSalesOrder.HistoricalSalesOrderRepository
import com.example.videostore.cart.salesOrder.SalesOrder
import com.example.videostore.cart.salesOrder.SalesOrderRepository
import com.example.videostore.cart.salesOrderLine.SalesOrderLine
import com.example.videostore.cart.salesOrderLine.SalesOrderLineRepository
import com.example.videostore.movie.MovieService
import com.example.videostore.security.AuthorizationService
import com.example.videostore.user.User
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.server.ResponseStatusException
import java.time.LocalDateTime
import java.util.*

@Service
class CartService(
    private val salesOrderRepository: SalesOrderRepository,
    private val salesOrderLineRepository: SalesOrderLineRepository,
    private val historicalSalesOrderRepository: HistoricalSalesOrderRepository,
    private val movieService: MovieService,
    private val authorizationService: AuthorizationService
) {

    fun getCurrentSalesOrder(): SalesOrderDTO {
        val currentUser = authorizationService.getCurrentUser()
        return salesOrderRepository.findByUser(currentUser)?.toSalesOrderDTO()
                ?: salesOrderRepository.save(SalesOrder(user = currentUser)).toSalesOrderDTO()
    }

    fun getHistoricalSalesOrders(): List<HistoricalSalesOrder> = authorizationService.getCurrentUser()
        .let { currentUser -> historicalSalesOrderRepository.findAllByUser(currentUser) }

    @Transactional
    fun finalizeSalesOrder(salesOrderId: UUID): HistoricalSalesOrder {
        val salesOrder = salesOrderRepository.findByIdOrThrow(salesOrderId)
        val historicalSalesOrder = HistoricalSalesOrder(user = salesOrder.user)

        val historicalSalesOrderLines = salesOrder.salesOrderLines
            .map { HistoricalSalesOrderLine(it).copy(historicalSalesOrder = historicalSalesOrder) }.toMutableList()

        salesOrderRepository.deleteById(salesOrderId)

        return historicalSalesOrderRepository
            .save(historicalSalesOrder.copy(historicalSalesOrderLines = historicalSalesOrderLines))
    }

    @Transactional
    fun removeFromSalesOrder(salesOrderLine: SalesOrderLine) {
        val currentUser = authorizationService.getCurrentUser()

        val salesOrder = getSalesOrderByUserOrElseCreate(currentUser, salesOrderLine)
            .copy(updatedOn = LocalDateTime.now())

        val existingSalesOrderLine: SalesOrderLine =
            salesOrderLineRepository.findBySalesOrderAndMovieOrThrow(salesOrder, salesOrderLine.movie)

        if (existingSalesOrderLine.quantity == salesOrderLine.quantity)
            return salesOrderLineRepository.deleteById(existingSalesOrderLine.id)

        if (existingSalesOrderLine.quantity < salesOrderLine.quantity)
            throw ResponseStatusException(
                HttpStatus.BAD_REQUEST,
                "Cannot remove ${salesOrderLine.quantity} instances of movie: ${salesOrderLine.movie.id}. " +
                        "There are only ${existingSalesOrderLine.quantity} of them in current cart"
            )

        movieService.returnToInventory(salesOrderLine.movie, salesOrderLine.quantity)

        removeMovieFromSalesOrderLineInSalesOrder(salesOrderLine, salesOrder)
            .let { salesOrderLineRepository.save(it) }
    }

    @Transactional
    fun deleteSalesOrder(salesOrderId: UUID) {
        val currentUser = authorizationService.getCurrentUser()
        salesOrderRepository.findByUser(currentUser)?.run {
            if (this.id != salesOrderId) return

            this.salesOrderLines.forEach { movieService.returnToInventory(it.movie, it.quantity) }

            salesOrderRepository.deleteById(salesOrderId)
        }
    }

    @Transactional
    fun addToSalesOrder(salesOrderLine: SalesOrderLine): SalesOrderLine {
        val currentUser = authorizationService.getCurrentUser()

        val salesOrder = getSalesOrderByUserOrElseCreate(currentUser, salesOrderLine)
            .copy(updatedOn = LocalDateTime.now())
            .let { salesOrderRepository.save(it) }

        movieService.removeFromInventory(salesOrderLine.movie, salesOrderLine.quantity)

        return addMovieToSalesOrderLineInSalesOrder(salesOrderLine, salesOrder)
            .let { salesOrderLineRepository.save(it) }
    }

    private fun addMovieToSalesOrderLineInSalesOrder(
        salesOrderLine: SalesOrderLine, salesOrder: SalesOrder
    ): SalesOrderLine = (salesOrderLineRepository.findBySalesOrderAndMovie(salesOrder, salesOrderLine.movie)
        ?.let { it.copy(quantity = it.quantity + salesOrderLine.quantity) }
            ?: salesOrderLine.copy(salesOrder = salesOrder))

    private fun removeMovieFromSalesOrderLineInSalesOrder(
        salesOrderLine: SalesOrderLine,
        salesOrder: SalesOrder
    ): SalesOrderLine =
        (salesOrderLineRepository.findBySalesOrderAndMovie(salesOrder, salesOrderLine.movie)
            ?.let { it.copy(quantity = it.quantity - salesOrderLine.quantity) }
                ?: salesOrderLine.copy(salesOrder = salesOrder))

    private fun getSalesOrderByUserOrElseCreate(currentUser: User, salesOrderLine: SalesOrderLine): SalesOrder =
        (salesOrderRepository.findByUser(currentUser) ?: salesOrderLine.salesOrder.copy(user = currentUser))
}