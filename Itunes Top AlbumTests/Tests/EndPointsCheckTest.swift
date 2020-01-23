//
//  EndPointsCheckTest.swift
//  Itunes Top AlbumTests
//
//  Created by Dhanasekarapandian Srinivasan on 1/22/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Itunes_Top_Album

class EndPointsCheckTest: XCTestCase {

    //Validate all the end points added to Endpoints enum are valid URL
    func testAllEndpoints() {
        for endpoint in Endpoint.allCases {
            let v = endpoint.url()
            XCTAssertNotNil(v, endpoint.rawValue)
       }
    }

}
