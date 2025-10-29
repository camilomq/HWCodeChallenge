//
//  RowViewModel.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import UIKit

protocol RowModel {
    var title: String { get }
    var url: String { get }
}

final class RowViewModel<Model: RowModel>: RowViewModeling {
    @Published var image: ResourceLoad<UIImage> = .loading
        
    var title: String {
        model.title
    }
    
    private let model: Model
    
    init(model: Model) {
        self.model = model
    }
    
    @MainActor
    func start() async {
        do {
            let image = try await ImageLoader.shared.loadImage(url: model.url)
            self.image = .loaded(image)
        } catch {
            image = .error(error, "?")
        }
    }
}
