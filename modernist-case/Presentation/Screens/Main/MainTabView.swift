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

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}


#Preview {
    MainTabView()
}
