//
//  RandomUnsplashPhoto.swift
//  whiteNFluffyTest
//
//  Created by Emil Shpeklord on 31.01.2022.
//

import Foundation

struct RandomPhotoResponse: Codable {
    var urls: Urls?
    var user: User?
    var likes: Int?
    var likedByUser: Bool?
}

struct Photo {
    var url: String?
    var author: String?
    var likes: Int?
    var likedByUser: Bool?
}

struct Urls: Codable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
}

//struct Location: Codable {
//    var title: NSNull?
//    var name: NSNull?
//    var city: NSNull?
//    var country: NSNull?
//    var position: Position?
//}

struct User: Codable {
    var id: String?
    var updatedAt: Date?
    var username: String?
    var name: String?
    var firstName: String?
    var lastName: String?
}
//
//struct Position: Codable {
//    var latitude: NSNull?
//    var longitude: NSNull?
//}
