package com.example.videostore.security.dto

import javax.validation.constraints.Email
import javax.validation.constraints.Size

data class SignupDTO(
    @Size(min = 3, max = 20)
    var username: String,

    @Size(max = 50)
    @Email
    var email: String,

    @Size(min = 6, max = 40)
    var password: String
)
