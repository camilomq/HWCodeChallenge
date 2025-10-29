//
//  ItemViewModeling.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Foundation

protocol ItemViewModeling: Identifiable, RowViewModeling, DetailViewModeling {
    associatedtype Model
    init(model: Model)
}
