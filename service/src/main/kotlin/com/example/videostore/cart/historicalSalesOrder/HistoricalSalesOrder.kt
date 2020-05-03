package com.example.videostore.cart.historicalSalesOrder

import com.example.videostore.user.User
import java.time.LocalDateTime
import java.util.*
import javax.persistence.*

@Entity
data class HistoricalSalesOrder(
    @Id
    val id: UUID = UUID.randomUUID(),
    @OneToOne
    val user: User = User(),
    val createdOn: LocalDateTime = LocalDateTime.now(),

    @OneToMany(mappedBy = "historicalSalesOrder", cascade = [CascadeType.ALL])
    val historicalSalesOrderLines: MutableList<HistoricalSalesOrderLine> = mutableListOf()
) {
    @Column(columnDefinition = "NUMERIC (8,2)")
    val totalPrice: Double =
        historicalSalesOrderLines.map { it.price }
            .let { if (it.isNotEmpty()) it.reduce { acc, price -> price + acc } else 0.0 }
}