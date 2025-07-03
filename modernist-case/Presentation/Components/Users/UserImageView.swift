//
//  UserImageView.swift
//  modernist-case
//
//  Created by Hakan on 2.07.2025.
//
0
import SwiftUI

struct UserImageView: View {
    let imagePathOrURL: String?
    let height: CGFloat
    let cornerRadius: CGFloat

    var body: some View {
        Group {
            if let path = imagePathOrURL {
                if path.starts(with: "/") {
                    
                    let localURL = URL(fileURLWithPath: path)
                    if let data = try? Data(contentsOf: localURL),
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        placeholderImage
                    }
                } else if path.starts(with: "file://") {
                    if let localURL = URL(string: path),
                       let data = try? Data(contentsOf: localURL),
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        placeholderImage
                    }
                } else if let url = URL(string: path) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable().scaledToFit()
                        case .failure:
                            placeholderImage
                        @unknown default:
                            placeholderImage
                        }
                    }
                } else {
                    placeholderImage
                }
            } else {
                placeholderImage
            }
        }
        .frame(height: height)
        .cornerRadius(cornerRadius)
        .clipped()
    }

    private var placeholderImage: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray.opacity(0.5))
    }
}
