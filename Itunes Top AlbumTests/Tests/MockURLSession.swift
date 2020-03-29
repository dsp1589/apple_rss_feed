//
//  MockURLSession.swift
//  Itunes Top AlbumTests
//
//  Created by Dhanasekarapandian Srinivasan on 3/28/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    
    let mockTask: MockTask
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, urlResponse: urlResponse, error: error)
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.mockTask.completionHandler = completionHandler
        return mockTask
    }
}

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let customError: Error?
    override var error: Error? { return self.customError }
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.customError = error
    }
    override func resume() {
        DispatchQueue.main.async { [weak self] in
            self?.completionHandler?(self?.data, self?.urlResponse, self?.error)
        }
    }
}
