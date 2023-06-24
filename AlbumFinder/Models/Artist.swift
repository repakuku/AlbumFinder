//
//  Word.swift
//  Networking
//
//  Created by Алексей Турулин on 6/18/23.
//

struct Artist: Decodable {
    let resultCount: Int
    let results: [ResultInfo]
    
    init(artistData: [String: Any]) {
        resultCount = artistData["resultCount"] as? Int ?? 0
        
        let resultsInfoData = artistData["results"] as? [[String: Any]] ?? []
        results = resultsInfoData.map { ResultInfo(resultInfoData: $0) }
    }
    
    init(resultCount: Int, results: [ResultInfo]) {
        self.results = results
        self.resultCount = resultCount
    }
    
    static func getArtist(from value: Any) -> Artist {
        guard let artistData = value as? [String: Any] else { return Artist(resultCount: 0, results: [])}
        return Artist(artistData: artistData)
    }
}

struct ResultInfo: Decodable {
    let collectionName: String
    let artworkUrl100: String
    let collectionPrice: Double
    let trackCount: Int
    let primaryGenreName: String
    
    init(resultInfoData: [String: Any]) {
        collectionName = resultInfoData["collectionName"] as? String ?? ""
        artworkUrl100 = resultInfoData["artworkUrl100"] as? String ?? ""
        collectionPrice = resultInfoData["collectionPrice"] as? Double ?? 0
        trackCount = resultInfoData["trackCount"] as? Int ?? 0
        primaryGenreName = resultInfoData["primaryGenreName"] as? String ?? ""
    }
}
