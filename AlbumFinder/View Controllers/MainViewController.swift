//
//  ViewController.swift
//  Networking
//
//  Created by Алексей Турулин on 6/17/23.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet var artistTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistTF.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let albumListVC = segue.destination as? AlbumListViewController else { return }
        albumListVC.artistName = artistTF.text ?? ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func searchAlbumButtonPressed() {
        artistTF.resignFirstResponder()
    }
    
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSegue(withIdentifier: "showAlbums", sender: nil)
        return true
    }
}
