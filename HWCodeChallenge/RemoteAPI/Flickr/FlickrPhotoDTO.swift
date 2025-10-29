//
//  FlickrPhotoDTO.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Foundation

struct FlickrPhotoDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case thumbnailUrl = "url_t"
        case largePhotoUrl = "url_l"
        case id
        case title
        case ownerName = "ownername"
    }
    
    let id: String
    let title: String
    let thumbnailUrl: String
    var largePhotoUrl: String?
    let ownerName: String
}

extension FlickrPhotoDTO: ItemModel {
    var photoUrl: String {
        largePhotoUrl ?? thumbnailUrl
    }
}
