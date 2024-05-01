import SwiftUI
import Foundation

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewViewModel()
        var body: some View {
        
        if let cryptoData = viewModel.trendingCoinData{
            
        VStack(alignment: .leading) {
            Spacer().frame(height: 40)
            Text("Trending Cryptos 🔥")
            
                .font(.title).fontWeight(.semibold)
            
                .padding(10)
            
        
                VStack(alignment: .leading) {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            
                            ForEach(cryptoData.coins, id: \.item.id) { coinItem in
                                
                             
                                    HStack(alignment: .center){
                                        VStack(alignment: .leading) {
                                        HStack(){
                                            Text(coinItem.item.name)
                                                .font(.title2).bold().fixedSize()
                                            Spacer()
                                        }
                                        
                                   
                                    if let _pricebtc = coinItem.item.data.priceBtc
                                        
                                    {
                                        if _pricebtc.prefix(6) == "0.0000"{
                                            Text("< 0.0001 BTC")
                                        }
                                        else {
                                            Text( _pricebtc.prefix(6) + " BTC")
                                        }
                                    }
                                            
                                    }
                                        AsyncImage(url: coinItem.item.small).cornerRadius(10)
                                }.frame(width: 300)
                                .frame(width: 300)
                                .padding()
                                .background(Color(hex: "#f5c6c6"))
                                .cornerRadius(10)
                            }
                            
                           
                        }}}.frame(height:640).padding()
                
            }

            
        } else{
            Text("No connection")
        }
   }
   

}

#Preview {
    HomeView()
}
