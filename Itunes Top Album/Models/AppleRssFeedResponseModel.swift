//
//  AppleRssFeedResponseModel.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/20/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation

// MARK: - AppleRssFeedResponse
struct AppleRssFeedResponse: Codable {
    let feed: Feed
}

// MARK: - Feeds
struct Feed: Codable {
    let title: String?
    let id: String?
    let author: Author?
    let links: [Link]?
    let copyright, country: String?
    let icon: String?
    let updated: String?
    let results: [Result]?
}

// MARK: - Author
struct Author: Codable {
    let name: String?
    let uri: String?
}

// MARK: - Link
struct Link: Codable {
    let linkSelf: String?
    let alternate: String?

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
        case alternate
    }
}

// MARK: - Result
struct Result: Codable {
    let artistName, id, name : String?
    let collectionName: String?
    let kind: String?
    let copyright, artistID: String?
    let artistURL: String?
    let artworkUrl100: String?
    let genres: [Genre]?
    let url: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, collectionName, kind, copyright
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url, releaseDate
    }
}
// MARK: - Genre
struct Genre: Codable {
    let genreID: String?
    let name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}


typealias Album = Result
