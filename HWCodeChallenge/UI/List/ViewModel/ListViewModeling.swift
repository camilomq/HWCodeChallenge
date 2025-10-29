//
//  ListViewModeling.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine

protocol ListViewModeling: ObservableObject {
    associatedtype ItemVM: ItemViewModeling
    var items: [ItemVM] { get }
    func onAppear()
}
