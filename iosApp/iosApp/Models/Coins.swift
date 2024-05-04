import Foundation

struct ResponseData: Codable {
    var coins: [CoinItem]
    var nfts: [NFTItem]
    var categories: [Category]
}

struct CoinItem: Codable {
    let item: Coin
}

struct Coin: Codable {
    let id: String
    let coinId: Int?
    let name: String
    let symbol: String
    let marketCapRank: Int?
    let thumb: URL
    let small: URL
    let large: URL
    let slug: String
    var priceBtc: Double?
    let score: Int
    let data: CoinData

    enum CodingKeys: String, CodingKey {
        case id, coinId, name, symbol, marketCapRank, thumb, small, large, slug, score, data
        case priceBtc = "price_btc" 
    }
}

struct CoinData: Codable {
    let price: Double
    let priceBtc: String?
    let priceChangePercentage24h: [String: Double]?
    let marketCap: String?
    let marketCapBtc: String?
    let totalVolume: String?
    let totalVolumeBtc: String?
    let sparkline: URL?
    let content: Content?

    enum CodingKeys: String, CodingKey {
        case price, marketCap, totalVolume, sparkline, content
        case priceBtc = "price_btc"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapBtc = "market_cap_btc"
        case totalVolumeBtc = "total_volume_btc"
    }
}

struct Content: Codable {
    let title: String?
    let description: String?
}

struct NFTItem: Codable {
    let id: String
    let name: String
    let symbol: String
    let thumb: URL
    let nftContractId: Int?
    let nativeCurrencySymbol: String?
    let floorPriceInNativeCurrency: Double?
    let floorPrice24hPercentageChange: Double?
    let data: NFTData
}

struct NFTData: Codable {
    let floorPrice: String?
    let floorPriceInUsd24hPercentageChange: String?
    let h24Volume: String?
    let h24AverageSalePrice: String?
    let sparkline: URL?
}
struct Category: Codable {
    let id: Int
    let name: String
    let marketCap1hChange: Double?
    let slug: String?
    let coinsCount: Int?
    let data: CategoryData
}

struct CategoryData: Codable {
    let marketCap: String?
    let marketCapBtc: Double?
    let totalVolume: Double?
    let totalVolumeBtc: Double?
    let marketCapChangePercentage24h: [String: Double]?
    let sparkline: URL?
}
