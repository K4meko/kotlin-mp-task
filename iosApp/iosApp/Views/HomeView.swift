import Foundation
import shared
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewViewModel()
    var body: some View {
        if let cryptoData = viewModel.trendingCoinData {
            VStack(alignment: .leading) {
                Spacer().frame(height: 20)
                Text("Trending Cryptos 🔥")

                    .font(.title).fontWeight(.semibold)

                    .padding(10)

                VStack(alignment: .leading) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(cryptoData.coins, id: \.item.id) { coinItem in
                                HomeItemView(viewModel: self.viewModel, coinItem: coinItem).padding(.bottom, 5)
                            }
                        }.padding(.bottom, 55)
                        
                    }
                }
            }

        } else {
            ProgressView()
        }
    }
}

#Preview {
    HomeView()
}
