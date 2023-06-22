//
//  AlbumListViewController.swift
//  AlbumFinder
//
//  Created by Алексей Турулин on 6/22/23.
//

import UIKit

final class AlbumListViewController: UITableViewController {
    
    var artist: Artist!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "album", for: indexPath)

        return cell
    }

}
