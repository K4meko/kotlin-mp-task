package com.example.kotlinmultiplatformapp

import app.cash.sqldelight.db.SqlDriver
import com.crypto.database.Database
import com.crypto.database.FavCoin
import com.crypto.database.FavCoinQueries


expect class DriverFactory {
    fun createDriver(): SqlDriver
}


fun createDatabase(driverFactory: DriverFactory): Database {
    val driver = driverFactory.createDriver()
    val database = Database(driver)
    return database
}