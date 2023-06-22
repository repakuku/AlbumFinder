//
//  AlbumListViewController.swift
//  AlbumFinder
//
//  Created by Алексей Турулин on 6/22/23.
//

import UIKit

class AlbumListViewController: UITableViewController {
    
    var url: URL!
    
    private let networkManager = NetworkManager.shared
    private var artist: Artist = Artist(resultCount: 0, results: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
        networkManager.fetchAlbums(from: url) { [weak self] result in
            switch result {
            case .success(let artist):
                self?.artist = artist
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artist.resultCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        guard let cell = cell as? AlbumCell else { return UITableViewCell()}
        
        let album = artist.results[indexPath.row]
        cell.configure(with: album)
        

        return cell
    }
}
