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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let albumListVC = segue.destination as? AlbumListViewController else { return }
        let url = networkManager.getURL(for: artistTF.text ?? "")
        albumListVC.url = url
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}


