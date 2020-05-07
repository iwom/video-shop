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
        @RequestParam offset: Int,
        @RequestParam limit: Int,
        @RequestParam title: String
    ): MoviePageDTO = movieService.getAllMoviesWith(offset, limit, title)

    @PostMapping
    fun addMovie(@RequestParam title: String, @RequestParam price: BigDecimal, @RequestParam quantity: Int) =
        movieService.addMovieByTitle(title, price, quantity)

    @GetMapping("/admin")
    fun getMovie(@RequestParam title: String) = movieService.getMovieByTitle(title)

}