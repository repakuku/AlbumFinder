//
//  Word.swift
//  Networking
//
//  Created by Алексей Турулин on 6/18/23.
//

struct Artist: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let collectionName: String
    let artworkUrl100: String
    let collectionPrice: Double
    let trackCount: Int
    let primaryGenreName: String
}
