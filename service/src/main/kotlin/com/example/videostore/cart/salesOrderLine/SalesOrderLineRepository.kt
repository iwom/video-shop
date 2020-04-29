package com.example.videostore.cart.salesOrderLine

import com.example.videostore.cart.salesOrder.SalesOrder
import com.example.videostore.movie.Movie
import org.springframework.data.repository.Repository
import java.util.*

interface SalesOrderLineRepository : Repository<SalesOrderLine, UUID> {
    fun save(salesOrderLine: SalesOrderLine): SalesOrderLine
    fun findBySalesOrderAndMovie(salesOrder: SalesOrder, movie: Movie): SalesOrderLine?

    fun deleteById(id: UUID)
}