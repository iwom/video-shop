package com.example.videostore.security.userDetails

import com.example.videostore.user.User
import com.fasterxml.jackson.annotation.JsonIgnore
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails
import java.util.*

class UserDetailsImpl(
    val id: UUID,
    private val username: String,
    val email: String,

    @JsonIgnore
    private val password: String,
    private val authorities: Collection<GrantedAuthority>
) : UserDetails {

    override fun getAuthorities(): Collection<GrantedAuthority> {
        return authorities
    }

    override fun getPassword(): String {
        return password
    }

    override fun getUsername(): String {
        return username
    }

    override fun isAccountNonExpired(): Boolean {
        return true
    }

    override fun isAccountNonLocked(): Boolean {
        return true
    }

    override fun isCredentialsNonExpired(): Boolean {
        return true
    }

    override fun isEnabled(): Boolean {
        return true
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || javaClass != other.javaClass) return false
        val user = other as UserDetailsImpl
        return id == user.id
    }

    companion object {
        private const val serialVersionUID = 1L
        fun build(user: User): UserDetailsImpl {
            val authorities: List<GrantedAuthority> = listOf(SimpleGrantedAuthority(user.role.name))

            return UserDetailsImpl(
                user.id,
                user.username,
                user.email,
                user.password,
                authorities
            )
        }
    }
}