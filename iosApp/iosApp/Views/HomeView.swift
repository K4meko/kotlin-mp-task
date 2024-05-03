import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewViewModel()
    var body: some View {
        if let cryptoData = viewModel.trendingCoinData {
            VStack(alignment: .leading) {
                Spacer().frame(height: 40)
                Text("Trending Cryptos 🔥")

                    .font(.title).fontWeight(.semibold)

                    .padding(10)

                VStack(alignment: .leading) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(cryptoData.coins, id: \.item.id) { coinItem in
                                HStack(alignment: .center) {
                                   
                                    VStack(alignment: .leading) {
                                        HStack {
//                                            Button {
//                                                if !viewModel.isFav(id: coinItem.item.id as! String){
//                                                    viewModel.addFav(coinId: coinItem.item.id, coinName: coinItem.item.name)
//                                                    print("K")
//                                                } else {
//                                                    viewModel.removeFav(id: coinItem.id)
//                                                    print("L")
//                                                }
//                                            } label: {
//                                                viewModel.isFav(id: coinItem.item.id as! String) ? Image(systemName: "heart.fill").padding(.leading) : Image(systemName: "heart").padding(.leading)
//                                            }.foregroundStyle(.black).contentTransition(.symbolEffect(.replace))
                                            
                                            if viewModel.isFav(id: coinItem.item.id){
                                                Button {
                                                    print("removing fav coin")

                                                    viewModel.removeFav(coinId: coinItem.item.id)
                                                } label: {
                                                   Image(systemName: "heart.fill").padding(.leading)
                                                }.foregroundStyle(.black)

                                            }
                                            else{
                                                Button {
                                                    print("adding fav coin")
                                                    viewModel.addFav(coinId: coinItem.item.id, coinName: coinItem.item.name)
                                                } label: {
                                                   Image(systemName: "heart").padding(.leading)
                                                }.foregroundStyle(.black)
                                           }
                                            Text(coinItem.item.name)
                                                .font(.title2).bold().fixedSize()
                                            Spacer()
                                       }

                                        if let _pricebtc = coinItem.item.data.priceBtc {
                                            if _pricebtc.prefix(6) == "0.0000" {
                                                Text("< 0.0001 BTC")
                                            } else {
                                                Text(_pricebtc.prefix(6) + " BTC")
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
                        }
                    }
                }.frame(height: 640).padding()
            }

        } else {
            Text("No connection")
        }
    }
}

#Preview {
    HomeView()
}
