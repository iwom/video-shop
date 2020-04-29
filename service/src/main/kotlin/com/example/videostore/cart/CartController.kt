package com.example.videostore.cart

import com.example.videostore.cart.salesOrderLine.SalesOrderLine
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*

@RequestMapping("/carts")
@RestController
class CartController(
    private val cartService: CartService
) {
    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping
    fun addToCart(@RequestBody salesOrderLine: SalesOrderLine): SalesOrderLine =
        cartService.addToCart(salesOrderLine)

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping
    fun removeFromCart(@RequestBody salesOrderLine: SalesOrderLine) = cartService.removeFromCart(salesOrderLine)
}