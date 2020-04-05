package com.example.videostore.movie.dto

import com.example.videostore.movie.Movie
import com.example.videostore.movie.inventory.Inventory

data class MovieDTO(
    val movie: Movie,
    val inventory: Inventory
)