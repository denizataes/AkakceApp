//
//  TabView.swift
//  AkakceApp
//
//  Created by Deniz Ata Eş on 14.06.2023.
//
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
                MenuView()
            .tabItem {
                Image(systemName: "house")
                Text("Ana Sayfa")
            }
            NavigationView{
                Text("Arama")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Arama")
            }
            NavigationView{
                Text("Takip Listem")
            }
            .tabItem {
                Image(systemName: "bell.fill")
                Text("Takip Listem")
            }
            
            NavigationView{
                Text("Uygulamalar")
            }
            .tabItem {
                Image(systemName: "square.on.square")
                Text("Uygulamalar")
            }
            
        }
        
    }
}
struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
