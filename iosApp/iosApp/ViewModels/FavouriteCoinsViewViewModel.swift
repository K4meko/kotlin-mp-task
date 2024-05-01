import Foundation
import shared

class FavouriteCoinsViewViewModel: ObservableObject {
    let date = Date()
    let currentUnixTimestamp: Int
    let twelveHoursAgo: TimeInterval
    @Published var FavCoinData: [FavCoin_] = []
    @Published var favCoinIds: [String] = []
    var timeStamps: [Int64] = []
    var prices: [Double] = []
    var dates: [Date] = []
    var chartData: [(Double, Date, String)] = []
    @Published var chartArray: [[(Double, Date, String)]] = []
    @Published var uiChartData: [ChartData] = []
    let splitLength = 6

    init() {
        currentUnixTimestamp = Int(date.timeIntervalSince1970)
        twelveHoursAgo = Calendar.current.date(byAdding: .hour, value: -12, to: date)?.timeIntervalSince1970 ?? 0
    }

    func getChartData(completion: @escaping () -> Void) {
//                self.chartArray = []
//                self.chartData = []
        
        var requestsCompleted = 0
        
     //   print(favCoinIds)
        var index = 0
        if !favCoinIds.isEmpty{
            let totalRequests = favCoinIds.count

            for i in favCoinIds {
            ApiCalls().getChartData(favId: i) { Data, _ in
                if let data = Data?.prices {
                    if !data.isEmpty {
                        
                        for j in data {
                            print("j: \(j) i:\(i) index: \(index)")
                            let price = j.last as! Double
                            let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: j.first as! Int64 / 1000))
                            self.chartData.append((price, date, i))
                            self.chartArray.append([])
                        }
                        requestsCompleted += 1
                    }
                    else{
                        self.chartArray.append([])
                    }
                    
                    let dataToAppend = self.chartData.filter { _, _, id in
                        if id == i {
                            return true
                        } else {
                            return false
                        }
                    }
                    
                    self.chartArray[index].append(contentsOf: dataToAppend)
                    
                    print("chart array after append")
                    print(self.chartArray)
                    if requestsCompleted == totalRequests {
                        completion()
                    }
                    index += 1
                }
            }
        }
    }
        else{
            
        }
    }

    func getFavDetails() {
        for i in LocalDatabase().getFavCoins() {
            favCoinIds.append(i.coin_id)
        }
       
            ApiCalls().getFav(favCoins_ids: self.favCoinIds) { data, error in
                if let error = error {
                    print(error)
                    return
                }
                if let data = data {
                    if data.isEmpty {
                        self.FavCoinData = []
                    }
                    self.FavCoinData = data
                }
            }
       
            getChartData {
            self.uiChartData = []
           
                if !self.favCoinIds.isEmpty{
                    var index = 0
                    for i in self.favCoinIds {
                        
                        for item in self.chartArray[index] {
                            self.uiChartData.append(ChartData(id: i, date: item.1, price: item.0))
                        }
                        
                        index += 1
                    }
            }
            print(self.chartArray)
            print("---")
            print(self.uiChartData)
            // print(self.chartArray!)
      }
       
    }
}
