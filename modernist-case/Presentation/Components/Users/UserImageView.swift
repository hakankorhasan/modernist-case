//
//  UserImageView.swift
//  modernist-case
//
//  Created by Hakan on 2.07.2025.
//

import SwiftUI

struct UserImageView: View {
    let imagePathOrURL: String?
    let height: CGFloat
    let cornerRadius: CGFloat

    var body: some View {
        Group {
            if let path = imagePathOrURL, let url = URL(string: path), path.starts(with: "http") {
                // 🌐 Önce AsyncImage ile internetten dene
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: height)
                    case .success(let image):
                        imageView(image: image)
                    case .failure:
                        localImageFallback(for: path)
                    @unknown default:
                        placeholderImage
                    }
                }
            } else {
                
                localImageFallback(for: imagePathOrURL)
            }
        }
        .frame(height: height)
        .cornerRadius(cornerRadius)
        .clipped()
    }

    private func getLocalImageURL(fileName: String) -> URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
    }

    
    private func localImageFallback(for fileName: String?) -> some View {
        guard let fileName = fileName else {
            print("Path nil")
            return AnyView(placeholderImage)
        }
        
        guard let fileURL = getLocalImageURL(fileName: fileName) else {
            print("URL oluşturulamadı")
            return AnyView(placeholderImage)
        }
        
        print("Checking path: \(fileURL.path)")
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("Dosya bulunamadı: \(fileURL.path)")
            return AnyView(placeholderImage)
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
            print("Dosya okunamadı: \(fileURL.path)")
            return AnyView(placeholderImage)
        }
        
        guard let uiImage = UIImage(data: data) else {
            print("UIImage oluşturulamadı: \(fileURL.path)")
            return AnyView(placeholderImage)
        }
        
        return AnyView(
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        )
    }



    private func imageView(image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
    }

    private var placeholderImage: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray.opacity(0.5))
    }
}
