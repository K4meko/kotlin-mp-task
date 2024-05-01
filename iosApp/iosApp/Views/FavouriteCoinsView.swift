import Charts
import SwiftUI

struct FavouriteCoinsView: View {
    @StateObject var viewModel = FavouriteCoinsViewViewModel()
    let date = Date()
    let currentUnixTimestamp: Int
    let twentyFourHoursAgo: TimeInterval
    init(){
        currentUnixTimestamp = Int(date.timeIntervalSince1970)
        twentyFourHoursAgo =  Calendar.current.date(byAdding: .hour, value: -12, to: date)?.timeIntervalSince1970 ?? 0
        print(currentUnixTimestamp, twentyFourHoursAgo)
    }
    let chartData: [ChartData] = [
//            ChartData(id: "dogecoin", date: Date(timeIntervalSince1970: 1714089600), price: 1511519.8967036433),
//            ChartData(id: "dogecoin", date: Date(timeIntervalSince1970: 1714176000), price: 1499016.6038083252),
//            ChartData(id: "dogecoin", date: Date(timeIntervalSince1970: 1714262400), price: 1492318.7040517835),
//            ChartData(id: "dogecoin", date: Date(timeIntervalSince1970: 1714348800), price: 1481855.0119236636),
//            ChartData(id: "dogecoin", date: Date(timeIntervalSince1970: 1714435200), price: 1496852.9946596094),
//            ChartData(id: "dogecoin", date: Date(timeIntervalSince1970: 1714495106), price: 1412784.2349630839),
//            ChartData(id: "bitcoin", date: Date(timeIntervalSince1970: 1714089600), price: 3.5521245852588037),
//            ChartData(id: "bitcoin", date: Date(timeIntervalSince1970: 1714176000), price: 3.473191513467062),
//            ChartData(id: "bitcoin", date: Date(timeIntervalSince1970: 1714262400), price: 3.4765390143334898),
//            ChartData(id: "bitcoin", date: Date(timeIntervalSince1970: 1714348800), price: 3.4482202052326336),
//            ChartData(id: "bitcoin", date: Date(timeIntervalSince1970: 1714435200), price: 3.366024329679226),
//            ChartData(id: "bitcoin", date: Date(timeIntervalSince1970: 1714495200), price: 3.064096178817754)
        ]
    
    var body: some View {
        VStack(){
            ForEach(viewModel.FavCoinData, id: \.self){ i in
               
                if !viewModel.uiChartData.isEmpty {
                    LineChart(data: viewModel.uiChartData.filter{$0.id == i.id}, title: i.name)
                                   .padding()
                           } else {
                               ProgressView("Loading...")
                           }
                
            }
    }.onAppear(perform: {
        viewModel.getFavDetails()
        print("appearing")
        print(viewModel.uiChartData)
    }
           )

    }
        }
    
    
    #Preview {
        FavouriteCoinsView()
    }
    struct ChartData: Identifiable {
        var id: String
        var date: Date
        var price: Double
    }



struct LineChart: View {
    var data: [ChartData]
    var title: String
   
    var body: some View {
        Text(title)
            .font(.title)
            .padding(.bottom, 20)
        VStack {
            Chart(data){
              
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Price", $0.price)
                               )
               
            }
        }
    }
}
