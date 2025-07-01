//
//  UserCardView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//
import SwiftUI

struct UserCardView: View {
    let user: User
    let isFavorite: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                if let urlString = user.picture?.thumbnail, let url = URL(string: urlString) {
                    AsyncImage(url: url)
                        .scaledToFit()
                        .frame(height: AppConstants.Size.buttonHeight64)
                        .cornerRadius(AppConstants.CornerRadius.medium)
                        .clipped()
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: AppConstants.Size.buttonHeight64)
                        .cornerRadius(AppConstants.CornerRadius.medium)
                        .clipped()
                }
                
                VStack(alignment: .leading, spacing: AppConstants.Padding.medium) {
                    Text("\(user.name?.title ?? "") \(user.name?.first ?? "") \(user.name?.last ?? "")")
                        .font(.system(size: AppConstants.Font.body, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text(user.email ?? "")
                        .font(.system(size: AppConstants.Font.body, weight: .medium))
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding(.vertical, AppConstants.Padding.large)
            .padding(.horizontal, AppConstants.Padding.medium)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(AppConstants.CornerRadius.large)
            .shadow(color: .black.opacity(0.35), radius: 8, x: 0, y: 4)

            Image(systemName: isFavorite ? "star.fill" : "star")
                .foregroundColor(.yellow)
                .padding(12)
            
        }
    }
}
