package com.example.videostore.User

import com.example.videostore.infrastructure.ServiceException
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import java.util.*

@Service
class UserService(
    val userRepository: UserRepository
) {
    fun getUserByUUID(uuid: UUID): User = userRepository.findByUuid(uuid)
            ?: throw ServiceException(HttpStatus.NOT_FOUND, "User with UUID: $uuid not found")

    fun getUserByEmail(email: String): User = userRepository.findByEmail(email)
            ?: throw ServiceException(HttpStatus.NOT_FOUND, "User with email: $email not found")

    fun addUser(user: User): User = userRepository.save(user)
}