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

struct User: Codable {
	var id: String?
	var updatedAt: Date?
	var username: String?
	var name: String?
	var firstName: String?
	var lastName: String?
}
