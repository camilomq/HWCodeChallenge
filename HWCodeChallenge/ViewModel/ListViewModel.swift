//
//  ListViewModel.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine

final class ListViewModel<ItemVM, APIFetcher>: ListViewModeling
where ItemVM: ItemViewModeling, APIFetcher: APIFetching, ItemVM.Model == APIFetcher.DTO {
    @Published var items: [ItemVM] = []
    
    private let apiService: APIFetcher
    private var cancellables = Set<AnyCancellable>()
    
    init(apiService: APIFetcher) {
        self.apiService = apiService
    }
    
    func start() {
        fetchItems()
    }
    
    private func fetchItems() {
        Task {
            do {
                let dtos = try await apiService.fetch()
                items = dtos.map { ItemVM(model: $0) }
            } catch {
                // Log error
            }
        }
    }
}
