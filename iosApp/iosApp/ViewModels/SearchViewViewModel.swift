import Foundation
import shared

class SearchViewViewModel: ObservableObject {
    @Published var favCoins: [FavCoin] = LocalDatabase().getFavCoins()
    @Published var dataIsEmpty = false
    @Published var searchText = ""
    {
        didSet{
            getSearchJson()
        }
    }
    private var debounce_timer:Timer?
    @Published var searchCoinData: ApiResponse? = nil
    
    func isFav(coinId: String) -> Bool{
        for i in favCoins{
            if i.coin_id == coinId{
                print(coinId)
                return true
            }
        }
        return false
    }
    
    func addFav(coinId: String, coinName: String){
    LocalDatabase().insertFavCoin(coin_id: coinId, coin_name: coinName)
    favCoins = LocalDatabase().getFavCoins()
    print(favCoins)
   
    }
    func removeFav(coinId: String){
        LocalDatabase().deleteFavCoin(coin_id: coinId)
        favCoins = LocalDatabase().getFavCoins()
    }

    func getSearchJson() {
        
           
            
        if self.searchText.count > 2 && self.searchText.count < 9 {
            debounce_timer?.invalidate()
            debounce_timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [self] _ in
            Greeting().getSearch(query: searchText){data, error in
                guard let data = data else{
                    return
                }
                Task.detached{ @MainActor in
                    self.searchCoinData = data
                    if (self.searchCoinData == ApiResponse(coins: [], exchanges: [], icos: [], categories: [], nfts: [])){
                        self.dataIsEmpty = true
                        
                    }
                    else{
                        self.dataIsEmpty = false
                    }
                }
            }
        }
            }
            else{
                self.searchCoinData = nil
            }
        
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

