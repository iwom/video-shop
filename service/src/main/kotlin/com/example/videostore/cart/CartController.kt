package com.example.videostore.cart

import com.example.videostore.cart.dto.SalesOrderDTO
import com.example.videostore.cart.historicalSalesOrder.HistoricalSalesOrder
import com.example.videostore.cart.salesOrderLine.SalesOrderLine
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import java.util.*

@CrossOrigin
@RequestMapping("/carts")
@RestController
class CartController(
    private val cartService: CartService
) {
    @GetMapping("/historical")
    fun getHistoricalSalesOrders(): List<HistoricalSalesOrder> = cartService.getHistoricalSalesOrders()

    @GetMapping
    fun getCurrentSalesOrder(): SalesOrderDTO = cartService.getCurrentSalesOrder()

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

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{salesOrderId}")
    fun deleteSalesOrder(@PathVariable salesOrderId: UUID) = cartService.deleteSalesOrder(salesOrderId)

}