package com.example.videostore.cart

import com.example.videostore.cart.historicalSalesOrder.HistoricalSalesOrderRepository
import com.example.videostore.cart.salesOrder.SalesOrder
import com.example.videostore.cart.salesOrder.SalesOrderRepository
import com.example.videostore.cart.salesOrderLine.SalesOrderLine
import com.example.videostore.cart.salesOrderLine.SalesOrderLineRepository
import com.example.videostore.movie.Movie
import com.example.videostore.movie.MovieService
import com.example.videostore.security.AuthorizationService
import com.example.videostore.user.User
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.server.ResponseStatusException
import java.time.LocalDateTime

@Service
class CartService(
    private val salesOrderRepository: SalesOrderRepository,
    private val salesOrderLineRepository: SalesOrderLineRepository,
    private val historicalSalesOrderRepository: HistoricalSalesOrderRepository,
    private val movieService: MovieService,
    private val authorizationService: AuthorizationService
) {

    //TODO: finalize cart

    @Transactional
    fun removeFromCart(salesOrderLine: SalesOrderLine) {
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
    fun addToCart(salesOrderLine: SalesOrderLine): SalesOrderLine {
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