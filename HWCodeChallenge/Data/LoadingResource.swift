//
//  LoadingResource.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 28/10/25.
//

import Foundation

enum LoadingResource<T> {
    case loaded(T)
    case loading
    case error(Error, String)
}
