//
//  ServiceRequest.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/22/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation



class ServiceRequest {
    
    let request : URLRequest
    let urlSession: URLSession
    init(request : URLRequest, urlSession: URLSession = URLSession.shared) {
        self.request = request
        self.urlSession = urlSession
    }
    
    func execute(completionHandler :  @escaping (Data?, URLResponse?, Error?) -> Void) -> Void {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            self.urlSession.dataTask(with: self.request, completionHandler: completionHandler).resume()
        }
    }
    deinit {
        print("destroyed")
    }
}
