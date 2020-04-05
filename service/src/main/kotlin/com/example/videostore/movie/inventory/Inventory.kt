package com.example.videostore.movie.inventory

import com.example.videostore.movie.Movie
import java.io.Serializable
import java.util.*
import javax.persistence.*

@Entity
@IdClass(InventoryToMovie::class)
data class Inventory(
    @Id
    @Column(columnDefinition = "uuid", updatable = false)
    val id: UUID = UUID.randomUUID(),

    val value: Int = 10,

    @Id
    @OneToOne
    val movie: Movie = Movie()
)

class InventoryToMovie(
    val id: UUID = UUID.randomUUID(),
    val movie: UUID = UUID.randomUUID()
) : Serializable