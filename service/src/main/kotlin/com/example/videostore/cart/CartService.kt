package com.example.videostore.cart

import com.example.videostore.cart.historicalSalesOrder.HistoricalSalesOrderRepository
import com.example.videostore.cart.salesOrder.SalesOrderRepository
import com.example.videostore.cart.salesOrderLine.SalesOrderLine
import com.example.videostore.cart.salesOrderLine.SalesOrderLineRepository
import com.example.videostore.movie.MovieService
import com.example.videostore.security.userDetails.UserDetailsImpl
import com.example.videostore.user.UserService
import org.springframework.http.HttpStatus
import org.springframework.security.core.context.SecurityContextHolder
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
    private val userService: UserService
) {

    //TODO: finalize cart

    @Transactional
    fun removeFromCart(salesOrderLine: SalesOrderLine) {
        val currentUser = (SecurityContextHolder.getContext().authentication.principal as UserDetailsImpl)
            .let { userService.getUserById(it.id) }

        val salesOrder =
            (salesOrderRepository.findByUser(currentUser) ?: salesOrderLine.salesOrder.copy(user = currentUser))
                .copy(updatedOn = LocalDateTime.now())
                .let { salesOrderRepository.save(it) }

        val existingSalesOrderLine: SalesOrderLine =
            salesOrderLineRepository.findBySalesOrderAndMovie(salesOrder, salesOrderLine.movie)
                    ?: throw ResponseStatusException(
                        HttpStatus.NOT_FOUND,
                        "Sales order line for movie: ${salesOrderLine.movie.id} and user: ${currentUser.id} not found"
                    )

        if (existingSalesOrderLine.quantity < salesOrderLine.quantity)
            throw ResponseStatusException(
                HttpStatus.BAD_REQUEST,
                "Cannot remove ${salesOrderLine.quantity} instances of movie: ${salesOrderLine.movie.id}. " +
                        "There are only ${existingSalesOrderLine.quantity} of them in current cart"
            )

        if (existingSalesOrderLine.quantity == salesOrderLine.quantity) {
            salesOrderLineRepository.deleteById(existingSalesOrderLine.id)
            return
        }

        movieService.returnToInventory(salesOrderLine.movie, salesOrderLine.quantity)

        (salesOrderLineRepository.findBySalesOrderAndMovie(salesOrder, salesOrderLine.movie)
            ?.let { it.copy(quantity = it.quantity - salesOrderLine.quantity) }
                ?: salesOrderLine.copy(salesOrder = salesOrder))
            .let { salesOrderLineRepository.save(it) }
    }

    @Transactional
    fun addToCart(salesOrderLine: SalesOrderLine): SalesOrderLine {
        val currentUser = (SecurityContextHolder.getContext().authentication.principal as UserDetailsImpl)
            .let { userService.getUserById(it.id) }

        val salesOrder =
            (salesOrderRepository.findByUser(currentUser) ?: salesOrderLine.salesOrder.copy(user = currentUser))
                .copy(updatedOn = LocalDateTime.now())
                .let { salesOrderRepository.save(it) }

        movieService.takeFromInventory(salesOrderLine.movie, salesOrderLine.quantity)

        return (salesOrderLineRepository.findBySalesOrderAndMovie(salesOrder, salesOrderLine.movie)
            ?.let { it.copy(quantity = it.quantity + salesOrderLine.quantity) }
                ?: salesOrderLine.copy(salesOrder = salesOrder))
            .let { salesOrderLineRepository.save(it) }
    }
}