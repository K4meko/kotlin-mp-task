import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FavouriteCoinsView()
                .tabItem {
                    Label("Favourites", systemImage: "heart.fill")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
