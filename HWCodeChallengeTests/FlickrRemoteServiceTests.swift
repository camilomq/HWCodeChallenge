//
//  FlickrRemoteServiceTests.swift
//  HWCodeChallengeTests
//
//  Created by Camilo Masso on 29/10/25.
//

import XCTest
@testable import HWCodeChallenge

final class FlickrRemoteServiceTests: XCTestCase {
    
    func testDecoding_responseJSONData_shouldSucceed() throws {
        // Given
        let json = """
            {
                "photos": {
                    "page": 1,
                    "pages": 1048,
                    "perpage": 100,
                    "total": 104716,
                    "photo": [
                        {
                            "id": "54886661192",
                            "owner": "14533495@N00",
                            "secret": "fb9b88705d",
                            "server": "65535",
                            "farm": 66,
                            "title": "Z62_3872",
                            "ispublic": 1,
                            "isfriend": 0,
                            "isfamily": 0,
                            "ownername": "Dober Man",
                            "url_t": "https://live.staticflickr.com/65535/54886661192_fb9b88705d_t.jpg",
                            "height_t": 67,
                            "width_t": 100,
                            "url_l": "https://live.staticflickr.com/65535/54886661192_fb9b88705d_b.jpg",
                            "height_l": 681,
                            "width_l": 1024
                        }
                    ]
                }
            }
            """
        let data = try XCTUnwrap(json.data(using: .utf8))
        let sut = FlickrRemoteService()
        
        // When
        let photoDTOs = try sut.decode(data: data)
        
        // Then
        XCTAssertFalse(photoDTOs.isEmpty)
    }
}
