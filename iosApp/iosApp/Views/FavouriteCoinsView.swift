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
    var body: some View {
        VStack(){
            ScrollView{
                ForEach(viewModel.FavCoinData, id: \.self){ i in
                    VStack(){
                        if !viewModel.uiChartData.isEmpty {
                            Text(i.name).font(.title).padding(.bottom, 20).fontWeight(.semibold)
                            
                            Text("Current price \(i.current_price)")
                            
                            LineChart(data: viewModel.uiChartData.filter{$0.id == i.id}, title: i.name)
                            Divider().frame(height: 30)
                        } else {
                            ProgressView("Loading...")
                            
                        }
                    }
                    
                }}
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
        VStack {
            Chart(data){
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Price", $0.price)
                )
               
            }.frame(height:150).frame(width:300)
        }
    }
}
