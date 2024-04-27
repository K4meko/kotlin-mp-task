package com.example.kotlinmultiplatformapp

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform