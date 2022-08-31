package com.example

import org.springframework.beans.factory.annotation.Value
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/v1")
class SampleController(
    @Value("\${MY_FIRST_NAME}") val firstName: String,
    @Value("\${MY_LAST_NAME}") val lastName: String
) {

    @GetMapping("/my-first-name")
    fun getMyFirstName() = Response(firstName)

    @GetMapping("/my-last-name")
    fun getMyLastName() = Response(lastName)

    @GetMapping("/health")
    fun health() = Response("healthy")
}

data class Response(
    val value: String
)