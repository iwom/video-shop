package com.example.videostore.movie

import org.hibernate.validator.constraints.URL
import java.io.Serializable
import java.math.BigDecimal
import java.util.*
import javax.persistence.*
import javax.validation.constraints.NotBlank

@Entity
data class Movie(
    @Id
    @Column(columnDefinition = "uuid", updatable = false)
    val id: UUID = UUID.randomUUID(),

    @NotBlank
    val title: String = "Default title",
    val year: String = "",
    val runtime: String = "",
    val genre: String = "",
    val director: String = "",

    @Column(columnDefinition = "TEXT")
    val actors: String = "",

    @Column(columnDefinition = "TEXT")
    val plot: String = "",

    @Column(columnDefinition = "TEXT")
    @URL(regexp = "^(http:\\/\\/www\\.|https:\\/\\/www\\.|https:\\\\/)?[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?\$")
    val poster: String = "",

    @ElementCollection
    val ratings: MutableSet<Rating> = mutableSetOf(),

    @Column(columnDefinition = "NUMERIC (4,2)")
    val price: BigDecimal = BigDecimal(39.99)
) : Serializable

@Embeddable
data class Rating(
    val source: String = "",
    val value: String = ""
)