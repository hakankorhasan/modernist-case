//
//  FavoritesView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel


    var body: some View {
        NavigationView {
            VStack {
                if viewModel.favoriteUsers.isEmpty {
                    Text("No favorite users yet.")
                        .foregroundStyle(.gray)
                        .padding(.top, 100)
                } else {
                    List(viewModel.favoriteUsers, id: \.login?.uuid) { user in
                        Button(action: {
                             GlobalNavigationManager.shared.push(.userDetails(user: user), to: \.fullCoverPath)
                         }) {
                             UserCardView(
                                 user: user,
                                 isFavorite: true
                             )
                         }
                         .buttonStyle(PlainButtonStyle())
                         .listRowSeparator(.hidden)
                         .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Favorites")
            .onAppear {
                viewModel.fetchFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView(
            viewModel: FavoritesViewModel(
                addFavoriteUseCase: AppDIContainer.shared.addFavoriteUserUseCase,
                removeFavoriteUseCase: AppDIContainer.shared.removeFavoriteUserUseCase,
                isFavoriteUseCase: AppDIContainer.shared.isFavoriteUserUseCase,
                getAllFavoritesUseCase: AppDIContainer.shared.getAllFavoriteUsersUseCase
            )
        )
}
