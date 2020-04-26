package com.example.videostore.cart

import com.example.videostore.cart.historicalSalesOrder.HistoricalSalesOrderRepository
import com.example.videostore.cart.salesOrder.SalesOrderRepository
import com.example.videostore.cart.salesOrderLine.SalesOrderLine
import com.example.videostore.cart.salesOrderLine.SalesOrderLineRepository
import com.example.videostore.movie.MovieService
import com.example.videostore.security.userDetails.UserDetailsImpl
import com.example.videostore.user.User
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

    //TODO: remove from cart

    @Transactional
    fun addToCart(salesOrderLine: SalesOrderLine): SalesOrderLine {
        val currentUser = (SecurityContextHolder.getContext().authentication.principal as UserDetailsImpl)
            .let { userService.getUserById(it.id) }

        return createSalesOrderLine(currentUser, salesOrderLine)
    }

    private fun createSalesOrderLine(user: User, salesOrderLine: SalesOrderLine): SalesOrderLine {

        val salesOrder = (salesOrderRepository.findByUser(user) ?: salesOrderLine.salesOrder.copy(user = user))
            .copy(updatedOn = LocalDateTime.now())
            .let { salesOrderRepository.save(it) }

        movieService.bookMovie(salesOrderLine.movie, salesOrderLine.quantity)

        return (salesOrderLineRepository.findBySalesOrderAndMovie(salesOrder, salesOrderLine.movie)
            ?.let { it.copy(quantity = it.quantity + salesOrderLine.quantity) }
                ?: salesOrderLine.copy(salesOrder = salesOrder))
            .let { salesOrderLineRepository.save(it) }
    }
}