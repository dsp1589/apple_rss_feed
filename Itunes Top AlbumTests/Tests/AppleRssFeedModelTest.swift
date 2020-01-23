//
//  AppleRssFeedModelTest.swift
//  Itunes Top AlbumTests
//
//  Created by Dhanasekarapandian Srinivasan on 1/22/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Itunes_Top_Album

class AppleRssFeedModelTest: XCTestCase {
    
    let fileName = "AppleRssFeed"
    let fileType = "json"
    var model : AppleRssFeedResponse?
    override func setUp() {
        let testBundle = Bundle(for: type(of: self))

        guard let url = testBundle.url(forResource: fileName, withExtension: fileType) else {
            XCTFail("\(fileName).\(fileType) is not found")
            return
        }

        guard let json = try? Data(contentsOf: url) else{
            XCTFail("\(fileName).\(fileType) file corrupted")
            return
        }
        let jsonDecode = JSONDecoder.init()
        guard let modelResponse = try? jsonDecode.decode(AppleRssFeedResponse.self, from: json) else {
            XCTFail("Json parsing to model failed")
            return
        }
        model = modelResponse
    }

    override func tearDown() {
        model = nil
    }

    func testModel() {
        XCTAssertNotNil(model)
    }

}
