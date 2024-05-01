package com.example.kotlinmultiplatformapp.Models
import kotlinx.serialization.Serializable

@Serializable
data class ChartData(
    val prices: List<List<Double>>?
)
//@Serializable
//data class Prices(
//    val prices: List<Double?>
//)