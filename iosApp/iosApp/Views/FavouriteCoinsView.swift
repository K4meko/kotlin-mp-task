import Charts
import SwiftUI

struct FavouriteCoinsView: View {
    @StateObject var viewModel = FavouriteCoinsViewViewModel()
    let date = Date()
    let currentUnixTimestamp: Int
    let twentyFourHoursAgo: TimeInterval
    init(){
        currentUnixTimestamp = Int(date.timeIntervalSince1970)
        twentyFourHoursAgo =  Calendar.current.date(byAdding: .hour, value: -24, to: date)?.timeIntervalSince1970 ?? 0
        print(currentUnixTimestamp, twentyFourHoursAgo)
    }
  

    var body: some View {
        VStack(){
            ForEach(viewModel.FavCoinData, id: \.self){ i in
                let item = viewModel.FavCoinData
                
//                Chart([
//                    ChartData(priceChange24h: 0, currentPrice: 80, id: i.id),
//                    ChartData(priceChange24h: 24, currentPrice: 70, id: i.id)
//                    
//                ]) { i in
//                    LineMark(
//                        x: .value("Hours", i.priceChange),
//                        y: .value("Price change", i.currentPrice)
//                    ).foregroundStyle(by: .value("id", i.id))
//                }
            }
        }.onAppear(perform: {
            viewModel.getFavDetails()
            print("appearing")
            print(currentUnixTimestamp)
          
        })
    }
}

#Preview {
    FavouriteCoinsView()
}
struct ChartData: Identifiable {
    let id: String
    let priceChange: Double
    let currentPrice: Double


    init(priceChange24h: Double, currentPrice: Double, id: String) {
        self.id = id
        self.priceChange = priceChange24h
        self.currentPrice = currentPrice
    }
}
