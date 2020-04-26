package com.example.videostore.user

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "users")
data class User(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Enumerated(EnumType.STRING)
    val role: Role = Role.USER,

    @Column(unique = true)
    val username: String = "",

    @Column(unique = true)
    val email: String = "",
    @JsonIgnore
    val password: String = ""
) {

    enum class Role {
        USER,
        ADMIN
    }
}