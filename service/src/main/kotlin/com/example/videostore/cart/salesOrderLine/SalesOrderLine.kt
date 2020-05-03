package com.example.videostore.cart.salesOrderLine

import com.example.videostore.cart.dto.SalesOrderLineDTO
import com.example.videostore.cart.salesOrder.SalesOrder
import com.example.videostore.movie.Movie
import java.util.*
import javax.persistence.*

@Entity
data class SalesOrderLine(
    @Id
    val id: UUID = UUID.randomUUID(),
    @ManyToOne
    val salesOrder: SalesOrder = SalesOrder(),
    @OneToOne
    val movie: Movie = Movie(),
    val quantity: Int = 0
) {
    @Column(columnDefinition = "NUMERIC (8,2)")
    val price: Double = quantity * movie.price

    fun toSalesOrderLineDTO() = SalesOrderLineDTO(
        movie = this.movie,
        quantity = this.quantity,
        price = this.price
    )
}