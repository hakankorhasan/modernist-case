//
//  UserCardView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//
import SwiftUI

struct UserCardView: View {
    let user: User

    var body: some View {
        HStack {
            Image("onur")
                .resizable()
                .scaledToFit()
                .frame(height: 64)
                .cornerRadius(8)
                .clipped()
            
            VStack(alignment: .leading, spacing: 16) {
                Text(user.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Text(user.email)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.35), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 16)
    }
}
