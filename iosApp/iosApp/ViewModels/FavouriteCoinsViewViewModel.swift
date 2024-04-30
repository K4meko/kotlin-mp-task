import Foundation
import shared

class FavouriteCoinsViewViewModel: ObservableObject{
    let date = Date()
    let currentUnixTimestamp: Int
    let twelveHoursAgo: TimeInterval
    @Published var FavCoinData: [FavCoin_] = []
    @Published var favCoinIds: [String] = []
    var timeStamps: [Int64] = []
    var prices: [Double] = []
    var dates: [Date] = []
    @Published var chartData: [(Double, Date)] = []
    var chartArray: ChartData? = nil

    init(){
        currentUnixTimestamp = Int(date.timeIntervalSince1970)
        twelveHoursAgo =  Calendar.current.date(byAdding: .hour, value: -12, to: date)?.timeIntervalSince1970 ?? 0
    }
    func getChartData(completion: @escaping () -> Void) {
        var requestsCompleted = 0
        let totalRequests = favCoinIds.count
        
        for i in self.favCoinIds {
            ApiCalls().getChartData(favId: i) { Data, error in
                if let data = Data?.prices {
                    for j in data {
                        var index = 0
                        var price = j.last as! Double
                        var date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: j.first as! Int64 / 1000))
                        
                        self.chartData.append((price, date))
                        self.chartArray?.history[index].date = date
                        index = index + 1
                    }
                }
                requestsCompleted += 1
                if requestsCompleted == totalRequests {
                    completion()
                }
            }
        }
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
                }
        }
        getChartData{
            print(self.chartData.first)
        }
       
    }
   
}
extension FavCoin_ : Identifiable {
}

