//
//  FlickrPhotoDTO.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Foundation

struct FlickrPhotoDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case url = "url_t"
        case id
        case title
        case ownerName = "ownername"
    }
    
    let id: String
    let title: String
    let url: String
    let ownerName: String
}

extension FlickrPhotoDTO: ItemModel {}
