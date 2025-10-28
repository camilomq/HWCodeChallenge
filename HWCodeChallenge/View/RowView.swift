//
//  RowView.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import SwiftUI

protocol RowViewModeling {
    var title: String { get }
}

struct RowView<ViewModel: RowViewModeling>: View {
    let viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.title)
    }
}

#Preview {
    RowView(viewModel: PreviewItem(title: "Some title"))
}

private struct PreviewItem: RowViewModeling {
    var title: String
}
