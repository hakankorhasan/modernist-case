//
//  ImageCacheManager.swift
//  modernist-case
//
//  Created by Hakan on 2.07.2025.
//

import Foundation
import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    func saveImageToDisk(imageData: Data, fileName: String) -> URL? {
        let fileManager = FileManager.default
        guard let docs = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = docs.appendingPathComponent(fileName)
        do {
            try imageData.write(to: fileURL)
            return fileURL
        } catch {
            print("❌ Error saving image to disk: \(error)")
            return nil
        }
    }
}
