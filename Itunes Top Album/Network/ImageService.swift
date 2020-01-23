//
//  ImageService.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/20/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit


class ImageService {
    
    var serviceEndpoint : String
    
    init(endpoint : String) {
        self.serviceEndpoint = endpoint
    }
    
    static let defaultPlaceHolderImage : UIImage = {
        guard let placeHolderImage = UIImage(named: "music_placeholder") else {
            return UIImage()
        }
        return placeHolderImage
    }()
        
    func fetchImage(completionHandler : @escaping (UIImage) -> Void) {
        
        guard let imageURL = URL(string: self.serviceEndpoint) else{
            completionHandler(ImageService.defaultPlaceHolderImage)
            return
        }
        let request = URLRequest(url: imageURL)
        let cache = URLCache.shared
        guard let response = cache.cachedResponse(for: request), let image = UIImage(data: response.data) else {
                ServiceRequest.init(request: request).execute { (data, response, error) in
                    guard error == nil else {
                        completionHandler(ImageService.defaultPlaceHolderImage)
                        return
                    }
                    guard let data = data, let receivedImage = UIImage(data: data), let response = response else {
                        completionHandler(ImageService.defaultPlaceHolderImage)
                        return
                    }
                    cache.storeCachedResponse(CachedURLResponse.init(response: response, data: data), for: request)
                    completionHandler(receivedImage)
                }
            return
        }
        completionHandler(image)
    }
}
