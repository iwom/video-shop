package com.example.videostore.movie

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
import org.springframework.http.HttpStatus.BAD_REQUEST
import org.springframework.http.HttpStatus.NOT_FOUND
import org.springframework.http.MediaType
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.client.RestTemplate
import org.springframework.web.server.ResponseStatusException
import java.math.BigDecimal

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

    fun getMovieByTitle(title: String): Movie {
        val url = "$omdbUrl?t=${title.replace(' ', '+')}&apikey=$omdbKey"

        val entity = HttpEntity("parameters", HttpHeaders().apply { accept = listOf(MediaType.APPLICATION_JSON) })

        val result = RestTemplate().exchange(url, HttpMethod.GET, entity, String::class.java)

        return mapper.readValue(result.body, Movie::class.java).also {
            it.year.ifBlank { throw ResponseStatusException(NOT_FOUND, "Could not find film with title: $title") }
        }
    }

    @Transactional
    fun addMovieByTitle(title: String, price: BigDecimal, quantity: Int): MovieDTO =
        incrementMovieInventory(title, quantity) ?: createMovieInventory(title, price, quantity)

    private fun incrementMovieInventory(title: String, quantity: Int): MovieDTO? =
        movieRepository.findByTitle(title)?.let { movie ->
            MovieDTO(
                movie = movie,
                inventory = findInventoryOrElseCreateBy(movie).let { inventoryRepository.save(it.copy(value = it.value + quantity)) }
            )
        }

    private fun createMovieInventory(title: String, price: BigDecimal, quantity: Int) =
        getMovieByTitle(title).copy(price = price).let { movie ->
            MovieDTO(movie = movie, inventory = inventoryRepository.save(Inventory(movie = movie, value = quantity)))
        }

    private fun findInventoryOrElseCreateBy(movie: Movie) =
        (inventoryRepository.findByMovie(movie) ?: inventoryRepository.save(Inventory(movie = movie)))

    fun returnToInventory(movie: Movie, quantity: Int) {
        val inventory: Inventory = inventoryRepository.findByMovie(movie)
                ?: throw ResponseStatusException(NOT_FOUND, "There is no ${movie.title} in inventory")

        inventoryRepository.save(inventory.copy(value = inventory.value + quantity))
    }

    fun removeFromInventory(movie: Movie, quantity: Int) {
        val inventory: Inventory = inventoryRepository.findByMovie(movie)
                ?: throw ResponseStatusException(NOT_FOUND, "There is no ${movie.title} in inventory")

        if (inventory.value < quantity)
            throw ResponseStatusException(
                BAD_REQUEST, "Cannot buy $quantity of ${movie.title} movie. There are: ${inventory.value} in inventory"
            )
        inventoryRepository.save(inventory.copy(value = inventory.value - quantity))
    }

    private fun List<Movie>.toMoviePageDTO(title: String) =
        this.map { movie ->
            MovieDTO(
                movie = movie,
                inventory = inventoryRepository.findByMovie(movie) ?: throw ResponseStatusException(
                    NOT_FOUND, "Inventory for movie with id: ${movie.id} not found"
                )
            )
        }
            .let { MoviePageDTO(it, movieRepository.countAllWith(title)) }
}