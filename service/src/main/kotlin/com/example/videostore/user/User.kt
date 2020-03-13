package com.example.videostore.user

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "users")
data class User(
    @Id
    val uuid: UUID = UUID.randomUUID(),

    @Enumerated(EnumType.STRING)
    val role: Role = Role.USER,

    @Column(unique = true)
    val email: String,
    val password: String
) {

    enum class Role {
        USER,
        ADMIN
    }
}