//
//  UserCardView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//
import SwiftUI

struct UserCardView: View {
    let user: RandomUser

    var body: some View {
        HStack {
            Image("onur")
                .resizable()
                .scaledToFit()
                .frame(height: AppConstants.Size.buttonHeight64)
                .cornerRadius(AppConstants.CornerRadius.medium)
                .clipped()
            
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
        .padding(AppConstants.Padding.medium)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(AppConstants.CornerRadius.large)
        .shadow(color: .black.opacity(0.35), radius: 8, x: 0, y: 4)
        .padding(.horizontal, AppConstants.Padding.medium)
    }
}
