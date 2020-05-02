package com.example.videostore.cart

import com.example.videostore.cart.dto.SalesOrderDTO
import com.example.videostore.cart.dto.SalesOrderLineDTO
import com.example.videostore.cart.historicalSalesOrder.HistoricalSalesOrder
import com.example.videostore.cart.salesOrder.SalesOrder
import com.example.videostore.cart.salesOrderLine.SalesOrderLine
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import java.util.*

@RequestMapping("/carts")
@RestController
class CartController(
    private val cartService: CartService
) {
    @GetMapping("/historical")
    fun getHistoricalSalesOrders(): List<HistoricalSalesOrder> = cartService.getHistoricalSalesOrders()

    @GetMapping
    fun getAllSalesOrderLines(): SalesOrderDTO = cartService.getAllSalesOrderLines()
    
    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping
    fun addToSalesOrder(@RequestBody salesOrderLine: SalesOrderLine): SalesOrderLine =
        cartService.addToSalesOrder(salesOrderLine)

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping
    fun removeFromSalesOrder(@RequestBody salesOrderLine: SalesOrderLine): Unit =
        cartService.removeFromSalesOrder(salesOrderLine)

    @PutMapping("/finalize/{salesOrderId}")
    fun finalizeSalesOrder(@PathVariable salesOrderId: UUID): HistoricalSalesOrder =
        cartService.finalizeSalesOrder(salesOrderId)
}