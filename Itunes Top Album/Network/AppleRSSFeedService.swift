//
//  AppleRSSFeedService.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/20/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation


enum ServiceError : Error{
    
    case invalidUrl
    case invalidReponse
    case unableToParse
    case noInternet
}

protocol Service{
    var serviceEndpoint : Endpoint {get}

    init(service : Endpoint)
}


class NetWorkService : Service {

    var serviceEndpoint: Endpoint
    
    required init(service : Endpoint) {
        self.serviceEndpoint = service
    }
}
    
class AppleRssFeedService : NetWorkService {
    func fetchTopAlbums(completionHandler : @escaping ( AppleRssFeedResponse?, ServiceError?) -> Void) {
        guard let url = self.serviceEndpoint.url() else {
            completionHandler(nil,ServiceError.invalidUrl)
            return
        }
        ServiceRequest.init(request: URLRequest(url: url)).execute { (data, urlResponse, error) in
            guard error == nil, let data = data else {
                if let errCode = (error as NSError?)?.code, errCode == -1009 {
                    completionHandler(nil, ServiceError.noInternet)
                }else{
                    completionHandler(nil, ServiceError.invalidReponse)
                }
                return
            }
            guard let appleRssFeedResponse = try? JSONDecoder().decode(AppleRssFeedResponse.self, from: data) else {
                    completionHandler(nil,ServiceError.unableToParse)
                    return
            }
            completionHandler(appleRssFeedResponse,nil)
        }
    }
}

