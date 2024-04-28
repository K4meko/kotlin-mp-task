import SwiftUI


struct ContentView: View {


    var body: some View {
        TabView {
                   HomeView()
                       .tabItem {
                           Label("Home", systemImage: "house.fill")
                       }
                   
                   SearchView()
                       .tabItem {
                           Label("Search", systemImage: "magnifyingglass")
                       }
                   
//                   SettingsView()
//                       .tabItem {
//                           Label("Settings", systemImage: "gear")
//                       }
               }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
