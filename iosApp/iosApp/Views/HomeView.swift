import SwiftUI
import Foundation

struct HomeView: View {
@ObservedObject var viewModel = HomeViewViewModel()
var body: some View {
    VStack(alignment: .leading) {
        


        
        
        Text("Trending Cryptos")
            .font(.headline)
            
            .padding()
        
        if let cryptoData = viewModel.trendingCoinData{
                      ScrollView(.vertical, showsIndicators: false) {
                          LazyVStack(spacing: 10) {
                              ForEach(cryptoData.coins, id: \.item.id) { coinItem in
                               
                                      VStack(alignment: .center) {
                                          HStack{
                                              Text(coinItem.item.name)
                                                  .font(.title2).bold()
                                              AsyncImage(url: coinItem.item.small)   .cornerRadius(10)
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
                                  .frame(width: 180)
                                  .padding()
                                  .background(Color.gray.opacity(0.2))
                                  .cornerRadius(10)
                              }
                          }.frame(height: 100)
                         .padding(.horizontal)
                      }
                  }
        else
        {
            
        }
    }
    
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
