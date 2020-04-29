package com.example.videostore.cart.salesOrder

import com.example.videostore.user.User
import org.springframework.data.repository.Repository
import java.util.*

interface SalesOrderRepository : Repository<SalesOrder, UUID> {
    fun findById(id: UUID): SalesOrder?
    fun findByUser(user: User): SalesOrder?

    fun save(salesOrder: SalesOrder): SalesOrder
}