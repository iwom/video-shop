package com.example.videostore.movie

import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.Repository
import java.util.*

interface MovieRepository : Repository<Movie, UUID> {

    @Query(value = "SELECT * from movie offset ?1 limit ?2", nativeQuery = true)
    fun findAllWith(offset: Int, limit: Int): List<Movie>
    fun findAll(): List<Movie>
    fun findByTitle(title: String): Movie?

    fun save(movie: Movie): Movie
}