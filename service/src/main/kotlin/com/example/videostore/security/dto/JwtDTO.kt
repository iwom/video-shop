package com.example.videostore.security.dto

data class JwtDTO(
    val tokenType: String = "Bearer",
    val accessToken: String,
    val userId: String,
    val username: String,
    val email: String,
    val roles: List<String>
)