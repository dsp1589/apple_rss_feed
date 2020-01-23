//
//  ImageServiceTest.swift
//  Itunes Top AlbumTests
//
//  Created by Dhanasekarapandian Srinivasan on 1/23/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Itunes_Top_Album

class ImageServiceTest: XCTestCase {
    
    let fileName = "200x200"
    let fileType = "jpg"
    
    let imageService_invalidURL = ImageService.init(endpoint: "https://mockurl_s")
    

    func testImageServiceInvalidURL() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = self.expectation(description: "Downloading")
        imageService_invalidURL.fetchImage { (image) in
            XCTAssertTrue(image == UIImage.init(named: "music_placeholder"), "Default place holder image not returned")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 120*1000) { (error) in
            guard error == nil else {
                XCTFail("Timed out to download the image")
                return
            }
            
        }
    }
    
    func testImageService_validImage() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: fileName, withExtension: fileType) else {
            XCTFail("\(fileName).\(fileType) is not found")
            return
        }
        let imageService_validImage = ImageService.init(endpoint: url.absoluteString)
        let expectation = self.expectation(description: "Downloading Image")
        imageService_validImage.fetchImage { (image) in
            XCTAssertTrue(image != UIImage.init(named: "music_placeholder"), "Default place holder image returned")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 120) { (error) in
            guard error == nil else {
                XCTFail("Timed out to download the image")
                return
            }
        }
    }

}
