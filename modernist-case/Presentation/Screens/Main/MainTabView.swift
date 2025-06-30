//
//  MainView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            FavoritesView()
                .tabItem {
                    Label("My Favorites", systemImage: "star.fill")
                }

            UsersView()
                .tabItem {
                    Label("Users", systemImage: "person.fill")
                }
        }
    }
}


#Preview {
    MainTabView()
}
