package com.example.kotlinmultiplatformapp
import app.cash.sqldelight.db.SqlDriver
import app.cash.sqldelight.driver.native.NativeSqliteDriver
import com.crypto.database.Database
import com.crypto.database.FavCoin
import com.crypto.database.FavCoinQueries



actual class DriverFactory {
    actual fun createDriver(): SqlDriver {
        return NativeSqliteDriver(Database.Schema, "test.db")
    }
}

class LocalDatabase {
    private val driverFactory = DriverFactory()
    private val database = createDatabase(driverFactory)
    private val favCoinQueries: FavCoinQueries = database.favCoinQueries

    fun getFavCoins(): List<FavCoin> {
        return favCoinQueries.selectAll().executeAsList()
    }

    fun insertFavCoin(coin_id: String, coin_name: String) {
        favCoinQueries.insert(coin_id, coin_name)
    }

    fun deleteFavCoin(coin_id: String) {
        favCoinQueries.delete(coin_id)
    }
}
