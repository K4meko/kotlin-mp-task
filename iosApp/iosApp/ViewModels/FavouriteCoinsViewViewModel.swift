import Foundation
import shared

class FavouriteCoinsViewViewModel: ObservableObject{
    @Published var FavCoinData: [FavCoin_] = []
    @Published var favCoinIds: [String] = []
    init(){
       
     //   getFavDetails()
    }
 
    
    func getFavDetails(){
        for i in LocalDatabase().getFavCoins(){
            favCoinIds.append(i.coin_id)
        }
        ApiCalls().getFav(favCoins_ids: favCoinIds) { data, error in
            if let error = error{
                print(error)
                return
            }
            if let data = data {
                    
                    self.FavCoinData = data;
                    print(self.FavCoinData)
                }
        }
    }
   
}
extension FavCoin_ : Identifiable {
}
extension FavCoin : Identifiable {
}
