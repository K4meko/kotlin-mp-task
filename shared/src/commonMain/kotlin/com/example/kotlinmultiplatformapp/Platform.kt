package com.example.kotlinmultiplatformapp

import com.example.kotlinmultiplatformapp.Models.ChartData

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform

