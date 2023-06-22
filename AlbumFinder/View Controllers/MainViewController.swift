//
//  ViewController.swift
//  Networking
//
//  Created by Алексей Турулин on 6/17/23.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet var artistTF: UITextField!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let albumListVC = segue.destination as? AlbumListViewController else { return }
        
        let url = networkManager.getURL(for: artistTF.text ?? "")

        networkManager.fetchAlbums(from: url) { result in
            switch result {
            case .success(let artist):
                print(artist)
                albumListVC.artist = artist
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    

}


