import SwiftUI
import Foundation

struct HomeView: View {
@ObservedObject var viewModel = HomeViewViewModel()
var body: some View {
    VStack(alignment: .leading) {
        Text("Trending Cryptos")
            .font(.headline)
            .padding()
        
        if let cryptoData = viewModel.CoinData{
                      ScrollView(.horizontal, showsIndicators: false) {
                          LazyHStack(spacing: 5) {
                              ForEach(cryptoData.coins, id: \.item.id) { coinItem in
                                  VStack(alignment: .center) {
                                      Text(coinItem.item.name)
                                          .font(.title3)
                                      if let _pricebtc = coinItem.item.data.priceBtc
                                      {
                                          Text( _pricebtc.prefix(6) + " BTC")
                                     }
                                  }
                                  .frame(width: 150)
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
