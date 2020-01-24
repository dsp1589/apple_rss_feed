//
//  AlbumDetailsViewController.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/23/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailsViewController: UIViewController {
    
    var album : Album?
    
    private let viewInItunesButton : UIButton = {
       let viewInItunesButton = UIButton(type: .custom)
       viewInItunesButton.setTitle(NSLocalizedString("View in Apple Music", comment: "open album in apple music"), for: .normal)
        viewInItunesButton.setTitleColor(UIColor.systemPink, for: .normal)
        viewInItunesButton.layer.cornerRadius = 8.0
        viewInItunesButton.layer.masksToBounds = true
        viewInItunesButton.layer.borderWidth = 1
        viewInItunesButton.layer.borderColor = UIColor.systemPink.cgColor
        viewInItunesButton.translatesAutoresizingMaskIntoConstraints = false
        viewInItunesButton.addTarget(self, action: #selector(openInItunes), for: .touchUpInside)
        return viewInItunesButton
    }()
    
    convenience init(album : Album?) {
        self.init(nibName : nil, bundle : nil)
        self.album = album
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(viewInItunesButton)
        let stackView = setUpLeftSideStackViews(inside: self.view)
        let albumDetailsStackView = setUpRightStackViewWithAlbumDetails(in: self.view)
        setupConstraints(forRight: albumDetailsStackView, withLeft: stackView, in: self.view)

        if #available(iOS 13, *), traitCollection.userInterfaceStyle == .dark {
            self.view.backgroundColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.white
        }
        pinButtonToBottom()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.systemPink
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = true
    }

    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
           if #available(iOS 13, *), newCollection.userInterfaceStyle == .dark {
               self.view.backgroundColor = UIColor.black
           }else{
               self.view.backgroundColor = UIColor.white
           }
           super.willTransition(to: newCollection, with: coordinator)
       }
    
    
    private func setUpLeftSideStackViews(inside view : UIView) -> UIStackView{
        let albumImageView = UIImageView(frame: CGRect.init(origin: .zero, size: CGSize.init(width: 150, height: 150)))
        albumImageView.image = ImageService.defaultPlaceHolderImage
        albumImageView.createRoundedImageView(with: 8.0, borderColor: UIColor.lightGray.cgColor, borderWidth: 1.0, contentMode: .scaleAspectFit)
        if let albumImage = self.album?.artworkUrl100 {
            ImageService.init(endpoint: albumImage).fetchImage { (image) in
                DispatchQueue.main.async {
                    albumImageView.image = image
                }
            }
        }
        let copyRightLabel = UILabel.init(frame: CGRect.init(origin: .zero, size: CGSize.zero))
        copyRightLabel.text = self.album?.copyright
        copyRightLabel.numberOfLines = 0
        copyRightLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        copyRightLabel.lineBreakMode = .byWordWrapping
        copyRightLabel.tag = 1
        copyRightLabel.sizeToFit()
        
        let leftAlbumImageCopyRightLabelVStackView = UIStackView.init()
        leftAlbumImageCopyRightLabelVStackView.axis = .vertical
        leftAlbumImageCopyRightLabelVStackView.alignment = .fill
        leftAlbumImageCopyRightLabelVStackView.distribution = .fillProportionally
        leftAlbumImageCopyRightLabelVStackView.addArrangedSubview(albumImageView)
        leftAlbumImageCopyRightLabelVStackView.addArrangedSubview(copyRightLabel)
        
        
        view.addSubview(leftAlbumImageCopyRightLabelVStackView)
        
        leftAlbumImageCopyRightLabelVStackView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        copyRightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        setUpConstraints(forLeft: leftAlbumImageCopyRightLabelVStackView, and: albumImageView, and: copyRightLabel, in: view)
        
        return leftAlbumImageCopyRightLabelVStackView
    }
    
    func setUpConstraints(forLeft stackView : UIStackView, and albumImageView : UIImageView, and copyRightLabel : UILabel ,in view : UIView){
        let safeArea = view.safeAreaLayoutGuide

//        view.addConstraints([NSLayoutConstraint.init(item: stackView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20)])
        
        stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20.0).isActive = true

        stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20.0).isActive = true
        stackView.addConstraint(NSLayoutConstraint.init(item: stackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
        albumImageView.addConstraint(NSLayoutConstraint.init(item: albumImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
        albumImageView.addConstraint(NSLayoutConstraint.init(item: albumImageView, attribute: .height, relatedBy: .equal, toItem: albumImageView, attribute: .width, multiplier: 1.0, constant: 0.0))
        stackView.addConstraints([NSLayoutConstraint.init(item: copyRightLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0),NSLayoutConstraint.init(item: copyRightLabel, attribute: .top, relatedBy: .equal, toItem: albumImageView, attribute: .bottom, multiplier: 1.0, constant: 0.0)])
    }
    
    func setUpRightStackViewWithAlbumDetails(in view : UIView) -> UIStackView{
        let albumDetailsStackView = UIStackView.init()
        albumDetailsStackView.axis = .vertical
        albumDetailsStackView.spacing = UIStackView.spacingUseSystem
        
        let albumTitleLabel = UILabel.init(frame: CGRect.init(origin: .zero, size: .zero))
        albumTitleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        albumTitleLabel.numberOfLines = 3
        albumTitleLabel.tag = 2
        albumTitleLabel.text = self.album?.name
        
        let artistTitleLabel = UILabel.init(frame: CGRect.init(origin: .zero, size: .zero))
        artistTitleLabel.font = UIFont.systemFont(ofSize: 18.0)
        artistTitleLabel.textColor = UIColor.systemPink
        artistTitleLabel.tag = 3
        artistTitleLabel.text = self.album?.artistName
        
        let genreTitleLabel = UILabel.init(frame: CGRect.init(origin: .zero, size: .zero))
        genreTitleLabel.font = UIFont.systemFont(ofSize: 13.0)
        genreTitleLabel.tag = 4
        genreTitleLabel.text = self.album?.genres?.first?.name
        
        
        let releaseDateTitleLabel = UILabel.init(frame: CGRect.init(origin: .zero, size: .zero))
        releaseDateTitleLabel.font = UIFont.systemFont(ofSize: 13.0)
        releaseDateTitleLabel.textColor = UIColor.systemPink
        releaseDateTitleLabel.tag = 5
        releaseDateTitleLabel.adjustsFontSizeToFitWidth = true
        releaseDateTitleLabel.text = self.album?.releaseDate?.formattedReleaseDateStringFromYYYYMMDD
        
        albumDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        artistTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        genreTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        albumDetailsStackView.addArrangedSubview(albumTitleLabel)
        albumDetailsStackView.addArrangedSubview(artistTitleLabel)
        albumDetailsStackView.addArrangedSubview(genreTitleLabel)
        albumDetailsStackView.addArrangedSubview(releaseDateTitleLabel)
        view.addSubview(albumDetailsStackView)
        return albumDetailsStackView
    }
    
    func setupConstraints(forRight albumDetailsStackView : UIStackView, withLeft stackView : UIStackView, in view : UIView) {
        view.addConstraints([NSLayoutConstraint.init(item: albumDetailsStackView, attribute: .left, relatedBy: .equal, toItem: stackView, attribute: .right, multiplier: 1.0, constant: 8.0),NSLayoutConstraint.init(item: albumDetailsStackView, attribute: .top, relatedBy: .equal, toItem: stackView, attribute: .top, multiplier: 1.0, constant: 0.0)])
        let safeArea = view.safeAreaLayoutGuide
        safeArea.rightAnchor.constraint(equalTo: albumDetailsStackView.rightAnchor, constant: 20.0).isActive = true
    }
    
    private func pinButtonToBottom(){
            viewInItunesButton.addConstraint(NSLayoutConstraint(item: viewInItunesButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0))
            
            let safeArea = view.safeAreaLayoutGuide
            safeArea.rightAnchor.constraint(equalTo: viewInItunesButton.rightAnchor, constant: 20.0).isActive = true
            viewInItunesButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20.0).isActive = true
            safeArea.bottomAnchor.constraint(equalTo: viewInItunesButton.bottomAnchor, constant: 20.0).isActive = true
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
