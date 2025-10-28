//
//  ListView.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import SwiftUI

protocol ItemViewModeling: Identifiable, RowViewModeling, DetailViewModeling {}

protocol ListViewModeling: ObservableObject {
    associatedtype ItemVM: ItemViewModeling
    var items: [ItemVM] { get }
}

struct ListView<ViewModel: ListViewModeling>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.items) { itemVM in
            NavigationLink {
                DetailView(viewModel: itemVM)
            } label: {
                RowView(viewModel: itemVM)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListView(viewModel: PreviewViewModel())
    }
}

private final class PreviewViewModel: ListViewModeling {
    
    struct Item: ItemViewModeling {
        let title: String
        let id = UUID()
        var text: String { title }
    }
    
    var items = [
        Item(title: "One"),
        Item(title: "Two")
    ]
}
