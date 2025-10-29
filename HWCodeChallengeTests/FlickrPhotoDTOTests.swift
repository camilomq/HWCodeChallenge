//
//  FlickrPhotoDTOTests.swift
//  HWCodeChallengeTests
//
//  Created by Camilo Masso on 29/10/25.
//

import XCTest
@testable import HWCodeChallenge

final class FlickrPhotoDTOTests: XCTestCase {
    
    func testDecodable_initFromJSONData_shouldSucceed() throws {
        // Given
        let json = """
            {
                "id": "54887452623",
                "owner": "80365963@N00",
                "secret": "a0dd560bcb",
                "server": "65535",
                "farm": 66,
                "title": "Dog team Fort McMurray Alberta",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0,
                "ownername": "jasonwoodhead23",
                "url_t": "https://live.staticflickr.com/65535/54887452623_a0dd560bcb_t.jpg",
                "height_t": 64,
                "width_t": 100,
                "url_l": "https://live.staticflickr.com/65535/54887452623_a0dd560bcb_b.jpg",
                "height_l": 657,
                "width_l": 1024
            }
            """
        let data = try XCTUnwrap(json.data(using: .utf8))
        
        // When
        let sut = try JSONDecoder().decode(FlickrPhotoDTO.self, from: data)
        
        // Then
        XCTAssertEqual(sut.id, "54887452623")
        XCTAssertEqual(sut.thumbnailUrl, "https://live.staticflickr.com/65535/54887452623_a0dd560bcb_t.jpg")
        XCTAssertEqual(sut.largePhotoUrl, "https://live.staticflickr.com/65535/54887452623_a0dd560bcb_b.jpg")
        XCTAssertEqual(sut.title, "Dog team Fort McMurray Alberta")
        XCTAssertEqual(sut.ownerName, "jasonwoodhead23")
    }
}
