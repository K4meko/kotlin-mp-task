import Foundation
import shared

class SearchViewViewModel: ObservableObject {
    @Published var dataIsEmpty = false
    @Published var searchText = "" {
        didSet{
            getSearchJson()
        }
    }
   
    @Published var searchCoinData: ApiResponse? = nil

    func getSearchJson() {
        if searchText.count > 3 && searchText.count < 9 {
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
                    print("swift log")
                    
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

