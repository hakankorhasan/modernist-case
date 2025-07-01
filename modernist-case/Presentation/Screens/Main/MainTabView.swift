//
//  MainView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var nav = GlobalNavigationManager.shared
    @StateObject var usersVM = UsersViewModel()
    @State private var selectedTab: Int = 0

    var body: some View {
        NavigationStack(path: $nav.fullCoverPath) {
            TabView(selection: $selectedTab) {
                UsersView(usersViewModel: UsersViewModel())
                    .tag(0)
                    .tabItem {
                        Label("Users", systemImage: "person.3")
                    }
                FavoritesView()
                    .tag(1)
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
            }
            .onChange(of: selectedTab) { _ in
                nav.fullCoverPath.removeAll()
            }
            .navigationDestination(for: ParkyViewName.self) { destination in
                switch destination {
                case .users:
                    UsersView(usersViewModel: usersVM)
                case .favorites:
                    FavoritesView()
                case .userDetails(let user):
                    UserDetailsView(user: user)
                }
            }
        }

    }
}
