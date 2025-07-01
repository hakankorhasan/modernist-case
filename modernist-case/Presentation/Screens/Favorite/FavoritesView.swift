//
//  FavoritesView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel

    init(viewModel: FavoritesViewModel = FavoritesViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.favoriteUsers.isEmpty {
                    Text("No favorite users yet.")
                        .foregroundStyle(.gray)
                        .padding(.top, 100)
                } else {
                    List(viewModel.favoriteUsers, id: \.login?.uuid) { user in
                        NavigationLink(destination: UserDetailsView(user: user)) {
                            UserCardView(
                                user: user,
                                isFavorite: true,
                            )
                        }
                        .listRowSeparator(.hidden)
                        .buttonStyle(PlainButtonStyle())
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
    FavoritesView(viewModel: FavoritesViewModel())
}
