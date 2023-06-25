//
//  NetworkManager.swift
//  AlbumFinder
//
//  Created by Алексей Турулин on 6/22/23.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getURL(for artist: String) -> URL {
        let formattedArtist = artist.lowercased().replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://itunes.apple.com/search?term=\(formattedArtist)&entity=album&limit=50")!
        return url
    }
    
    func fetchAlbums(from url: URL, completion: @escaping(Result<Artist, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let artist = Artist.getArtist(from: value)
                    completion(.success(artist))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
