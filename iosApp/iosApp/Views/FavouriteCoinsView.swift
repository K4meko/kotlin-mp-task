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
        if !viewModel.nofavItems {
            VStack {
                if viewModel.offlineCoinData.isEmpty {
                    if !viewModel.uiChartData.isEmpty {
                        ScrollView {
                            ForEach(viewModel.FavCoinData, id: \.self) { i in
                                VStack {
                                    Text("\(i.name)").font(.title).padding(.bottom, 20).fontWeight(.semibold)

                                    Text("Current price: \(String(format: "%.2f", i.current_price.rounded(toPlaces: 2))) czk")
                                    if viewModel.uiChartData.contains(where: { $0.id == i.id }) {
                                        LineChart(data: viewModel.uiChartData.filter { $0.id == i.id }, title: i.name)
                                    } else {
                                        VStack {
                                            Text("Sorry, could not load your charts due to an API failure, so here's a cookie for you instead 🍪").font(.title2)
                                        }.frame(height: 150).frame(width: 300)
                                    }
                                    Divider().frame(height: 30)
                                }
                            }.padding(.bottom, 20)
                        }
                    } else {
                        ProgressView()
                    }
                }
                if !viewModel.offlineCoinData.isEmpty {
                    VStack(alignment: .center) {
                        Text("Try again to view charts").padding(.bottom)
                        ScrollView {
                            ForEach(viewModel.offlineCoinData, id: \.coinId) { i in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(i.coinName).bold().font(.title2)
                                        Text("\(String(format: "%.2f", i.currentPrice.rounded(toPlaces: 2))) CZK")
                                        Spacer()
                                    }.padding(2)
                                    VStack(alignment: .leading) {
                                        Text("Highest price today: \(String(format: "%.2f", i.high24.rounded(toPlaces: 2))) CZK").fontWeight(.light).foregroundStyle(.green)
                                        Text("Lowest price today: \(String(format: "%.2f", i.low24.rounded(toPlaces: 2)))").fontWeight(.light).foregroundStyle(.red)

                                    }.padding(2)
                                    // Divider()
                                }.padding(20).frame(width: 360).frame(height: 110).overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(UIColor.lightGray), lineWidth: 2).padding(1)
                                )
                                Spacer().frame(height: 20)
                            }
                            Spacer().frame(height: 30)
                        }
                    }
                }

            }.onAppear(perform: {
                viewModel.getFavDetails()
                print("appearing")
                // print(viewModel.uiChartData)
            }
            )
        } else {
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
