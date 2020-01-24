//
//  TopAlbumsTableViewController.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/20/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit

class TopAlbumsTableViewController: UITableViewController {
    
    
    private enum UserMessage : String {
        case fetchFailed = "Unable to load Top Albums, Pull to refresh!"
        case noInternet = "The Internet connection appears to be offline."
        case fetching = "Fetching Top Albums!"
        case fetchCompleted = "Fetch Completed"
    }
    
    private let cellIdentifier = "TopAlbumsTableViewCell"
    private let footerLoaderCellIdentifier = "footerLoaderCell"
    private var appleRssFeedResponse : AppleRssFeedResponse?
    
    private var loadingStatus : UserMessage = .fetching {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        self.title = NSLocalizedString("Top Albums", comment: "album title")
        configureTableView()
        configureNavController()
        setupRefreshControl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopAlbums()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = true
        super.viewWillAppear(animated)
        
    }

    @objc private func fetchTopAlbums(){
        AppleRssFeedService(service: .topAlbums).fetchTopAlbums { (appleRssFeedResponse, error) in
            DispatchQueue.main.async {
                if let refreshing = self.refreshControl?.isRefreshing, refreshing {
                    self.refreshControl?.endRefreshing()
                }
            }
            if let serviceError = error{
                self.appleRssFeedResponse = nil
                self.loadingStatus = serviceError == .noInternet ? .noInternet : .fetchFailed
            }else{
                self.appleRssFeedResponse = appleRssFeedResponse
                self.loadingStatus = .fetchCompleted
            }
        }
    }
}

// MARK: UITableViewDataSource
extension TopAlbumsTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appleRssFeedResponse?.feed.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let albumCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlbumCell else {
            let newCell = AlbumCell.init(style: .default, reuseIdentifier: cellIdentifier)
            configureAlbumCell(cell: newCell, forIndexPath: indexPath)
            return newCell
        }
        configureAlbumCell(cell: albumCell, forIndexPath: indexPath)
        return albumCell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return getFooterView(for: self.loadingStatus)
    }
    
    private func configureAlbumCell(cell : AlbumCell, forIndexPath : IndexPath){
        cell.accessoryType = .disclosureIndicator
        cell.delegate = self
        cell.album = appleRssFeedResponse?.feed.results?[forIndexPath.row]
    }
}

// MARK: UITableViewDelegates
extension TopAlbumsTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let album = self.appleRssFeedResponse?.feed.results?[indexPath.row] else{
            return
        }
//        let albumDetailsHostingViewController = AlbumDetailsHostingViewController.init(album: album)
//        navigationController?.pushViewController(albumDetailsHostingViewController, animated: true)
        let albumDetailsController = AlbumDetailsViewController(album: album)
        navigationController?.pushViewController(albumDetailsController, animated: true)
    }
}

// MARK: Controller Specific View setups
extension TopAlbumsTableViewController {
    private func getFooterView(for loadingStatus : UserMessage) -> UIView?{
        let activityIndicator = UIActivityIndicatorView.init(style: .white)
        activityIndicator.color = UIColor.systemPink

        activityIndicator.hidesWhenStopped = true
        let userMessageLabel = UILabel(frame: CGRect(origin: .zero, size: .zero))
        userMessageLabel.text = NSLocalizedString(loadingStatus.rawValue, comment: "")
        let stactView = UIStackView(arrangedSubviews: [activityIndicator,userMessageLabel])
        stactView.axis = .vertical
        stactView.alignment = .center
        switch loadingStatus {
        case .fetching :
            activityIndicator.startAnimating()
            break
        case .fetchFailed, .noInternet :
            activityIndicator.stopAnimating()
            break
        case .fetchCompleted :
            activityIndicator.stopAnimating()
            return nil
        }
        return stactView
    }
    private func configureTableView(){
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 120, bottom: 0, right: 0)
        tableView.register(AlbumCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    private func configureNavController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemPink]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemPink]
    }
    private func setupRefreshControl(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.systemPink
        self.refreshControl?.addTarget(self, action: #selector(fetchTopAlbums), for: .valueChanged)
    }
}


extension TopAlbumsTableViewController : ImageFetchDelegate {
    
    func imageFetch(from url: String, completionHandler: @escaping (UIImage) -> Void) {
        ImageService.init(endpoint: url).fetchImage { (image) in
            completionHandler(image)
        }
    }
    
}
