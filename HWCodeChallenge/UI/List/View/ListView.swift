//
//  ListView.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import SwiftUI

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
        .navigationTitle(viewModel.title)
        .onAppear {
            viewModel.onAppear()
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
        struct Model {
            let title: String
            let id = UUID()
            let image: ResourceLoad<UIImage>
            
            init(title: String, image: ResourceLoad<UIImage>) {
                self.title = title
                self.image = image
            }
        }
        
        let model: Model
        var title: String { model.title }
        var id: UUID { model.id }
        var image: ResourceLoad<UIImage> { model.image }
        
        init(model: Model) {
            self.model = model
        }
        
        func start() async {}
    }
    
    var items = [
        Item.Model(title: "Blue", image: .loaded(.image(color: .blue))),
        Item.Model(title: "Orange", image: .loaded(.image(color: .orange))),
        Item.Model(title: "Still loading", image: .loading)
    ].map { Item(model: $0) }
    
    var title: String { "Colors" }
    
    func onAppear() {}
}
