//
//  AlbumCell.swift
//  AlbumFinder
//
//  Created by Алексей Турулин on 6/22/23.
//

import UIKit

final class AlbumCell: UITableViewCell {

    @IBOutlet var albumImageView: UIImageView!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with album: Result) {
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
