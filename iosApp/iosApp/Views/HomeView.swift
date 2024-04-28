import SwiftUI
import Foundation

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 40)
            Text("Trending Cryptos 🔥")
            
                .font(.title).fontWeight(.semibold)
            
                .padding(10)
            
            if let cryptoData = viewModel.trendingCoinData{
                VStack{
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            
                            ForEach(cryptoData.coins, id: \.item.id) { coinItem in
                                
                                VStack(alignment: .center) {
                                    HStack{
                                        Text(coinItem.item.name)
                                            .font(.title2).bold().padding(.horizontal)
                                        AsyncImage(url: coinItem.item.small).cornerRadius(10)
                                    }
                                    if let _pricebtc = coinItem.item.data.priceBtc
                                        
                                    {
                                        if _pricebtc.prefix(6) == "0.0000"{
                                            Text("0 BTC")
                                        }
                                        else {
                                            Text( _pricebtc.prefix(6) + " BTC")
                                        }
                                    }
                                    
                                }
                                .frame(width: 230)
                                .padding()
                                .background(Color(hex: "#f5c6c6"))
                                .cornerRadius(10)
                            }
                            
                           
                        }}}.frame(height:640).padding()
                
            }
            
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
