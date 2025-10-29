//
//  ListViewModel.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine

final class ListViewModel<ItemVM, APIService>: ListViewModeling
where ItemVM: ItemViewModeling, APIService: RemoteService, ItemVM.Model == APIService.DTO {
    @Published var items: [ItemVM] = []
    
    private let remoteService: APIService
    private var hasAppeared = false
    
    init(remoteService: APIService) {
        self.remoteService = remoteService
    }
    
    func onAppear() {
        guard !hasAppeared else {
            return
        }
        hasAppeared = true
        fetchItems()
    }
    
    private func fetchItems() {
        Task {
            do {
                let dtos = try await remoteService.fetch()
                items = dtos.map { ItemVM(model: $0) }
            } catch {
                // Log error
            }
        }
    }
}
