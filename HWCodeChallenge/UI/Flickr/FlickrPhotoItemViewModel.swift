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
    }
    
    @MainActor
    func start() async {
        do {
            let image = try await ImageLoader.shared.loadImage(url: model.url)
            self.image = .loaded(image)
        } catch {
            image = .error(error, "Error loading image")
        }
    }
}
