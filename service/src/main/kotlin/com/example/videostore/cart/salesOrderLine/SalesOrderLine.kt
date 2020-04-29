package com.example.videostore.cart.salesOrderLine

import com.example.videostore.cart.salesOrder.SalesOrder
import com.example.videostore.movie.Movie
import java.util.*
import javax.persistence.*

@Entity
data class SalesOrderLine(
    @Id
    val id: UUID = UUID.randomUUID(),
    @OneToOne(cascade = [CascadeType.ALL])
    val salesOrder: SalesOrder = SalesOrder(),
    @OneToOne
    val movie: Movie = Movie(),
    val quantity: Int = 0
) {
    @Column(columnDefinition = "NUMERIC (8,2)")
    val price: Double = movie.price * quantity
}