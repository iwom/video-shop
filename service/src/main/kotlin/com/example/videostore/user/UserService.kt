package com.example.videostore.user

import com.example.videostore.infrastructure.ServiceException
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import java.util.*

@Service
class UserService(
    val userRepository: UserRepository
) {
    fun getUserById(id: UUID): User = userRepository.findById(id)
            ?: throw ServiceException(HttpStatus.NOT_FOUND, "User with id: $id not found")

    fun getUserByEmail(email: String): User = userRepository.findByEmail(email)
            ?: throw ServiceException(HttpStatus.NOT_FOUND, "User with email: $email not found")

    private fun addUser(user: User): User = userRepository.save(user)
}