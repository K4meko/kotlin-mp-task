package com.example.kmmktor

import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.client.utils.EmptyContent.headers
import io.ktor.http.HttpHeaders


class Greeting {
    private val client = HttpClient()

    suspend fun greeting(): String {
        val response =
        client.get("https://api.coingecko.com/api/v3/search/trending") {
            headers {
                append(HttpHeaders.Authorization, "CG-eXyDCd2qaufFfBCbuXsoKYG6")
            }
        }
        return response.bodyAsText()
    }
}
