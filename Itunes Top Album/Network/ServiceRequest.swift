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
    
    init(request : URLRequest) {
        self.request = request
    }
    
    func execute(completionHandler :  @escaping (Data?, URLResponse?, Error?) -> Void) -> Void {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            URLSession.shared.dataTask(with: self.request, completionHandler: completionHandler).resume()
        }
    }
    
}
