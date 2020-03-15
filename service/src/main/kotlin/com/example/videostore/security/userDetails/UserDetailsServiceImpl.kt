package com.example.videostore.security.userDetails

import com.example.videostore.user.User
import com.example.videostore.user.UserService
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class UserDetailsServiceImpl(
    val userService: UserService
) : UserDetailsService, org.springframework.security.core.userdetails.UserDetailsService {

    @Transactional
    override fun loadUserByUsername(username: String): UserDetails {
        val user: User = userService.getUserByUsername(username)

        return UserDetailsImpl.build(user)
    }
}
