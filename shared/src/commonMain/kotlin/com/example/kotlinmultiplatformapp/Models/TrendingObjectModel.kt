import kotlinx.serialization.Serializable
@Serializable
data class Category(
    val id: Int,
    val name: String
)
@Serializable
data class Content(
    val title: String,
    val description: String
)
@Serializable
data class NFT(
    val id: String,
    val name: String,
    val symbol: String,
    val thumb: String
)
//@Serializable
//data class Category2(
//    val id: Int,
//    val name: String,
//    val market_cap_1h_change: Double?,
//    val slug: String?,
//    val coins_count: Int?,
//    val data: CategoryData?
//)
//@Serializable
//data class NFT(
//    val id: String,
//    val name: String,
//    val symbol: String,
//    val thumb: String,
//    val nft_contract_id: Int?,
//    val native_currency_symbol: String?,
//    val floor_price_in_native_currency: Int?,
//    val floor_price_24h_percentage_change: Double?,
//    val data: NFTData?
//)


@Serializable
data class PriceChangePercentage24h(
    val aed: Double,
    val ars: Double,
    val aud: Double,
    val bch: Double,
    val bdt: Double,
    val bhd: Double,
    val bmd: Double,
    val bnb: Double,
    val brl: Double,
    val btc: Double,
    val cad: Double,
    val chf: Double,
    val clp: Double,
    val cny: Double,
    val czk: Double,
    val dkk: Double,
    val dot: Double,
    val eos: Double,
    val eth: Double,
    val eur: Double,
    val gbp: Double,
    val gel: Double,
    val hkd: Double,
    val huf: Double,
    val idr: Double,
    val ils: Double,
    val inr: Double,
    val jpy: Double,
    val krw: Double,
    val kwd: Double,
    val lkr: Double,
    val ltc: Double,
    val mmk: Double,
    val mxn: Double,
    val myr: Double,
    val ngn: Double,
    val nok: Double,
    val nzd: Double,
    val php: Double,
    val pkr: Double,
    val pln: Double,
    val rub: Double,
    val sar: Double,
    val sek: Double,
    val sgd: Double,
    val thb: Double,
    val `try`: Double?,
    val twd: Double,
    val uah: Double,
    val usd: Double,
    val vef: Double,
    val vnd: Double,
    val xag: Double,
    val xau: Double,
    val xdr: Double,
    val xlm: Double,
    val xrp: Double,
    val yfi: Double,
    val zar: Double,
    val bits: Double,
    val link: Double,
    val sats: Double
)
@Serializable

data class CoinData(
    val price: Double,
    val price_btc: String,
    val price_change_percentage_24h: PriceChangePercentage24h?,
    val market_cap: String,
    val market_cap_btc: String,
    val total_volume: String,
    val total_volume_btc: String,
    val sparkline: String?,
    val content: Content? // Assuming content can be of any type
)
@Serializable

data class Item(
    val id: String,
    val coin_id: Int,
    val name: String,
    val symbol: String,
    val market_cap_rank: Int,
    val thumb: String,
    val small: String,
    val large: String,
    val slug: String,
    val price_btc: Double,
    val score: Int,
    val data: CoinData
)
@Serializable

data class CoinItem(
    val item: Item
)

@Serializable
data class NFTData(
    val floor_price: String,
    val floor_price_in_usd_24h_percentage_change: String,
    val h24_volume: String,
    val h24_average_sale_price: String,
    val sparkline: String?,
    val content: String? // Assuming content can be of any type
)


@Serializable
data class CategoryData(
    val market_cap: Double,
    val market_cap_btc: Double,
    val total_volume: Double,
    val total_volume_btc: Double,
    val market_cap_change_percentage_24h: PriceChangePercentage24h,
    val sparkline: String
)

//
@Serializable
data class CoinResponse(
    val coins: List<CoinItem>,
    val nfts: List<NFT>,
    val categories: List<Category>
)
