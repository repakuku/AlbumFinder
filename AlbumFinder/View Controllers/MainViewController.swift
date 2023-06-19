//
//  ViewController.swift
//  Networking
//
//  Created by Алексей Турулин on 6/17/23.
//

import UIKit

final class MainViewController: UIViewController {

    private let artist = DataStore.shared.artist
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArtist()
    }
    
    private func fetchArtist() {
        let url = getURL(for: artist)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let artist = try decoder.decode(Artist.self, from: data)
            
                print(artist)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    private func getURL(for artist: String) -> URL {
        let formattedArtist = artist.lowercased().replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://itunes.apple.com/search?term=\(formattedArtist)&entity=album&limit=50")!
        
        return url
    }
}


