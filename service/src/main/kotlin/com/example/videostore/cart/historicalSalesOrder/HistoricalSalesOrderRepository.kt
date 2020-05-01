package com.example.videostore.cart.historicalSalesOrder

import com.example.videostore.user.User
import org.springframework.data.repository.Repository
import java.util.*

interface HistoricalSalesOrderRepository : Repository<HistoricalSalesOrder, UUID> {
    fun findAllByUser(user: User): List<HistoricalSalesOrder>
    fun save(historicalSalesOrder: HistoricalSalesOrder): HistoricalSalesOrder
}