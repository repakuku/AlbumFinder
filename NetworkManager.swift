//
//  NetworkManager.swift
//  AlbumFinder
//
//  Created by Алексей Турулин on 6/22/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getURL(for artist: String) -> URL {
        let formattedArtist = artist.lowercased().replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://itunes.apple.com/search?term=\(formattedArtist)&entity=album&limit=50")!
        return url
    }
    
    func fetchAlbums(from url: URL, completion: @escaping(Swift.Result<Artist, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let artist = try decoder.decode(Artist.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(artist))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Swift.Result<Data, NetworkError>) -> Void) {
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
