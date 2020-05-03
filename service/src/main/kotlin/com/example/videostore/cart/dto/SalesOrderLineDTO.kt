package com.example.videostore.cart.dto

import com.example.videostore.movie.Movie

data class SalesOrderLineDTO(
    val movie: Movie,
    val quantity: Int,
    val price: Double
)