//
//  DetailViewModel.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import UIKit

protocol DetailModel {
    var title: String { get }
    var photoUrl: String { get }
    var ownerName: String { get }
}

final class DetailViewModel<Model: DetailModel>: DetailViewModeling {
    @Published var image: LoadingResource<UIImage> = .loading
    
    var title: String {
        model.title
    }
    
    var text: String {
        "Photo by: \(model.ownerName)"
    }
    
    private let model: Model
    
    init(model: Model) {
        self.model = model
    }
    
    @MainActor
    func startLoading() async {
        do {
            let image = try await ImageLoader.shared.loadImage(url: model.photoUrl)
            self.image = .loaded(image)
        } catch {
            image = .error(error, "Error loading image")
        }
    }
}
