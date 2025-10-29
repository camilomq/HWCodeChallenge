//
//  FlickrRemoteService.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Foundation

final class FlickrRemoteService: DefaultRemoteService<FlickrPhotoDTO> {
    
    override func buildURL() throws -> URL {
        var urlComponents = URLComponents(
            string: "https://api.flickr.com/services/rest"
        )
        urlComponents?.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: Secrets.flickrAPIKey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "text", value: "dog"),
            URLQueryItem(name: "safe_search", value: "1"),
            URLQueryItem(name: "extras", value: "url_t"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
        ]
        
        guard let url = urlComponents?.url else {
            throw RemoteServiceError.invalidURL
        }
        return url
    }
    
    override func decode(data: Data) throws -> [FlickrPhotoDTO] {
        let responseObject = try JSONDecoder().decode(ResponseDTO.self, from: data)
        return responseObject.photos.photo
    }
}

// Custom DTO to map reponse to expected output
private struct ResponseDTO: Decodable {
    struct PhotosDTO: Decodable {
        let photo: [FlickrPhotoDTO]
    }
    let photos: PhotosDTO
}
