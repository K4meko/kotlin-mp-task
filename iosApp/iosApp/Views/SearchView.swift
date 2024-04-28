import SwiftUI

struct SearchView: View {
@ObservedObject var viewModel: SearchViewViewModel = SearchViewViewModel()
    var body: some View {
        VStack{
            HStack{
                Spacer()
                TextField("Search for cryptos", text: $viewModel.searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .frame(width:300)
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
                    VStack{
                       
                        Text("No data found :(").font(.title).fontWeight(.heavy)
                    } .frame(height:600).padding()

                }
                else{
                LazyVStack{
                    ScrollView{
                        ForEach(searchData.coins.indices, id: \.self) { index in
                            let coinItem = searchData.coins[index]
                            
                            VStack{
                                HStack{
                                    AsyncImage(url: URL(string: coinItem.thumb))
                                    Text(coinItem.name).foregroundStyle(.white).font(.title2)
                                }
                            }.frame(width: 400, height: 60).background(.blue)
                        }}.frame(height:600).padding()
                }
            }
            }
            else{
                HStack{
                    Text("Search for coins 🔎").font(.title).fontWeight(.heavy)
//
                   
                }
                .frame(height:600).padding()
            
    
        }
       

            
        }
    }
}

#Preview {
    SearchView()
}
