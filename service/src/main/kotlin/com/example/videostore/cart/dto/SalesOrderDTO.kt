package com.example.videostore.cart.dto

import com.example.videostore.user.User
import java.math.BigDecimal
import java.time.LocalDateTime
import java.util.*

data class SalesOrderDTO(
    val id: UUID,
    val user: User,
    val createdOn: LocalDateTime,
    val updatedOn: LocalDateTime,
    val salesOrderLines: MutableList<SalesOrderLineDTO>
) {
    val totalPrice: BigDecimal =
        (salesOrderLines.map { it.price }
            .let { if (it.isNotEmpty()) it.reduce { acc, price -> price + acc } else BigDecimal(0.0) })
}