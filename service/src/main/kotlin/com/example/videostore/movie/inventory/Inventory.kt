package com.example.videostore.movie.inventory

import com.example.videostore.movie.Movie
import com.fasterxml.jackson.annotation.JsonIgnore
import java.io.Serializable
import java.util.*
import javax.persistence.*

@Entity
@IdClass(InventoryToMovie::class)
data class Inventory(
    @Id
    @Column(columnDefinition = "uuid", updatable = false)
    val id: UUID = UUID.randomUUID(),

    val value: Int = 0,

    @Id
    @OneToOne(cascade = [CascadeType.ALL])
    @JsonIgnore
    val movie: Movie = Movie()
)

class InventoryToMovie(
    val id: UUID = UUID.randomUUID(),
    val movie: UUID = UUID.randomUUID()
) : Serializable