package com.example.videostore.movie

import com.example.videostore.movie.dto.MoviePageDTO
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.*

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

    @GetMapping("/admin")
    fun getMovie(@RequestParam title: String) = movieService.getMovieByTitle(title)

    @PostMapping("/admin")
    fun addMovie(@RequestParam title: String, @RequestParam price: Double, @RequestParam quantity: Int) =
        movieService.addMovieByTitle(title, price, quantity)
}