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
                    List(usersViewModel.filteredUsers) { user in
                        NavigationLink(destination: UserDetailsView(user: user)) {
                            UserCardView(user: user)
                        }
                        .listRowSeparator(.hidden)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
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
