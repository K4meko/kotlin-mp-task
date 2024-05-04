import Foundation
import shared

class FavouriteCoinsViewViewModel: ObservableObject {
    let date = Date()
    let currentUnixTimestamp: Int
    let twelveHoursAgo: TimeInterval
    @Published var FavCoinData: [FavCoin_] = []
    @Published var favCoinIds: [String] = []
    @Published var apiIsffline = false
    @Published var nofavItems = false
    @Published var chartData: [(Double, Date, String)] = []
    @Published var chartArray: [[(Double, Date, String)]] = []
    @Published var uiChartData: [ChartData] = []
    @Published var offlineCoinData: [OfflineCoinData] = []
    let splitLength = 6

    init() {
        currentUnixTimestamp = Int(date.timeIntervalSince1970)
        twelveHoursAgo = Calendar.current.date(byAdding: .hour, value: -12, to: date)?.timeIntervalSince1970 ?? 0
    }

    func getChartData(completion: @escaping () -> Void) {
        let semaphore = DispatchSemaphore(value: 1)
        chartArray = []
        chartData = []

        var requestsCompleted = 0
        let totalRequests = favCoinIds.count
        var index = 0
        for i in favCoinIds {
            ApiCalls().getChartData(favId: i) { Data, _ in
                print("Data")
                // print(Data)
                semaphore.wait()
                defer { semaphore.signal() }
                if let data = Data?.prices {
                    for j in data {
                        let price = j.last as! Double
                        let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: j.first as! Int64 / 1000))

                        self.chartData.append((price, date, i))
                    }

                    self.chartArray.append([])

                    let dataToAppend = self.chartData.filter { _, _, id in
                        id == i
                    }

                    self.chartArray[index].append(contentsOf: dataToAppend)
                } else {
                    self.chartData = []
                    for i in LocalDatabase().testSelect() {
                        self.offlineCoinData.append(OfflineCoinData(coinId: i.coin_id, coinName: i.coin_name, image: i.image ?? "", currentPrice: i.current_price, high24: i.high_24h as! Double, low24: i.low_24h as! Double))
                    }
                    self.uiChartData = []
                    if let localData = UserDefaults.standard.array(forKey: "chartData") {
                        print(localData)
                    }
                }

                requestsCompleted += 1

                if requestsCompleted == totalRequests {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
                index += 1
            }
        }
    }

    func getFavDetails() {
        offlineCoinData = []
        favCoinIds = []
        for i in LocalDatabase().getFavCoins() {
            favCoinIds.append(i.coin_id)
        }
        if favCoinIds.isEmpty {
            nofavItems = true
        }
        print(LocalDatabase().getFavCoins())
        print(favCoinIds)
        ApiCalls().getFav(favCoins_ids: favCoinIds) { [self] data, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self.FavCoinData = data
                if !self.FavCoinData.isEmpty {
                    LocalDatabase().testDelete()
                    for i in self.FavCoinData {
                        LocalDatabase().testInsert(id: i.id, name: i.name, image: i.image, current_price: i.current_price, high_24h: i.high_24h as! Double, low_24h: i.low_24h)
                    }
                    DispatchQueue.main.async {
                        self.getChartData {
                            self.uiChartData = []
                            var index = 0
                            for i in self.favCoinIds {
                                for item in self.chartArray[index] {
                                    print(item)
                                    self.uiChartData.append(ChartData(id: item.2, date: item.1, price: item.0))
                                }

                                index += 1
                            }

                            print("---")
                            print(self.uiChartData)
                        }
                    }
                } else {
                    self.uiChartData = []
                    self.chartArray = []
                    for i in LocalDatabase().testSelect() {
                        self.offlineCoinData.append(OfflineCoinData(coinId: i.coin_id, coinName: i.coin_name, image: i.image ?? "", currentPrice: i.current_price, high24: i.high_24h as! Double, low24: i.low_24h as! Double))
                    }
                    print(offlineCoinData)
                    print("app is offline")
                }
            }
        }
    }

    //    func getFavDetails() {
    //        favCoinIds = []
    //        for i in LocalDatabase().getFavCoins() {
    //            favCoinIds.append(i.coin_id)
    //
    //        }
    //        print(self.favCoinIds)
    //        self.favCoinIds = Array(Set(favCoinIds))
    //        print(self.favCoinIds)
    //        if favCoinIds.isEmpty {
    //            nofavItems = true
    //        }
    //        // check if user has any fav items
    //        if !favCoinIds.isEmpty {
    //            ApiCalls().getFav(favCoins_ids: favCoinIds) { data, error in
    //                if let error = error {
    //                    print(error)
    //                    return
    //                }
    //                if let data = data {
    //                    self.FavCoinData = []
    //                    self.FavCoinData = data
    //                    if !self.FavCoinData.isEmpty {
    //                        //for i in self.FavCoinData{
    ////                            LocalDatabase().testInsert(id: i.id, name: i.name, image: i.image, current_price: i.current_price, high_24h: i.high_24h as! Double, low_24h: i.low_24h)
    //                       // }
    //                        DispatchQueue.main.async {
    //                            self.getChartData {
    //                                self.uiChartData = []
    //                                var index = 0
    //                                for i in self.favCoinIds {
    //                                    for item in self.chartArray[index] {
    //                                        print(item)
    //                                        self.uiChartData.append(ChartData(id: item.2, date: item.1, price: item.0))
    //
    //                                    }
    //                                    index += 1
    //                                }
    //                                print("---")
    //                                print(self.uiChartData)
    //                            }
    //                        }
    //                    } else {
    //                        self.apiIsffline = true
    //
    //                        print("app is offline")
    //
    //                    }
    //                }
    //            }
    //        }
    // }
}
