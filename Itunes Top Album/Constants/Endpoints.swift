//
//  Endpoints.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/20/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit


protocol URLConvertible {
    func url() -> URL?
}

public enum Endpoint : String, URLConvertible, CaseIterable {
    
    case albums = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/25/non-explicit.json"
    case heavyMetal = "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/heavy-metal/25/non-explicit.json"
    case topAlbums = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/25/non-explicit.json"
    
    func url() -> URL? {
        guard let url = URL(string: self.rawValue) else{
            return nil
        }
        return url
    }
    
}

