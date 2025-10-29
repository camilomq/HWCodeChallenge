//
//  DetailView.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import SwiftUI

struct DetailView<ViewModel: DetailViewModeling>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        ImageView(viewModel.image)
    }
}

#Preview {
    DetailView(viewModel: PreviewItem(image: .image(color: .orange)))
}

private final class PreviewItem: DetailViewModeling {
    var image: ResourceLoad<UIImage>
    
    init(image: UIImage) {
        self.image = ResourceLoad.loaded(image)
    }
}
