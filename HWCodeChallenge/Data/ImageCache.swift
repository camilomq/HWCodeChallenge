//
//  ImageCache.swift
//  HWCodeChallenge
//
//  Created by Camilo Masso on 29/10/25.
//

import Foundation
import UIKit

actor ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
    
    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }
}
