//
//  ViewController.swift
//  Networking
//
//  Created by Алексей Турулин on 6/17/23.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet var artistTF: UITextField!
    
    private let artistName = DataStore.shared.artist
    private var artist: Artist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArtist()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func fetchArtist() {
        let url = getURL(for: artistName)
        
        URLSession.shared.dataTask(with: url) { [unowned self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.artist = try decoder.decode(Artist.self, from: data)
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


