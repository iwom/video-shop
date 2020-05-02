package com.example.videostore.cart.salesOrder

import com.example.videostore.user.User
import org.springframework.data.repository.Repository
import org.springframework.http.HttpStatus
import org.springframework.web.server.ResponseStatusException
import java.util.*

interface SalesOrderRepository : Repository<SalesOrder, UUID> {
    fun findById(id: UUID): SalesOrder?
    fun findByUser(user: User): SalesOrder?

    @JvmDefault
    fun findByIdOrThrow(id: UUID): SalesOrder =
        findById(id) ?: throw ResponseStatusException(
            HttpStatus.NOT_FOUND, "Sales order with id: $id not found"
        )

    fun save(salesOrder: SalesOrder): SalesOrder
    fun deleteById(id: UUID)
}