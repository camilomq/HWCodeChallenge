//
//  ImageLoader.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import UIKit

enum ImageLoaderError: Error {
    case invalidURL
    case invalidData
}

final class ImageLoader {
    static let shared = ImageLoader()
    
    private let cache = ImageCache()
    
    private init() {}
    
    func loadImage(url: String) async throws -> UIImage {
        guard let imageURL = URL(string: url) else {
            throw ImageLoaderError.invalidURL
        }
        
        if let cachedImage = await cache.image(forKey: url) {
            return cachedImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: imageURL)
        guard let image = UIImage(data: data) else {
            throw ImageLoaderError.invalidData
        }
        
        await cache.setImage(image, forKey: url)
        return image
    }
}
