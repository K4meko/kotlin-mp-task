package com.example.kmmktor

import ApiResponse
import CoinResponse
import com.example.kotlinmultiplatformapp.Models.FavCoin
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.HttpHeaders
import io.ktor.http.isSuccess
import kotlinx.serialization.json.Json

class ApiCalls {
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
//        println("kotlin log:")
//        println(coinResponse)
        return response.bodyAsText()
    }
    suspend fun getFav(favCoins_ids: List<String>): List<FavCoin>{
        if (favCoins_ids.isEmpty()){
            return emptyList()
        }
        val query = favCoins_ids.joinToString("%2C")
        print(query)
        val response =
        client.get("https://api.coingecko.com/api/v3/coins/markets?vs_currency=czk&ids=$query") {
            headers {
                append(HttpHeaders.Authorization, "CG-eXyDCd2qaufFfBCbuXsoKYG6")
            }
        }
        var json = Json { ignoreUnknownKeys = true }
        if (!response.status.isSuccess()) {
            println("API request failed with status: ${response.status}")
            return emptyList()
        }
        if(response.bodyAsText().isEmpty()){
            return emptyList()
        }
        val favCoins = json.decodeFromString<List<FavCoin>>(response.bodyAsText())
        println("kotlin log:")
        println(favCoins)
        return favCoins
    }
    suspend fun getSearch(query: String): ApiResponse{
        val response =
        client.get("https://api.coingecko.com/api/v3/search?query=$query"){
            headers {
                append(HttpHeaders.Authorization, "CG-eXyDCd2qaufFfBCbuXsoKYG6")
            }
        }
        if (!response.status.isSuccess()) {
            println("API request failed with status: ${response.status}")
            return ApiResponse(emptyList(), emptyList(), emptyList(), emptyList(), emptyList())
        }
        val coinsResponse = Json.decodeFromString(ApiResponse.serializer(), response.bodyAsText())
        //println("kotlin log:")
       // println(coinsResponse)
      return coinsResponse
    }
}