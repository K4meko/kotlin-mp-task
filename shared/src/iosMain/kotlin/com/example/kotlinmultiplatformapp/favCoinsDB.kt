package com.example.kotlinmultiplatformapp
import app.cash.sqldelight.db.SqlDriver
import app.cash.sqldelight.driver.native.NativeSqliteDriver
import com.crypto.database.Database
import com.crypto.database.FavCoin
import com.crypto.database.FavCoinQueries
import com.crypto.sqldelight.TestQueries
import com.crypto.sqldelight.Test




actual class DriverFactory {
    actual fun createDriver(): SqlDriver {
        println("schema: ${Database.Schema}")
        return NativeSqliteDriver(Database.Schema, "test.db")
    }
}

class LocalDatabase {
    private val driverFactory = DriverFactory()
    private val database = createDatabase(driverFactory)
    private val favCoinQueries: FavCoinQueries = database.favCoinQueries
    private val testQueries = database.testQueries

    fun testDelete(){
        testQueries.deleteAll()
    }
    fun testSelect(): List<Test> {
        return testQueries.selectAll().executeAsList()
    }
    fun testInsert(id: String, name: String, image: String, current_price: Double, high_24h: Double, low_24h: Double){
      testQueries.insert(id, name, image, current_price, high_24h, low_24h)
    }
    fun getFavCoins(): List<FavCoin> {
        return favCoinQueries.selectAll().executeAsList()
    }

    fun insertFavCoin(coin_id: String, coin_name: String) {
        try {
            favCoinQueries.insert(coin_id, coin_name)
        }
        catch (e: Exception){
            print(e)
        }
    }

    fun deleteFavCoin(coin_id: String) {
        favCoinQueries.delete(coin_id)
    }
}
