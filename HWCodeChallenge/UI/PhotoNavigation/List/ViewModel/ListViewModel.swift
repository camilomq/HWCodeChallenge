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
    let title: String
    
    private let remoteService: APIService
    private var hasAppeared = false
    
    init(
        title: String,
        remoteService: APIService
    ) {
        self.title = title
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
        Task { @MainActor in
            do {
                let dtos = try await remoteService.fetch()
                items = dtos.map { ItemVM(model: $0) }
            } catch {
                // Log error
            }
        }
    }
}
