package com.example.videostore.movie

import com.example.videostore.movie.dto.MoviePageDTO
import org.springframework.web.bind.annotation.*
import java.math.BigDecimal

@CrossOrigin
@RequestMapping("/movies")
@RestController
class MovieController(
    private val movieService: MovieService
) {
    @GetMapping
    fun getMovies(
        @RequestParam(name = "offset") offset: Int,
        @RequestParam(name = "limit") limit: Int,
        @RequestParam(name = "title") title: String
    ): MoviePageDTO = movieService.getAllMoviesWith(offset, limit, title)

    @PostMapping
    fun addMovie(@RequestParam(name = "title") title: String, @RequestParam(name = "price") price: BigDecimal) =
        movieService.addMovieByTitle(title, price)
}