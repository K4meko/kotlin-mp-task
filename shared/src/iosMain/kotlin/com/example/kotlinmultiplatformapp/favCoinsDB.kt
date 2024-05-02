package com.example.kotlinmultiplatformapp
import app.cash.sqldelight.db.SqlDriver
import app.cash.sqldelight.driver.native.NativeSqliteDriver
import com.crypto.database.Database
import com.crypto.database.FavCoin
import com.crypto.database.FavCoinQueries
import com.crypto.database.FavCoinData
import com.crypto.database.FavCoinDataQueries



actual class DriverFactory {
    actual fun createDriver(): SqlDriver {
        return NativeSqliteDriver(Database.Schema, "test.db")
    }
}

class LocalDatabase {
    private val driverFactory = DriverFactory()
    private val database = createDatabase(driverFactory)
    private val favCoinQueries: FavCoinQueries = database.favCoinQueries
    private val favCoinDataQueries: FavCoinDataQueries = database.favCoinDataQueries
    fun getFavCoinsData(): List<FavCoinData>{
        return favCoinDataQueries.selectAll().executeAsList()
    }
    fun saveFavCoinsData(id: String, name: String, symbol: String, image: String, currentPrice: Double,
                         fullyDilutedValuation: Double,
                         total_volume: Double,
                         high_24h: Double,
                         low_24h: Double,
                         price_change_24h: Double,
                         price_change_percentage_24h: Double,
                         total_supply: Double,
                         max_supply: Double,
                         last_updated: String){
        favCoinDataQueries.insert(id, name, symbol, image, currentPrice, fullyDilutedValuation, total_volume, high_24h, low_24h, price_change_24h, price_change_percentage_24h, total_supply, max_supply, last_updated)
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
