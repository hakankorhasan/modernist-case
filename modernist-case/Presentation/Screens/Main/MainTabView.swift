//
//  MainView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var nav = GlobalNavigationManager.shared

    // Burada DI container'dan aldığın use case'lerle oluştur
    @StateObject private var usersVM = UsersViewModel(
        fetchUserUseCase: AppDIContainer.shared.fetchUsersUseCase,
        addFavoriteUseCase: AppDIContainer.shared.addFavoriteUserUseCase,
        removeFavoriteUseCase: AppDIContainer.shared.removeFavoriteUserUseCase,
        getAllFavoritesUseCase: AppDIContainer.shared.getAllFavoriteUsersUseCase
    )
    
    @StateObject private var favoritesVM = FavoritesViewModel(
        addFavoriteUseCase: AppDIContainer.shared.addFavoriteUserUseCase,
        removeFavoriteUseCase: AppDIContainer.shared.removeFavoriteUserUseCase,
        isFavoriteUseCase: AppDIContainer.shared.isFavoriteUserUseCase,
        getAllFavoritesUseCase: AppDIContainer.shared.getAllFavoriteUsersUseCase
    )

    @State private var selectedTab: Int = 0

    var body: some View {
        NavigationStack(path: $nav.fullCoverPath) {
            TabView(selection: $selectedTab) {
                UsersView(usersViewModel: usersVM) 
                    .tag(0)
                    .tabItem {
                        Label("Users", systemImage: "person.3")
                    }
                FavoritesView(viewModel: favoritesVM)
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
                    FavoritesView(viewModel: favoritesVM)
                case .userDetails(let user):
                    UserDetailsView(user: user)
                }
            }
        }
    }
}
