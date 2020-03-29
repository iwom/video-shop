package com.example.videostore.movie.dto

data class MoviePageDTO(
    val movies: List<MovieDTO>,
    val total: Int
)