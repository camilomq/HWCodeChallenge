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

    private typealias SUT = ListViewModel<ItemViewModel, MockRemoteService>
    
    private var mockRemoteService: MockRemoteService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        mockRemoteService = .init()
        cancellables = .init()
    }
    
    override func tearDown() {
        cancellables.removeAll()
        cancellables = nil
        mockRemoteService = nil
    }

    func testInit_itemsInitialValue_shouldBeEmpty() {
        // Given
        let sut: SUT
        
        // When
        sut = SUT(apiFetcher: mockRemoteService)
        
        // Then
        XCTAssertTrue(sut.items.isEmpty)
    }
    
    func testOnAppear_apiFetcher_shouldCallFetch() {
        // Given
        let expectation = XCTestExpectation(description: #function)
        mockRemoteService.expectation = expectation
        let sut = SUT(apiFetcher: mockRemoteService)
        
        // When
        sut.onAppear()
        
        wait(for: [expectation], timeout: 1.0)
        
        // Then
        XCTAssertNotEqual(self.mockRemoteService.fetchCallCount, 0)
    }
    
    func testOnAppear_calledMultipleTimes_shouldFetchOnlyOnce() {
        // Given
        let expectation = XCTestExpectation(description: #function)
        mockRemoteService.expectation = expectation
        let sut = SUT(apiFetcher: mockRemoteService)
        
        // When
        sut.onAppear()
        sut.onAppear()
        
        wait(for: [expectation], timeout: 1.0)
        
        // Then
        XCTAssertEqual(self.mockRemoteService.fetchCallCount, 1)
    }
    
    func testOnAppear_fetchesFromAPI_shouldUpdateItems() {
        // Given
        let expectation = XCTestExpectation(description: #function)
        mockRemoteService.expectation = expectation
        let sut = SUT(apiFetcher: mockRemoteService)
        
        // When
        sut.onAppear()
        
        wait(for: [expectation], timeout: 1.0)
        
        // Then
        XCTAssertFalse(sut.items.isEmpty)
    }
}

private final class MockRemoteService: RemoteService {
    var fetchCallCount = 0
    var expectation: XCTestExpectation?
    
    func fetch() async throws -> [String] {
        fetchCallCount += 1
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
