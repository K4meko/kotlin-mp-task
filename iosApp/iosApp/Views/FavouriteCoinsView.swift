import Charts
import SwiftUI

struct FavouriteCoinsView: View {
    @StateObject var viewModel = FavouriteCoinsViewViewModel()
    let date = Date()
    let currentUnixTimestamp: Int
    let twentyFourHoursAgo: TimeInterval
    init() {
        currentUnixTimestamp = Int(date.timeIntervalSince1970)
        twentyFourHoursAgo = Calendar.current.date(byAdding: .hour, value: -12, to: date)?.timeIntervalSince1970 ?? 0
        print(currentUnixTimestamp, twentyFourHoursAgo)
    }

    var body: some View {
        if !viewModel.nofavItems{
            if !viewModel.apiIsffline{
                VStack {
                    ScrollView {
                        if !viewModel.uiChartData.isEmpty {
                            ForEach(viewModel.FavCoinData, id: \.self) { i in
                                VStack {
                                    Text(i.name).font(.title).padding(.bottom, 20).fontWeight(.semibold)
                                    
                                    Text("Current price: \(i.current_price) czk")
                                    
                                    LineChart(data: viewModel.uiChartData.filter { $0.id == i.id }, title: i.name)
                                    Divider().frame(height: 30)
                                }
                            }
                            
                        } 
                        if viewModel.chartArray.isEmpty {
                            VStack{
                                ForEach(viewModel.offlineCoinData, id: \.coinId){ i in
                                    Text(i.coinName)
                                }
                            }                        }
                    }
                }.onAppear(perform: {
                    viewModel.getFavDetails()
                    print("appearing")
                    // print(viewModel.uiChartData)
                }
                )}
            else{
              
            }
        }else{
            Text("Add some items to favourite first")
        }
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
        VStack {
            Chart(data) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Price", $0.price)
                )

            }.frame(height: 150).frame(width: 300)
        }
    }
}
