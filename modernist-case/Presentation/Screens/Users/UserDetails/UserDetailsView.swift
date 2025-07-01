//
//  UserDetailsView.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
import SwiftUI

struct UserDetailsView: View {
    let user: RandomUser
    
    @StateObject private var viewModel: UserDetailsViewModel
    
    init(user: RandomUser) {
        self.user = user
        _viewModel = StateObject(wrappedValue: UserDetailsViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Name
                Text("\(user.name?.title ?? "") \(user.name?.first ?? "") \(user.name?.last ?? "")")
                    .font(.largeTitle.bold())

                // Username
                HStack {
                    Image(systemName: "person.fill")
                    Text("@\(user.login?.username ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Email
                HStack {
                    Image(systemName: "envelope.fill")
                    Text(user.email ?? "")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                
                // Phone
                HStack {
                    Image(systemName: "phone.fill")
                    Text(user.phone ?? "")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
                
                // Address Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Address")
                        .font(.headline)

                    Text("Street Number: \(user.location?.street?.number ?? 0)")
                    Text("Street Name: \(user.location?.street?.name ?? "Unknown")")
                    Text("State: \(user.location?.state ?? "Unknown")")
                    Text("Country: \(user.location?.country ?? "Unknown")")
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
    UserDetailsView(user: RandomUser(
        gender: "male",
        name: Name(title: "Mr", first: "Hakan", last: "Körhasan"),
        location: Location(
            street: Street(number: 18, name: "Söğüt Sk."),
            city: "İstanbul",
            state: "İstanbul",
            country: "Turkey",
            postcode: 1234,
            coordinates: Coordinates(latitude: "41.0082", longitude: "28.9784"),
            timezone: Timezone(offset: "+3:00", description: "GMT+3 Istanbul")
        ),
        email: "hakankorhasan@example.com",
        login: Login(
            uuid: "123e4567-e89b-12d3-a456-426614174000",
            username: "hakankorhasan",
            password: "password123",
            salt: "salt",
            md5: "md5hash",
            sha1: "sha1hash",
            sha256: "sha256hash"
        ),
        dob: DateInfo(date: "1990-01-01T00:00:00Z", age: 35),
        registered: DateInfo(date: "2020-01-01T00:00:00Z", age: 5),
        phone: "+905340618277",
        cell: "+905340618278",
        id: ID(name: "TC", value: "12345678901"),
        picture: Picture(
            large: "https://randomuser.me/api/portraits/men/1.jpg",
            medium: "https://randomuser.me/api/portraits/med/men/1.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/men/1.jpg"
        ),
        nat: "TR"
    ))
}
