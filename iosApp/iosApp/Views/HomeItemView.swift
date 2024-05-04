//
//  HomeItemView.swift
//  iosApp
//
//  Created by Eliška Pavlů on 04.05.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct HomeItemView: View {
    @ObservedObject var viewModel: HomeViewViewModel
    @State var coinItem: CoinItem
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                HStack {
                    if #available(iOS 17.0, *) {
                        Button {
                            if viewModel.isFav(id: coinItem.item.id) {
                                viewModel.removeFav(coinId: coinItem.item.id)
                                print("K")
                            } else {
                                viewModel.addFav(coinId: coinItem.item.id, coinName: coinItem.item.name)
                                print("L")
                            }
                        } label: {
                            viewModel.isFav(id: coinItem.item.id) ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                        }.foregroundStyle(.black).contentTransition(.symbolEffect(.replace))
                    } else {
                        if viewModel.isFav(id: coinItem.item.id) {
                            Button {
                                print("removing fav coin")

                                viewModel.removeFav(coinId: coinItem.item.id)
                            } label: {
                                Image(systemName: "heart.fill")
                            }.foregroundStyle(.black)
                        } else {
                            Button {
                                print("adding fav coin")
                                viewModel.addFav(coinId: coinItem.item.id, coinName: coinItem.item.name)
                            } label: {
                                Image(systemName: "heart")
                            }.foregroundStyle(.black)
                        }
                    }
                    Text(coinItem.item.name)
                        .font(.title2).bold().fixedSize()
                    Spacer()
                }
                HStack {
                    if let _pricebtc = coinItem.item.data.priceBtc {
                        if _pricebtc.prefix(6) == "0.0000" {
                            Text("< 0.0001 BTC")
                        } else {
                            Text(_pricebtc.prefix(6) + " BTC")
                        }
                    }
                  
                        if coinItem.item.data.price.isLess(than: 0.01) {
                            Text("< 0.01 USD")
                        } else {
                            Text("\(String(format: "%.2f", coinItem.item.data.price)) USD")
                        }
                    
                   
                }
            }
            AsyncImage(url: coinItem.item.small){image in
                image.cornerRadius(10).aspectRatio(contentMode: .fit).frame(width: 75)
            }placeholder: {
                ProgressView().cornerRadius(10).frame(width: 75, height: 75)
            }.frame(width: 75)

        }.frame(width: 300, height: 80)
            .padding(.horizontal)
            .background(Color(hex: "#f5c6c6"))
            .cornerRadius(10)
    }
}


