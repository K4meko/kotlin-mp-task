import Foundation
import shared

class FavouriteCoinsViewViewModel: ObservableObject {
    let date = Date()
    let currentUnixTimestamp: Int
    let twelveHoursAgo: TimeInterval
    @Published var FavCoinData: [FavCoin_] = []
    @Published var favCoinIds: [String] = []
    @Published var apiIsffline = false
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
    func saveLocally(value: Any, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
//    func loadLocally(key: String){
//
//    }
    func getChartData(completion: @escaping () -> Void) {
        chartArray = []
        chartData = []

        var requestsCompleted = 0
        let totalRequests = favCoinIds.count
        var index = 0
//        Task.detached { @MainActor in
        for i in favCoinIds {
            ApiCalls().getChartData(favId: i) { Data, _ in
                // will be calles 6 times for each id (i)
                if let data = Data?.prices {
                    for j in data {
                        print("j: \(j) i:\(i) index: \(index)")
                        let price = j.last as! Double
                        let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: j.first as! Int64 / 1000))

                        self.chartData.append((price, date, i))
                        // self.chartArray?[index].append((price, date, i))
                    }
                    requestsCompleted += 1
                }

                self.chartArray.append([])

                let dataToAppend = self.chartData.filter { _, _, id in
//                                if id == i{
//                                    return true
//                                }
//                                else{
//                                    return false
//                                }
                    id == i
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

    func getFavDetails() {
        for i in LocalDatabase().getFavCoins() {
            favCoinIds.append(i.coin_id)
        }
        ApiCalls().getFav(favCoins_ids: favCoinIds) { data, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self.FavCoinData = data

                if !self.FavCoinData.isEmpty {
                    DispatchQueue.main.async {
                        self.getChartData {
                            self.uiChartData = []
                            var index = 0
                            for i in self.favCoinIds {
                                //  if index <= 1{
                                for item in self.chartArray[index] {
                                    print(item)
                                    self.uiChartData.append(ChartData(id: item.2, date: item.1, price: item.0))
                                   // self.saveLocally(value: item.0, key: "chartData")
                                }
                                index += 1
                            }

                            //     print(self.chartArray)
                            print("---")
                            print(self.uiChartData)
                            
                        }
                    }
                }else{
                    self.apiIsffline = true;  
                    print("app is offline")
                    if let localData = UserDefaults.standard.array(forKey: "chartData"){
                        print("local")
                       print(localData)
                    }}
                
            }
        }
    }
}
