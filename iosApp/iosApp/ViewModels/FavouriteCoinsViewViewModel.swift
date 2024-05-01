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
    var chartData: [(Double, Date, String)] = []
    @Published var chartArray: [[(Double, Date, String)]] = []
    @Published var uiChartData: [ChartData] = []
    let splitLength = 6

    init(){
        currentUnixTimestamp = Int(date.timeIntervalSince1970)
        twelveHoursAgo =  Calendar.current.date(byAdding: .hour, value: -12, to: date)?.timeIntervalSince1970 ?? 0
        for i in LocalDatabase().getFavCoins(){
            if(i.coin_id.isEmpty){
               favCoinIds = []
                print("should be empty")
                print(favCoinIds)
            }
            else{
                favCoinIds.append(i.coin_id)
                print("should not be empty")

            }
        }
    }
    
 func getChartData(completion: @escaping () -> Void) {
        self.chartArray = []
        self.chartData = []
     if !self.FavCoinData.isEmpty{
         print("is called")
        var requestsCompleted = 0
        let totalRequests = favCoinIds.count
        var index = 0
//        Task.detached { @MainActor in

     for i in self.favCoinIds {
         
         ApiCalls().getChartData(favId: i) { Data, error in
             //will be calles 6 times for each id (i)
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
             
             let dataToAppend = self.chartData.filter { (Double, Date, id) in
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
             index+=1
             
         }
         
     }
        }
    }
 
    func getFavDetails(){
        for i in LocalDatabase().getFavCoins(){
            if(i.coin_id.isEmpty){
               favCoinIds = []
            }
            else{
                favCoinIds.append(i.coin_id)
            }
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
        if !favCoinIds.isEmpty
        {
            getChartData{
            self.uiChartData = []
            var index = 0
            for i in self.favCoinIds{
                //  if index <= 1{
                for item in self.chartArray[index]{
                    print(item)
                    self.uiChartData.append(ChartData(id: item.2, date: item.1, price: item.0))
                    
                    
                }
                index += 1
            }
            
            
            //     print(self.chartArray)
            print("---")
            print(self.uiChartData)
            //print(self.chartArray!)
            
        }
    }
       
    }
   
}


