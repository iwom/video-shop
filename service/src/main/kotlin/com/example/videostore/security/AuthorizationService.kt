package com.example.videostore.security

import com.example.videostore.security.userDetails.UserDetailsImpl
import com.example.videostore.user.UserService
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Service

@Service
class AuthorizationService(
    private val userService: UserService
) {
    fun getCurrentUser() = (SecurityContextHolder.getContext().authentication.principal as UserDetailsImpl)
        .let { userService.getUserById(it.id) }
}