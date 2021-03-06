package com.example.videostore.cart.salesOrder

import com.example.videostore.cart.dto.SalesOrderDTO
import com.example.videostore.cart.salesOrderLine.SalesOrderLine
import com.example.videostore.user.User
import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDateTime
import java.util.*
import javax.persistence.*

@Entity
data class SalesOrder(
    @Id
    val id: UUID = UUID.randomUUID(),
    @OneToOne
    val user: User = User(),
    val createdOn: LocalDateTime = LocalDateTime.now(),
    val updatedOn: LocalDateTime = LocalDateTime.now(),

    @JsonIgnore
    @OneToMany(mappedBy = "salesOrder", cascade = [CascadeType.ALL])
    val salesOrderLines: MutableList<SalesOrderLine> = mutableListOf()
) {
    fun toSalesOrderDTO() = SalesOrderDTO(
        id = this.id,
        user = this.user,
        createdOn = this.createdOn,
        updatedOn = this.updatedOn,
        salesOrderLines = this.salesOrderLines
                .map { it.toSalesOrderLineDTO() }
                .sortedBy { it.movie.title }
                .toMutableList()
    )
}