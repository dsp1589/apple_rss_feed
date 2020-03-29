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

    init(service : Endpoint, urlSession: URLSession)
}


class NetWorkService : Service {

    var serviceEndpoint: Endpoint
    var urlSession: URLSession
    required init(service : Endpoint, urlSession: URLSession = URLSession.shared) {
        self.serviceEndpoint = service
        self.urlSession = urlSession
    }
}
    
class AppleRssFeedService : NetWorkService {
    func fetchTopAlbums(completionHandler : @escaping ( AppleRssFeedResponse?, ServiceError?) -> Void) {
        guard let url = self.serviceEndpoint.url() else {
            completionHandler(nil,ServiceError.invalidUrl)
            return
        }
//        Swift.Result
        //Test with dependency Injection
        ServiceRequest.init(request: URLRequest(url: url), urlSession: self.urlSession).execute { (data, urlResponse, error) in
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

