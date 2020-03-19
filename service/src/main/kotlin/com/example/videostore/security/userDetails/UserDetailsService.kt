package com.example.videostore.security.userDetails

import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UsernameNotFoundException

interface UserDetailsService {
    fun loadUserByUsername(username: String): UserDetails
}
