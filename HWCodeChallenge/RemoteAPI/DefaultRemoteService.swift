//
//  DefaultRemoteService.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Foundation

enum RemoteServiceError: Error {
    case invalidURL
    case invalidServerResponse
}

class DefaultRemoteService<DTO: Decodable>: RemoteService {
    
    func buildURL() throws -> URL {
        throw RemoteServiceError.invalidURL
    }
    
    func fetch() async throws -> [DTO] {
        let url = try buildURL()
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw RemoteServiceError.invalidServerResponse
        }
        
        return try decode(data: data)
    }
    
    func decode(data: Data) throws -> [DTO] {
        return try JSONDecoder().decode([DTO].self, from: data)
    }
}
