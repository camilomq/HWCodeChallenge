//
//  RowView.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import SwiftUI

protocol RowViewModeling: ObservableObject {
    var title: String { get }
    var image: ResourceLoad<UIImage> { get }
    func start() async
}

struct RowView<ViewModel: RowViewModeling>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        HStack {
            ImageView(viewModel.image, contentMode: .fill)
                .frame(width: 44, height: 44)
                .clipped()
            Text(viewModel.title)
                .lineLimit(2)
        }
        .task {
            await viewModel.start()
        }
    }
}

#Preview {
    RowView(viewModel: PreviewItem())
}

private final class PreviewItem: RowViewModeling {
    var title: String = "Some title"
    var image: ResourceLoad<UIImage> = .loaded(.image(color: .green))
    
    func start() async {}
}
