//
//  AppleRssFeedServiceTest.swift
//  Itunes Top AlbumTests
//
//  Created by Dhanasekarapandian Srinivasan on 3/28/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Itunes_Top_Album

class AppleRSSFeedServiceTest: XCTestCase {

    var service: AppleRssFeedService?
    
    func testFetchTopAlbumsError(){
        let error = ServiceError.noInternet
        let mockSession = MockURLSession(data: nil, urlResponse: nil, error: error)
        service  = AppleRssFeedService.init(service: .topAlbums, urlSession: mockSession)
        let expectation = self.expectation(description: "fetching")
        service?.fetchTopAlbums { (response, error) in
                XCTAssert(error == ServiceError.noInternet)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 120 * 1000) { (error) in
            if let _ = error {
                XCTFail("Fetch timed out")
            }
        }
    }
    
    func testFetchTopAlbumsSuccess(){
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "AppleRssFeed", withExtension: "json") else {
            XCTFail("AppleRssFeed.json is not found")
            return 
        }

        guard let json = try? Data(contentsOf: url) else{
            XCTFail("AppleRssFeed.json file corrupted")
            return
        }
        let mockSession = MockURLSession(data: json, urlResponse: nil, error: nil)
        service  = AppleRssFeedService.init(service: .topAlbums, urlSession: mockSession)
        let expectation = self.expectation(description: "fetching")
        service?.fetchTopAlbums { (response, error) in
            XCTAssert(response != nil)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 120 * 1000) { (error) in
            if let _ = error {
                XCTFail("Fetch timed out")
            }
        }
    }
}
