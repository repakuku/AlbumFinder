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
    @IBOutlet var priceLabel: UILabel!
    
    
    private let networkManager = NetworkManager.shared
    
    func configure(with album: Result) {
        albumNameLabel.text = album.collectionName
        tracksCountLabel.text = "Number of tracks: \(String(album.trackCount))"
        genreLabel.text = "Genre: \(album.primaryGenreName)"
        priceLabel.text = "$\(String(album.collectionPrice))"
        
        guard let url = URL(string: album.artworkUrl100) else { return }
        networkManager.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.albumImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
