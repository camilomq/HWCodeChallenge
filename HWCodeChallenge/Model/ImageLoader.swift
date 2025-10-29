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
    
    private init() {}
    
    func loadImage(url: String) async throws -> UIImage {
        guard let imageURL = URL(string: url) else {
            throw ImageLoaderError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: imageURL)
        guard let image = UIImage(data: data) else {
            throw ImageLoaderError.invalidData
        }
        return image
    }
}
