package com.example.videostore.movie

import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.Repository
import java.util.*

interface MovieRepository : Repository<Movie, UUID> {
    companion object {
        private const val FIND_QUERY = "SELECT * from movie where title ~* ?3 offset ?1 limit ?2"
        private const val COUNT_QUERY = "SELECT count(*) from movie where title ~* ?1"
    }

    @Query(value = FIND_QUERY, nativeQuery = true)
    fun findAllWith(offset: Int, limit: Int, title: String): List<Movie>

    @Query(value = COUNT_QUERY, nativeQuery = true)
    fun countAllWith(title: String): Long

    fun findByTitle(title: String): Movie?
    fun save(movie: Movie): Movie
}