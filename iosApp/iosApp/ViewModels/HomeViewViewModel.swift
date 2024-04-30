import Foundation
import shared

class HomeViewViewModel: ObservableObject {

  
    @Published var text = "Loading..."
    @Published var trendingCoinData: ResponseData? = nil
    @Published var searchCoinData : ResponseData? = nil
    @Published var btc_price: String? = nil
    init() {
       
        Greeting().getTrending  { [self] data, error in
            
        if let data = data{
            Task.detached { @MainActor in
                self.trendingCoinData = self.parseJson(json: data)
            }}}
        
    }
 

    func parseJson(json: String) -> ResponseData{
        if let jsonData = json.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
                let responseData = try decoder.decode(ResponseData.self, from: jsonData)
                return responseData
            }
            catch DecodingError.keyNotFound(let key, let context) {
                print("Failed to decode JSON due to missing key '\(key.stringValue)' in the JSON data - \(context.debugDescription)")
            } catch {
                print("Failed to decode JSON: \(error)")
            }
            }
        return ResponseData(coins: [], nfts: [], categories: [])
    }
}

let jsonString = """
{
    "coins": [
        {
            "item": {
                "id": "bitcoin",
                "coinId": 1,
                "name": "Bitcoin",
                "symbol": "BTC",
                "marketCapRank": 1,
                "thumb": "https://example.com/thumb/btc.png",
                "small": "https://example.com/small/btc.png",
                "large": "https://example.com/large/btc.png",
                "slug": "bitcoin",
                "priceBtc": 1.0,
                "score": 10,
                "data": {
                    "price": 40000.00,
                    "priceBtc": "1.0",
                    "priceChangePercentage24h": {
                        "usd": -0.5
                    },
                    "marketCap": "$800 billion",
                    "marketCapBtc": "20000000",
                    "totalVolume": "$40 billion",
                    "totalVolumeBtc": "1000000",
                    "sparkline": "https://example.com/sparkline/btc.svg",
                    "content": {
                        "title": "Bitcoin Cryptocurrency",
                        "description": "Bitcoin is a cryptocurrency invented in 2008."
                    }
                }
            }
        },
        {
            "item": {
                "id": "bitcoi",
                "coinId": 1,
                "name": "Bitcoin",
                "symbol": "BTC",
                "marketCapRank": 1,
                "thumb": "https://example.com/thumb/btc.png",
                "small": "https://example.com/small/btc.png",
                "large": "https://example.com/large/btc.png",
                "slug": "bitcoin",
                "priceBtc": 1.0,
                "score": 10,
                "data": {
                    "price": 40000.00,
                    "priceBtc": "1.0",
                    "priceChangePercentage24h": {
                        "usd": -0.5
                    },
                    "marketCap": "$800 billion",
                    "marketCapBtc": "20000000",
                    "totalVolume": "$40 billion",
                    "totalVolumeBtc": "1000000",
                    "sparkline": "https://example.com/sparkline/btc.svg",
                    "content": {
                        "title": "Bitcoin Cryptocurrency",
                        "description": "Bitcoin is a cryptocurrency invented in 2008."
                    }
                }
            }
        },
        {
            "item": {
                "id": "bitco",
                "coinId": 1,
                "name": "Bitcoin",
                "symbol": "BTC",
                "marketCapRank": 1,
                "thumb": "https://example.com/thumb/btc.png",
                "small": "https://example.com/small/btc.png",
                "large": "https://example.com/large/btc.png",
                "slug": "bitcoin",
                "priceBtc": 1.0,
                "score": 10,
                "data": {
                    "price": 40000.00,
                    "priceBtc": "1.0",
                    "priceChangePercentage24h": {
                        "usd": -0.5
                    },
                    "marketCap": "$800 billion",
                    "marketCapBtc": "20000000",
                    "totalVolume": "$40 billion",
                    "totalVolumeBtc": "1000000",
                    "sparkline": "https://example.com/sparkline/btc.svg",
                    "content": {
                        "title": "Bitcoin Cryptocurrency",
                        "description": "Bitcoin is a cryptocurrency invented in 2008."
                    }
                }
            }
        }
    ],
    "nfts": [
        {
            "id": "unique",
            "name": "Unique Art",
            "symbol": "UNQ",
            "thumb": "https://example.com/thumb/nft.png",
            "nftContractId": 123,
            "nativeCurrencySymbol": "ETH",
            "floorPriceInNativeCurrency": 2.5,
            "floorPrice24hPercentageChange": 1.2,
            "data": {
                "floorPrice": "2.5 ETH",
                "floorPriceInUsd24hPercentageChange": "3.0",
                "h24Volume": "50 ETH",
                "h24AverageSalePrice": "2.5 ETH",
                "sparkline": "https://example.com/sparkline/nft.svg"
            }
        }
    ],
    "categories": [
        {
            "id": 1,
            "name": "Top Market Caps",
            "marketCap1hChange": 0.2,
            "slug": "top-market-caps",
            "coinsCount": 10,
            "data": {
                "marketCap": "$900 billion",
                "marketCapBtc": 22000000,
                "totalVolume": 10000000,
                "totalVolumeBtc": 250000,
                "marketCapChangePercentage24h": {
                    "usd": 0.1
                },
                "sparkline": "https://example.com/sparkline/category.svg"
            }
        }
    ]
}
"""
