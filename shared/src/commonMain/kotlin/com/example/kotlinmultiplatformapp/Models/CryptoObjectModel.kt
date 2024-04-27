//import kotlinx.serialization.*
//import kotlinx.serialization.json.*
//
//@Serializable
//data class ResponseData(
//    val coins: List<CoinItem>,
//    val nfts: List<NFTItem>,
//    val categories: List<Category>
//)
//
//@Serializable
//data class CoinItem(
//    val item: Coin
//)
//
//@Serializable
//data class Coin(
//    val id: String,
//    val coinId: Int?,
//    val name: String,
//    val symbol: String,
//    val marketCapRank: Int?,
//    val thumb: String,
//    val small: String,
//    val large: String,
//    val slug: String,
//    val priceBtc: Double?,
//    val score: Int,
//    val data: CoinData
//)
//
//@Serializable
//data class CoinData(
//    val price: Double,
//    val priceBtc: String?,
//    val priceChangePercentage24h: Map<String, Double>?,
//    val marketCap: String?,
//    val marketCapBtc: String?,
//    val totalVolume: String?,
//    val totalVolumeBtc: String?,
//    val sparkline: String?,
//    val content: Content?
//)
//
//@Serializable
//data class Content(
//    val title: String?,
//    val description: String?
//)
//
//@Serializable
//data class NFTItem(
//    val id: String,
//    val name: String,
//    val symbol: String,
//    val thumb: String,
//    val nftContractId: Int?,
//    val nativeCurrencySymbol: String?,
//    val floorPriceInNativeCurrency: Double?,
//    val floorPrice24hPercentageChange: Double?,
//    val data: NFTData
//)
//
//@Serializable
//data class NFTData(
//    val floorPrice: String?,
//    val floorPriceInUsd24hPercentageChange: String?,
//    val h24Volume: String?,
//    val h24AverageSalePrice: String?,
//    val sparkline: String?
//)
//
//@Serializable
//data class Category(
//    val id: Int,
//    val name: String,
//    val marketCap1hChange: Double?,
//    val slug: String?,
//    val coinsCount: Int?,
//    val data: CategoryData
//)
//
//@Serializable
//data class CategoryData(
//    val marketCap: String?,
//    val marketCapBtc: Double?,
//    val totalVolume: Double?,
//    val totalVolumeBtc: Double?,
//    val marketCapChangePercentage24h: Map<String, Double>?,
//    val sparkline: String?
//)
