//
//  ListViewModel.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine

final class ListViewModel<Model, APIService>: ListViewModeling
where Model: ItemModel, APIService: RemoteService, Model == APIService.DTO {
    @Published var items: LoadingResource<[ItemViewModel<Model>]> = .loading
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
                let modelObjects = try await remoteService.fetch()
                let items = modelObjects.map { ItemViewModel(model: $0) }
                self.items = .loaded(items)
            } catch {
                self.items = .error(error, "Error loading data")
            }
        }
    }
}
