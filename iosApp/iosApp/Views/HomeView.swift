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
                VStack(alignment: .leading) {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            
                            ForEach(cryptoData.coins, id: \.item.id) { coinItem in
                                
                                VStack(alignment: .leading) {
                                    HStack(spacing: 10){
                                        HStack(){
                                            Text(coinItem.item.name)
                                                .font(.title2).bold().fixedSize()
                                            Spacer()
                                        }
                                        AsyncImage(url: coinItem.item.small).cornerRadius(10)
                                    }.frame(width: 300)
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
                                .frame(width: 300)
                                .padding()
                                .background(Color(hex: "#f5c6c6"))
                                .cornerRadius(10)
                            }
                            
                           
                        }}}.frame(height:640).padding()
                
            }
            
        }
    }
    
 
}

#Preview {
    HomeView()
}
