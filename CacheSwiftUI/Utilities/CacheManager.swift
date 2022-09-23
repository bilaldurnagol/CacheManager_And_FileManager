//
//  CacheManager.swift
//  CacheSwiftUI
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import SwiftUI

class CacheManager {
    
    static let shared = CacheManager()
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 100mb
        return cache
    }()
    
    func add(with key: String, image: UIImage) {
        imageCache.setObject(image, forKey: key as NSString)
        print("Added to cache")
    }
    
    func remove(from key: String) {
        imageCache.removeObject(forKey: key as NSString)
        print("Removed to cache")
    }
    
    func get(to key: String) -> UIImage? {
       return imageCache.object(forKey: key as NSString)
    }
}
