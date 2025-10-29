//
//  ItemViewModel.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import UIKit

protocol ItemModel: Identifiable, RowModel, DetailModel {}

final class ItemViewModel<Model: ItemModel>: ItemViewModeling {
    lazy var rowVM = RowViewModel(model: model)
    lazy var detailVM = DetailViewModel(model: model)
    
    var id: Model.ID {
        model.id
    }
    
    private let model: Model
    
    init(model: Model) {
        self.model = model
    }
}
