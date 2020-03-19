package com.example.videostore.security

import com.example.videostore.security.dto.JwtDTO
import com.example.videostore.security.dto.LoginDTO
import com.example.videostore.security.dto.SignupDTO
import com.example.videostore.security.jwt.JwtUtils
import com.example.videostore.security.userDetails.UserDetailsImpl
import com.example.videostore.user.User
import com.example.videostore.user.UserService
import org.springframework.http.HttpStatus
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.web.bind.annotation.*
import java.util.stream.Collectors
import javax.validation.Valid

@CrossOrigin(origins = ["*"], maxAge = 3600)
@RestController
@RequestMapping("/auth")
class AuthController(
    val authenticationManager: AuthenticationManager,
    val userService: UserService,
    val jwtUtils: JwtUtils
) {
    companion object {
        val encoder: BCryptPasswordEncoder = BCryptPasswordEncoder()
    }

    @PostMapping("/signin")
    fun authenticateUser(@RequestBody loginRequest: @Valid LoginDTO): JwtDTO {
        val authentication: Authentication = authenticationManager.authenticate(
            UsernamePasswordAuthenticationToken(loginRequest.username, loginRequest.password)
        )

        SecurityContextHolder.getContext().authentication = authentication
        val jwt = jwtUtils.generateJwtToken(authentication)
        val userDetails = authentication.principal as UserDetailsImpl
        val roles = userDetails.authorities.stream()
            .map { item: GrantedAuthority -> item.authority }
            .collect(Collectors.toList())

        return JwtDTO(
            accessToken = jwt,
            userId = userDetails.id.toString(),
            username = userDetails.username,
            email = userDetails.email,
            roles = roles
        )
    }

    @PostMapping("/signup")
    @ResponseStatus(HttpStatus.CREATED)
    fun registerUser(@RequestBody signUpRequest: @Valid SignupDTO) {

        userService.addUser(
            User(
                username = signUpRequest.username,
                email = signUpRequest.email,
                password = encoder.encode(signUpRequest.password)
            )
        )
    }
}