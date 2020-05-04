package com.example.videostore.cart.dto

import com.example.videostore.movie.Movie
import java.math.BigDecimal

data class SalesOrderLineDTO(
    val movie: Movie,
    val quantity: Int,
    val price: BigDecimal
)