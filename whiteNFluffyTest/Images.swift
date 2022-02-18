//
//  LikedImages.swift
//  whiteNFluffyTest
//
//  Created by Emil Shpeklord on 06.02.2022.
//

import Foundation

class Images {
    static let shared = Images()

    var photos = [Photo]()
    
    private init() {}
}
