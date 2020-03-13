package com.example.videostore.user

import org.springframework.data.repository.Repository
import java.util.*

interface UserRepository : Repository<User, UUID> {
    fun findByUuid(uuid: UUID): User?
    fun findByEmail(email: String): User?
    fun save(user: User): User
}