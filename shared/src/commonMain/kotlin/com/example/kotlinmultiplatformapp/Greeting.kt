package com.example.kmmktor

import ApiResponse
import CoinResponse
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.client.utils.EmptyContent.headers
import io.ktor.http.HttpHeaders
import io.ktor.http.isSuccess
import kotlinx.serialization.json.Json

class Greeting {
    private val client = HttpClient()

    suspend fun getTrending(): String {
        val response =
        client.get("https://api.coingecko.com/api/v3/search/trending") {
            headers {
                append(HttpHeaders.Authorization, "CG-eXyDCd2qaufFfBCbuXsoKYG6")
            }
        }
        var json = Json { ignoreUnknownKeys = true }
        val coinResponse = json.decodeFromString<CoinResponse>(response.bodyAsText())
        println("kotlin log:")
        println(coinResponse)
        return response.bodyAsText()
    }
    suspend fun getSearch(query: String): ApiResponse{
        val response =
        client.get("https://api.coingecko.com/api/v3/search?query=$query"){
            headers {
                append(HttpHeaders.Authorization, "CG-eXyDCd2qaufFfBCbuXsoKYG6")
            }
        }
        if (!response.status.isSuccess()) {
            // Handle the case where the request was not successful
            println("API request failed with status: ${response.status}")
            // Return a default or empty ApiResponse object
            return ApiResponse(emptyList(), emptyList(), emptyList(), emptyList(), emptyList())
        }
        val coinsResponse = Json.decodeFromString(ApiResponse.serializer(), response.bodyAsText())
        println("kotlin log:")
        println(coinsResponse)
      return coinsResponse
    }
}
