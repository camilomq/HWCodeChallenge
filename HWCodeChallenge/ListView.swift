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
    
    final class Item: ItemViewModeling {
        let title: String
        let id = UUID()
        let image: ResourceLoad<UIImage>
        
        init(title: String, image: ResourceLoad<UIImage>) {
            self.title = title
            self.image = image
        }
    }
    
    var items = [
        Item(title: "Blue", image: .loaded(.image(color: .blue))),
        Item(title: "Orange", image: .loaded(.image(color: .orange))),
        Item(title: "Still loading", image: .loading)
    ]
}
