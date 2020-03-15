package com.example.videostore.infrastructure

import org.springframework.http.HttpStatus

class ServiceException(
    val httpStatus: HttpStatus = HttpStatus.INTERNAL_SERVER_ERROR,
    val body: ResponseTemplate
) : RuntimeException(body.message) {
    constructor(httpStatus: HttpStatus, body: String) : this(httpStatus, ResponseTemplate(httpStatus.toString(), body))
}

data class ResponseTemplate(val code: String, val message: String)