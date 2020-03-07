package com.example.videostore

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
open class VideostoreApplication

fun main(args: Array<String>) {
    runApplication<VideostoreApplication>(*args)
}
