//
//  MainView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var userVM: UsersViewModel
    
    var body: some View {
        TabView {
            UsersView(usersViewModel: userVM)
                .tabItem {
                    Label("Users", systemImage: "person.fill")
                }
            
            FavoritesView()
                .tabItem {
                    Label("My Favorites", systemImage: "star.fill")
                }
        }
    }
}


#Preview {
    MainTabView(userVM: UsersViewModel())
}
