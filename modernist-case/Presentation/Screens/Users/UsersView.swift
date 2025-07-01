//
//  UsersView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

struct UsersView: View {
    
    @StateObject var usersViewModel: UsersViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // SearchBar
                SearchBarView(text: $usersViewModel.searchText)
                
                if usersViewModel.isLoading {
                    ProgressView("Loading users...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let error = usersViewModel.errorMessage {
                    Text("⚠️ \(error)")
                        .foregroundStyle(.red)
                } else {
                    List(usersViewModel.filteredUsers, id: \.login?.uuid) { user in
                        Button(action: {
                             GlobalNavigationManager.shared.push(.userDetails(user: user), to: \.fullCoverPath)
                         }) {
                             UserCardView(
                                 user: user,
                                 isFavorite: usersViewModel.isFavorite(user)
                             )
                         }
                         .buttonStyle(PlainButtonStyle())
                         .listRowSeparator(.hidden)
                         .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .onAppear {
                        usersViewModel.loadFavorites()
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                await usersViewModel.loadUsers()
            }
        }
    }

}

#Preview {
    UsersView(usersViewModel: UsersViewModel())
}
