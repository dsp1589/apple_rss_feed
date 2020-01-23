//
//  AlbumDetailsHostingViewController.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/21/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit


class AlbumDetailsHostingViewController: UIViewController {
        
    var album : Album?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    convenience init(album : Album) {
        self.init(nibName:nil, bundle:nil)
        self.album = album
        addAlBumDetailsController(with: self.album)
    }
    
    func addAlBumDetailsController(with album : Album?){
        let albumDetailsController = AlbumDetailsViewController(album: album)
        addChild(albumDetailsController)
    }
    
    
    private let viewInItunesButton : UIButton = {
       let viewInItunesButton = UIButton(type: .custom)
       viewInItunesButton.setTitle(NSLocalizedString("View in Apple Music", comment: "open album in apple music"), for: .normal)
        viewInItunesButton.setTitleColor(UIColor.systemPink, for: .normal)
        viewInItunesButton.layer.cornerRadius = 8.0
        viewInItunesButton.layer.masksToBounds = true
        viewInItunesButton.layer.borderWidth = 1
        viewInItunesButton.layer.borderColor = UIColor.systemPink.cgColor
        viewInItunesButton.addTarget(self, action: #selector(openInItunes), for: .touchUpInside)
        return viewInItunesButton
    }()
    
    private let containerView : UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: .zero))
        return view
    }()
    
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(containerView)
        self.view.addSubview(viewInItunesButton)
        if #available(iOS 13, *), traitCollection.userInterfaceStyle == .dark {
            self.view.backgroundColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.white
        }
        viewInItunesButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        pinButtonToBottom()
        setContainerView()
        guard let albumDetailsViewController = children.first as? AlbumDetailsViewController else
        {
            return
        }
        containerView.addSubview(albumDetailsViewController.view)
        albumDetailsViewController.view.frame = containerView.frame
        setUpAlbumDetailsView(view: albumDetailsViewController.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if #available(iOS 13, *), newCollection.userInterfaceStyle == .dark {
            self.view.backgroundColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.white
        }
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    private func pinButtonToBottom(){
//        self.view.addConstraint(NSLayoutConstraint(item: self.view as Any, attribute: .bottom, relatedBy: .equal, toItem: viewInItunesButton, attribute: .bottom, multiplier: 1.0, constant: 20.0))
        viewInItunesButton.addConstraint(NSLayoutConstraint(item: viewInItunesButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0))
        
        let safeArea = view.safeAreaLayoutGuide
        safeArea.rightAnchor.constraint(equalTo: viewInItunesButton.rightAnchor, constant: 20.0).isActive = true
        viewInItunesButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20.0).isActive = true
        safeArea.bottomAnchor.constraint(equalTo: viewInItunesButton.bottomAnchor, constant: 20.0).isActive = true
    }
    
    private func setContainerView(){
        self.view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view as Any, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: viewInItunesButton, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 20.0))
    }
    
    private func setUpAlbumDetailsView(view : UIView){
        containerView.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
    }
    
    @objc private func openInItunes(){
        guard let urlString = album?.url, let urlToOpen = URL.init(string: urlString) else { return }
        if UIApplication.shared.canOpenURL(urlToOpen) {
            UIApplication.shared.open(urlToOpen, options: [:]) { (complted) in
                debugPrint(complted)
            }
        }
    }
    
}
