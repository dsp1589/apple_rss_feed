//
//  GenresTableViewController.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/20/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit


class TopAlbumsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Top Albums"
    }
    
}

