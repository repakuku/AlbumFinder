//
//  AlbumCell.swift
//  AlbumFinder
//
//  Created by Алексей Турулин on 6/22/23.
//

import UIKit

final class AlbumCell: UITableViewCell {

    @IBOutlet var albumImageView: UIImageView!
    
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet var tracksCountLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with album: ResultInfo) {
        albumNameLabel.text = album.collectionName
        tracksCountLabel.text = "Number of tracks: \(String(album.trackCount))"
        genreLabel.text = "Genre: \(album.primaryGenreName)"
        
        networkManager.fetchData(from: album.artworkUrl100) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.albumImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
