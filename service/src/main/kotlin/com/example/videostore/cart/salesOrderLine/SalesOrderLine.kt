package com.example.videostore.cart.salesOrderLine

import com.example.videostore.cart.salesOrder.SalesOrder
import com.example.videostore.movie.Movie
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import com.fasterxml.jackson.databind.ser.std.NumberSerializers
import com.fasterxml.jackson.databind.ser.std.NumberSerializers.*
import java.util.*
import javax.persistence.*

@Entity
data class SalesOrderLine(
    @Id
    val id: UUID = UUID.randomUUID(),
    @ManyToOne(cascade = [CascadeType.PERSIST, CascadeType.REFRESH, CascadeType.MERGE, CascadeType.DETACH])
    val salesOrder: SalesOrder = SalesOrder(),
    @OneToOne
    val movie: Movie = Movie(),
    val quantity: Int = 0
) {
    @Column(columnDefinition = "NUMERIC (8,2)")
    val price: Double =  quantity * movie.price
}