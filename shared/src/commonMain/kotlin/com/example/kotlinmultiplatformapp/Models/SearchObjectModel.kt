import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Coin(
    val id: String,
    val name: String,
    @SerialName("api_symbol")
    val apiSymbol: String,
    val symbol: String,
    @SerialName("market_cap_rank")
    val marketCapRank: Int?,
    val thumb: String,
    val large: String
)
@Serializable
data class NFT(
    val id: String,
    val name: String,
    val symbol: String,
    val thumb: String
)
@Serializable
data class Category(
    val id: Int,
    val name: String
)
@Serializable
data class Exchange(
    val id: String,
    val name: String,
    @SerialName("market_type")
    val marketType: String,
    val thumb: String,
    val large: String
)


@Serializable
data class ApiResponse(
    val coins: List<Coin>,
    val exchanges: List<Exchange>,
    val icos: List<String>,
    val categories: List<Category>,
    val nfts: List<NFT>,
)
