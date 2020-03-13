package com.example.videostore.User

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "users")
data class User(
    @Id
    val uuid: UUID = UUID.randomUUID(),

    @Enumerated(EnumType.STRING)
    val role: Role,

    @Column(unique = true)
    val email: String,
    val password: String
) {

    enum class Role {
        USER,
        ADMIN
    }
}