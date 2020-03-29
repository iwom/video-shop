package com.example.videostore.movie

import com.example.videostore.infrastructure.ServiceException
import com.example.videostore.movie.dto.MovieDTO
import com.example.videostore.movie.dto.MoviePageDTO
import com.example.videostore.movie.inventory.Inventory
import com.example.videostore.movie.inventory.InventoryRepository
import com.google.gson.FieldNamingPolicy
import com.google.gson.GsonBuilder
import org.springframework.beans.factory.annotation.Value
import org.springframework.http.*
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.client.RestTemplate
import java.util.*

@Service
class MovieService(
    private val movieRepository: MovieRepository,
    private val inventoryRepository: InventoryRepository
) {
    @Value("\${videoshop.app.omdbKey}")
    private val omdbKey: String? = null

    fun getAllMoviesWith(offset: Int, limit: Int): MoviePageDTO =
        movieRepository.findAllWith(offset, limit)
            .map { movie ->
                MovieDTO(
                    movie = movie,
                    inventory = inventoryRepository.findByMovie(movie) ?: throw ServiceException(
                        HttpStatus.NOT_FOUND, "Inventory for movie with id: ${movie.id} not found"
                    )
                )
            }
            .let { MoviePageDTO(it, movieRepository.findAll().count()) }

    @Transactional
    fun addMovieByTitle(title: String): Movie {

        val uri = "http://www.omdbapi.com/?t=${title.replace(' ', '+')}&apikey=$omdbKey"

        val entity = HttpEntity("parameters", HttpHeaders().apply { accept = listOf(MediaType.APPLICATION_JSON) })

        val result = RestTemplate().exchange(
            uri, HttpMethod.GET, entity,
            String::class.java
        )

        val gson = GsonBuilder()
            .setFieldNamingPolicy(FieldNamingPolicy.UPPER_CAMEL_CASE)
            .create()

        val movie = gson.fromJson(result.body, Movie::class.java)
            // for now I would leave it because by default it's null when deserialize
            .copy(id = UUID.randomUUID())

        return movieRepository.save(movie)
            .apply { inventoryRepository.save(Inventory(movie = this)) }
    }
}