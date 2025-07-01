//
//  UserDetailsView.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
import SwiftUI

struct UserDetailsView: View {
    let user: User
    
    @StateObject private var viewModel: UserDetailsViewModel
    
    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: UserDetailsViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Name
                Text(user.name)
                    .font(.largeTitle.bold())

                // Username
                HStack {
                    Image(systemName: "person.fill")
                    Text("@\(user.username)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Email
                HStack {
                    Image(systemName: "envelope.fill")
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                
                // Phone
                HStack {
                    Image(systemName: "phone.fill")
                    Text(user.phone)
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
                
                // Address Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Address")
                        .font(.headline)

                    Text(user.address.street)
                    Text(user.address.suite)
                    Text(user.address.city)
                    Text(user.address.zipcode)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                Divider()
                
                Button(action: {
                    viewModel.toggleFavorite()
                }) {
                    HStack {
                        Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                            .foregroundColor(viewModel.isFavorite ? .yellow : .gray)
                        Text(viewModel.isFavorite ? "Remove From Favorites" : "Add To Favorites")
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("User Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserDetailsView(user: User(
        id: 1,
         name: "Hakan Körhasan",
         username: "hakankorhasan",
         email: "hakankorhasann@gmail.com",
         address: Address(
             street: "Söğüt Sk.",
             suite: "No:18 D:2",
             city: "İstanbul",
             zipcode: "34000",
             geo: Geo(lat: "41.0082", lng: "28.9784")
         ),
         phone: "+905340618277",
         website: "hakan.dev",
         company: Company(
             name: "OpenAI",
             catchPhrase: "Shaping the future",
             bs: "AI innovation"
         )
    ))
}
