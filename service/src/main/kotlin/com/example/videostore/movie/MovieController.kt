package com.example.videostore.movie

import com.example.videostore.movie.dto.MoviePageDTO
import org.springframework.web.bind.annotation.*

@CrossOrigin
@RequestMapping("/movies")
@RestController
class MovieController(
    private val movieService: MovieService
) {
    @GetMapping
    fun getMovies(
        @RequestParam(name = "offset") offset: Int,
        @RequestParam(name = "limit") limit: Int
    ): MoviePageDTO = movieService.getAllMoviesWith(offset, limit)

    @PostMapping
    fun addMovie(@RequestParam(name = "title") title: String, @RequestParam(name = "price") price: Double) =
        movieService.addMovieByTitle(title, price)
}