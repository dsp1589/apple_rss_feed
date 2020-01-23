//
//  AlbumTableViewCells.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/22/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit



protocol ImageFetchDelegate : AnyObject {
    func imageFetch(from url : String, completionHandler : @escaping (UIImage) -> Void)
}

class AlbumCell : UITableViewCell{
    
    weak var delegate : ImageFetchDelegate?
    
    private let albumImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize.zero))
        imageView.image = ImageService.defaultPlaceHolderImage
        imageView.createRoundedImageView(with: 8.0, borderColor: UIColor.lightGray.cgColor, borderWidth: 1.0, contentMode: .scaleAspectFit)
        return imageView
    }()
    
    private let artistNameLabel : UILabel = {
        let artistNameLabel = UILabel(frame: CGRect(origin: .zero, size: .zero))
        artistNameLabel.font = UIFont.systemFont(ofSize: 16.0)
        return artistNameLabel
    }()
    
    private let albumTitleLabel : UILabel = {
        let albumTitleLabel = UILabel(frame: CGRect(origin: .zero, size: .zero))
        albumTitleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        return albumTitleLabel
    }()
    
    var album : Album?{
        didSet{
            albumTitleLabel.text = self.album?.name
            artistNameLabel.text = self.album?.artistName
            if let urlString = self.album?.artworkUrl100{
                delegate?.imageFetch(from : urlString, completionHandler: { (image) in
                    DispatchQueue.main.async {
                        self.albumImageView.image = image
                    }
                })
            }
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(albumImageView)
        contentView.addSubview(albumTitleLabel)
        contentView.addSubview(artistNameLabel)
        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setConstraints()
    }
    
    private func setConstraints(){
        contentView.addConstraint(NSLayoutConstraint.init(item: albumImageView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 20.0))
        albumImageView.addConstraints([NSLayoutConstraint.init(item: albumImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0),NSLayoutConstraint.init(item: albumImageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)])
        contentView.addConstraint(NSLayoutConstraint.init(item: albumImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 20.0))
        contentView.addConstraint(NSLayoutConstraint.init(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: albumImageView, attribute: .bottom, multiplier: 1.0, constant: 20.0))
        contentView.addConstraint(NSLayoutConstraint.init(item: albumTitleLabel, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: albumImageView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 20.0))
        contentView.addConstraint(NSLayoutConstraint.init(item: artistNameLabel, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: albumImageView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 20.0))
        contentView.addConstraint(NSLayoutConstraint.init(item: contentView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: albumTitleLabel, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 20.0))
        contentView.addConstraint(NSLayoutConstraint.init(item: contentView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: artistNameLabel, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 20.0))
        contentView.addConstraint(NSLayoutConstraint.init(item: albumTitleLabel, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: albumImageView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0.0))
        albumTitleLabel.addConstraint(NSLayoutConstraint.init(item: albumTitleLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 32.0))
        artistNameLabel.addConstraint(NSLayoutConstraint.init(item: artistNameLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 24.0))
        contentView.addConstraint(NSLayoutConstraint.init(item: artistNameLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: albumImageView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0.0))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
