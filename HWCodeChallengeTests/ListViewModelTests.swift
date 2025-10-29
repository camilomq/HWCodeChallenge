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

    private typealias SUT = ListViewModel<MockStringModel, MockRemoteService>
    
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
        sut = SUT(title: "Some title", remoteService: mockRemoteService)
        
        // Then
        XCTAssertTrue(sut.items.isEmpty)
    }
    
    func testOnAppear_apiFetcher_shouldCallFetch() {
        // Given
        let expectation = XCTestExpectation(description: #function)
        mockRemoteService.expectation = expectation
        let sut = SUT(title: "Some title", remoteService: mockRemoteService)
        
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
        let sut = SUT(title: "Some title", remoteService: mockRemoteService)
        
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
        let sut = SUT(title: "Some title", remoteService: mockRemoteService)
        
        sut.$items
            .dropFirst()
            .sink { items in
                // Then
                XCTAssertFalse(items.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.onAppear()
        
        wait(for: [expectation], timeout: 1.0)
    }
}

private final class MockRemoteService: RemoteService {
    var fetchCallCount = 0
    var expectation: XCTestExpectation?
    
    func fetch() async throws -> [MockStringModel] {
        fetchCallCount += 1
        expectation?.fulfill()
        return (1...100).map { MockStringModel(model: "\($0)") }
    }
}

private final class MockStringModel: ItemModel, Decodable {
    private let model: String
    var url: String { model }
    var title: String { model }
    var text: String { model }
    var ownerName: String { model }
    
    init(model: String) {
        self.model = model
    }
}
