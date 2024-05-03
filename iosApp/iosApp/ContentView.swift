import SwiftUI
import TabBar

struct ContentView: View {
    @State private var selection: Item = .first
    @State private var visibility: TabBarVisibility = .visible
           var body: some View {
               TabBar(selection: $selection, visibility: $visibility) {
                   FavouriteCoinsView()
                       .tabItem(for: Item.first)
                   
                  SearchView()
                       .tabItem(for: Item.second)
                   
                 HomeView()
                       .tabItem(for: Item.third)
               }
             //  .tabBar(style: )
               .tabItem(style: CustomTabItemStyle())
           }
    
//        TabView {
//            FavouriteCoinsView()
//                .tabItem {
//                    Label("Favourites", systemImage: "heart.fill")
//                }
//
//            SearchView()
//                .tabItem {
//                    Label("Search", systemImage: "magnifyingglass")
//                }
//
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                }
//        }
   
}
struct CustomTabItemStyle: TabItemStyle {
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        ZStack {
            if isSelected {
               
                Image(systemName: icon).resizable().aspectRatio(contentMode: .fit)
                    .foregroundColor(isSelected ? .red : Color(.gray))
                    .frame(width: 28.0, height: 28.0)
            }
            else{
                Image(systemName: icon).resizable().aspectRatio(contentMode: .fit)
                    .foregroundColor(isSelected ? .red : Color(.gray))
                    .frame(width: 20.0, height: 20.0)
            }
        }
        .padding(.vertical, 8.0)
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
enum Item: Int, Tabbable {
    case first = 0
    case second
    case third
    
    var icon: String {
        switch self {
            case .first: "heart.fill"
            case .second: "magnifyingglass"
            case .third:  "house.fill"
        }
    }
    
    var title: String {
        switch self {
            case .first: "Favourite"
            case .second: "Search"
            case .third:  "Home"
        }
    }
}
