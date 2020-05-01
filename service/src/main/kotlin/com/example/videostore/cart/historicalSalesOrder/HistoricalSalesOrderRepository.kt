package com.example.videostore.cart.historicalSalesOrder

import org.springframework.data.repository.Repository
import java.util.*

interface HistoricalSalesOrderRepository : Repository<HistoricalSalesOrder, UUID> {
    fun save(historicalSalesOrder: HistoricalSalesOrder): HistoricalSalesOrder
}