//
//  DetailView.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import SwiftUI

protocol DetailViewModeling: ObservableObject {
    var title: String { get }
    var image: LoadingResource<UIImage> { get }
    var text: String { get }
    func startLoading() async
}

struct DetailView<ViewModel: DetailViewModeling>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.title)
            Spacer()
            LoadingImageView(viewModel.image)
            Spacer()
            Text(viewModel.text)
        }
        .task {
            await viewModel.startLoading()
        }
    }
}

#Preview {
    DetailView(viewModel: PreviewItem())
}

private final class PreviewItem: DetailViewModeling {
    var title: String = "Some title"
    var image: LoadingResource<UIImage> = .loaded(.image(color: .orange))
    var text: String = "Some text"
    
    func startLoading() async {}
}
