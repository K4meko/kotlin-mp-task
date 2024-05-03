package com.example.kmmktor

import ApiResponse
import CoinResponse
import com.example.kotlinmultiplatformapp.Models.ChartData
import com.example.kotlinmultiplatformapp.Models.FavCoin
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.HttpHeaders
import io.ktor.http.isSuccess
import kotlinx.serialization.json.Json
import io.ktor.http.content.*

class ApiCalls {
    private val client = HttpClient()

    suspend fun getTrending(): String {
        try{
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
        catch(e: Exception){
            print(e)
            return ""
        }

    }
    suspend fun getFav(favCoins_ids: List<String>): List<FavCoin>{

        if (favCoins_ids.isEmpty()){
            return emptyList()
        }
        try {
            val query = favCoins_ids.joinToString("%2C")
            // print(query)
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
            if (response.bodyAsText().isEmpty()) {
                return emptyList()
            }
            val favCoins = json.decodeFromString<List<FavCoin>>(response.bodyAsText())
            // println("kotlin log:")
            //println(favCoins)
            return favCoins
        }
        catch(e: Exception){
            print("kotlin exception:")
            print(e)
            return emptyList()
        }
    }
    suspend fun getSearch(query: String): ApiResponse{
        try{
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
      return coinsResponse}
        catch (e: Exception){
            print(e)
            return ApiResponse(emptyList(), emptyList(), emptyList(), emptyList(), emptyList())
        }
    }
    suspend fun getChartData(favId: String): ChartData{
        println("test")

        try{

        val response =
            client.get("https://api.coingecko.com/api/v3/coins/$favId/market_chart?vs_currency=czk&days=5&interval=daily") {
                headers {
                    append(HttpHeaders.Authorization, "CG-eXyDCd2qaufFfBCbuXsoKYG6")
                }
            }
            if (!response.status.isSuccess()) {
                println("API request failed with status: ${response.status}")
                return ChartData(emptyList())
            }

        val body = response

        var json = Json { ignoreUnknownKeys = true }
        val coinsResponse = json.decodeFromString(ChartData.serializer(), response.bodyAsText())
        return coinsResponse
        }
    catch (e: Exception){
        println("API request failed with exception: $e")
        return ChartData(emptyList())
    }}
}
