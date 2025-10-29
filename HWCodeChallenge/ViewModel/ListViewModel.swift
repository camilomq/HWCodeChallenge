//
//  ListViewModel.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine

final class ListViewModel<ItemVM, APIFetcher>: ListViewModeling
where ItemVM: ItemViewModeling, APIFetcher: RemoteService, ItemVM.Model == APIFetcher.DTO {
    @Published var items: [ItemVM] = []
    
    private let apiFetcher: APIFetcher
    private var hasAppeared = false
    
    init(apiFetcher: APIFetcher) {
        self.apiFetcher = apiFetcher
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
                let dtos = try await apiFetcher.fetch()
                items = dtos.map { ItemVM(model: $0) }
            } catch {
                // Log error
            }
        }
    }
}
