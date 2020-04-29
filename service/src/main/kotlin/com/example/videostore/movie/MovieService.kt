package com.example.videostore.movie

import com.example.videostore.infrastructure.ServiceException
import com.example.videostore.movie.dto.MovieDTO
import com.example.videostore.movie.dto.MoviePageDTO
import com.example.videostore.movie.inventory.Inventory
import com.example.videostore.movie.inventory.InventoryRepository
import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.PropertyNamingStrategy.UPPER_CAMEL_CASE
import com.fasterxml.jackson.module.kotlin.KotlinModule
import org.springframework.beans.factory.annotation.Value
import org.springframework.http.HttpEntity
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpMethod
import org.springframework.http.HttpStatus.NOT_FOUND
import org.springframework.http.MediaType
import org.springframework.stereotype.Service
import org.springframework.web.client.RestTemplate

@Service
class MovieService(
    private val movieRepository: MovieRepository,
    private val inventoryRepository: InventoryRepository
) {
    companion object {
        val mapper: ObjectMapper = ObjectMapper()
            .setPropertyNamingStrategy(UPPER_CAMEL_CASE)
            .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
            .registerModule(KotlinModule())
    }

    @Value("\${videoshop.app.omdbKey}")
    private val omdbKey: String? = null

    @Value("\${videoshop.app.omdbUrl}")
    private val omdbUrl: String? = null

    fun getAllMoviesWith(offset: Int, limit: Int, title: String): MoviePageDTO {
        val searchTitle = title.ifEmpty { "." }
        return movieRepository.findAllWith(offset, limit, searchTitle).toMoviePageDTO(searchTitle)
    }

    fun addMovieByTitle(title: String, price: Double): Movie {
        val url = "$omdbUrl?t=${title.replace(' ', '+')}&apikey=$omdbKey"

        val entity = HttpEntity("parameters", HttpHeaders().apply { accept = listOf(MediaType.APPLICATION_JSON) })

        val result = RestTemplate().exchange(
            url, HttpMethod.GET, entity,
            String::class.java
        )

        return mapper.readValue(result.body, Movie::class.java).copy(price = price)
            .apply {
                if (this.title.isEmpty()) throw ServiceException(NOT_FOUND, "Could not find film with title: $title")
            }
            .let {
                movieRepository.findByTitle(it.title) ?: movieRepository.save(it)
                    .apply { inventoryRepository.save(Inventory(movie = this)) }
            }
    }

    private fun List<Movie>.toMoviePageDTO(title: String) =
        this.map { movie ->
            MovieDTO(
                movie = movie,
                inventory = inventoryRepository.findByMovie(movie) ?: throw ServiceException(
                    NOT_FOUND, "Inventory for movie with id: ${movie.id} not found"
                )
            )
        }
            .let { MoviePageDTO(it, movieRepository.countAllWith(title)) }
}