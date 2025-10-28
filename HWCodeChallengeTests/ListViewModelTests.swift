//
//  ListViewModelTests.swift
//  HWCodeChallengeTests
//
//  Created by Camilo Masso on 28/10/25.
//

import Combine
import XCTest
@testable import HWCodeChallenge

final class ListViewModelTests: XCTestCase {

    private typealias SUT = ListViewModel<ItemViewModel, MockAPIFetcher>
    
    private var mockAPIFetcher: MockAPIFetcher!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        mockAPIFetcher = .init()
        cancellables = .init()
    }
    
    override func tearDown() {
        cancellables.removeAll()
        cancellables = nil
        mockAPIFetcher = nil
    }

    func testInit_itemsInitialValue_shouldBeEmpty() {
        // Given
        let sut: SUT
        
        // When
        sut = SUT(apiFetcher: mockAPIFetcher)
        
        // Then
        XCTAssertTrue(sut.items.isEmpty)
    }
    
    func testOnAppear_apiFetcher_shouldCallFetch() {
        // Given
        let sut = SUT(apiFetcher: mockAPIFetcher)
        
        // When
        sut.onAppear()
        
        // Then
        XCTAssertTrue(self.mockAPIFetcher.didCallFetch)
    }
    
    func testOnAppear_fetchesFromAPI_shouldUpdateItems() {
        // Given
        let expectation = XCTestExpectation(description: #function)
        mockAPIFetcher.expectation = expectation
        let sut = SUT(apiFetcher: mockAPIFetcher)
        
        // When
        sut.onAppear()
        
        wait(for: [expectation], timeout: 1.0)
        
        // Then
        XCTAssertFalse(sut.items.isEmpty)
    }
}

private final class MockAPIFetcher: APIFetching {
    var didCallFetch = false
    var expectation: XCTestExpectation?
    
    func fetch() async throws -> [String] {
        didCallFetch = true
        expectation?.fulfill()
        return (1...100).map { "\($0)" }
    }
}

private final class ItemViewModel: ItemViewModeling {
    var title: String
    var image: ResourceLoad<UIImage>
    
    init(model: String) {
        title = model
        image = .loading
    }
}
