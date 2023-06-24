//
//  AlbumListViewController.swift
//  AlbumFinder
//
//  Created by Алексей Турулин on 6/22/23.
//

import UIKit
import Alamofire

final class AlbumListViewController: UITableViewController {
    
    var artistName: String!
    
    private let networkManager = NetworkManager.shared
    private var artist: Artist = Artist(resultCount: 0, results: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        title = "Results for \"\(artistName ?? "")\""
        
        fetchAlbums()
    }
    
    private func fetchAlbums() {
        let url = networkManager.getURL(for: artistName)
        
        networkManager.fetchAlbums(from: url) { [weak self] result in
            switch result {
            case .success(let artist):
                self?.artist = artist

                if artist.resultCount == 0 {
                    self?.title = "No results for \"\(self?.artistName ?? "")\""
                }

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
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
