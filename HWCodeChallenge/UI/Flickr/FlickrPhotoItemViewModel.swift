//
//  FlickrPhotoItemViewModel.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import UIKit

final class FlickrPhotoItemViewModel: ItemViewModeling {
    @Published var image: ResourceLoad<UIImage> = .loading
        
    var title: String {
        model.title
    }
    
    private let model: FlickrPhotoDTO
    
    init(model: FlickrPhotoDTO) {
        self.model = model
        Task { @MainActor in
            do {
                try await fetchImage()
            } catch {
                image = .error(error, "Error loading image")
            }
        }
    }
    
    func fetchImage() async throws {
        let image = try await ImageLoader.shared.loadImage(url: model.url)
        self.image = .loaded(image)
    }
}
