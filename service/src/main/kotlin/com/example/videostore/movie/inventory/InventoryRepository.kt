package com.example.videostore.movie.inventory

import com.example.videostore.movie.Movie
import org.springframework.data.repository.Repository
import java.util.*

interface InventoryRepository : Repository<Inventory, UUID> {
    fun findByMovie(movie: Movie): Inventory?
    fun save(inventory: Inventory): Inventory
}