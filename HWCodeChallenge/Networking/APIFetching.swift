//
//  APIFetching.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Foundation

protocol APIFetching {
    associatedtype DTO: Decodable
    func fetch() async throws -> [DTO]
}
