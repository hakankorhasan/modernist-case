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
                if usersViewModel.isLoading {
                    ProgressView("Loading users...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let error = usersViewModel.errorMessage {
                    Text("⚠️ \(error)")
                        .foregroundStyle(.red)
                } else {
                    List(usersViewModel.users) { user in
                        UserCardView(user: user)
                            .listRowSeparator(.hidden)
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
