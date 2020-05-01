package com.example.videostore.cart.salesOrderLine

import com.example.videostore.cart.salesOrder.SalesOrder
import com.example.videostore.movie.Movie
import org.springframework.data.repository.Repository
import org.springframework.http.HttpStatus
import org.springframework.web.server.ResponseStatusException
import java.util.*

interface SalesOrderLineRepository : Repository<SalesOrderLine, UUID> {
    fun save(salesOrderLine: SalesOrderLine): SalesOrderLine
    fun findBySalesOrderAndMovie(salesOrder: SalesOrder, movie: Movie): SalesOrderLine?
    fun deleteById(id: UUID)

    @JvmDefault
    fun findBySalesOrderAndMovieOrThrow(salesOrder: SalesOrder, movie: Movie) =
        findBySalesOrderAndMovie(salesOrder, movie) ?: throw ResponseStatusException(
            HttpStatus.NOT_FOUND,
            "Sales order line for movie: ${movie.id} and salesOrder: ${salesOrder.id} not found"
        )
}