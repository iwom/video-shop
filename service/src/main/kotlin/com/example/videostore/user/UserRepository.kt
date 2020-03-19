package com.example.videostore.user

import org.springframework.data.repository.Repository
import java.util.*

interface UserRepository : Repository<User, UUID> {
    fun findById(id: UUID): User?
    fun findByUsername(username: String): User?
    fun findByEmail(email: String): User?
    fun save(user: User): User
}