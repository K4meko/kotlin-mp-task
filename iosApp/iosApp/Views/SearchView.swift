import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewViewModel = SearchViewViewModel()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                TextField("Search for cryptos", text: $viewModel.searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .frame(width: 300)
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    )

                Spacer()
            }
            if let searchData = viewModel.searchCoinData {
                if viewModel.dataIsEmpty {
                    VStack {
                        Text("No data found :(").font(.title).fontWeight(.heavy)
                    }.frame(height: 600).padding()
                } else {
                    LazyVStack {
                        ScrollView {
                            ForEach(searchData.coins.indices, id: \.self) { index in
                                let coinItem = searchData.coins[index]

                                VStack {
                                    
                                    HStack {
                                        if #available(iOS 17.0, *) {
                                            Button {
                                                if !viewModel.isFav(coinId: coinItem.id) {
                                                    viewModel.addFav(coinId: coinItem.id, coinName: coinItem.name)
                                                    print("K")
                                                } else {
                                                    viewModel.removeFav(coinId: coinItem.id)
                                                    print("L")
                                                }
                                            } label: {
                                                viewModel.isFav(coinId: coinItem.id) ? Image(systemName: "heart.fill").padding(.leading) : Image(systemName: "heart").padding(.leading)
                                            }.foregroundStyle(.black).contentTransition(.symbolEffect(.replace))
                                        } else {
                                            Button {
                                                if !viewModel.isFav(coinId: coinItem.id) {
                                                    viewModel.addFav(coinId: coinItem.id, coinName: coinItem.name)
                                                    print("K")
                                                } else {
                                                    viewModel.removeFav(coinId: coinItem.id)
                                                    print("L")
                                                }
                                            } label: {
                                                viewModel.isFav(coinId: coinItem.id) ? Image(systemName: "heart.fill").padding(.leading) : Image(systemName: "heart").padding(.leading)
                                            }.foregroundStyle(.black)
                                        }

                                        Text(coinItem.name).foregroundStyle(.black).font(.title2).bold()

                                        Spacer()
                                        AsyncImage(url: URL(string: coinItem.large)){ image in
                                            image.resizable().aspectRatio(contentMode: .fit).frame(height: 50).clipShape(RoundedRectangle(cornerRadius: 5))
                                        }placeholder: {
                                            ProgressView().aspectRatio(contentMode: .fit).frame(height: 50)
                                        }
                                    }
                                    Divider().frame(width: 360)
                                }.frame(width: 360, height: 60).padding(.top, 9)
                            }
                        }
                        .frame(height: 600).padding().scrollIndicators(.hidden)
                    }
                }
            } else {
                HStack {
                    Text("Search for coins 🔎").font(.title).fontWeight(.heavy)
//
                }
                .frame(height: 600).padding()
            }
        }
    }
}

#Preview {
    SearchView()
}

