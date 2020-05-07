package com.example.videostore.cart.historicalSalesOrder

import com.example.videostore.cart.salesOrderLine.SalesOrderLine
import com.example.videostore.movie.Movie
import com.fasterxml.jackson.annotation.JsonIgnore
import java.math.BigDecimal
import java.util.*
import javax.persistence.*

@Entity
data class HistoricalSalesOrderLine(
    @Id
    val id: UUID = UUID.randomUUID(),
    @JsonIgnore
    @ManyToOne
    val historicalSalesOrder: HistoricalSalesOrder = HistoricalSalesOrder(),
    @OneToOne
    val movie: Movie = Movie(),
    val quantity: Int = 0
) {
    constructor(salesOrderLine: SalesOrderLine) : this(
        movie = salesOrderLine.movie,
        quantity = salesOrderLine.quantity
    )

    @Column(columnDefinition = "NUMERIC (8,2)")
    val price: BigDecimal = quantity.toBigDecimal() * movie.price
}