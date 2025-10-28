//
//  DetailView.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import SwiftUI

protocol DetailViewModeling {
    var text: String { get }
}

struct DetailView<ViewModel: DetailViewModeling>: View {
    let viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.text)
    }
}

#Preview {
    DetailView(viewModel: PreviewItem(text: "Some description"))
}

private struct PreviewItem: DetailViewModeling {
    var text: String
}
