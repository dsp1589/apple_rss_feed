//
//  AlbumDetailsViewControllerTest.swift
//  Itunes Top AlbumTests
//
//  Created by Dhanasekarapandian Srinivasan on 1/23/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Itunes_Top_Album

class AlbumDetailsViewControllerTest: XCTestCase {
    
    let fileName = "AlbumData"
    let fileType = "json"
    
    let albumDetailsViewController = AlbumDetailsViewController.init(album: nil)
    var albumModelSample : Album?
    override func setUp() {
//        let testBundle = Bundle(for: type(of: self))
//
//        guard let url = testBundle.url(forResource: fileName, withExtension: fileType) else {
//            XCTFail("\(fileName).\(fileType) is not found")
//            return
//        }
//
//        guard let json = try? Data(contentsOf: url) else{
//            XCTFail("\(fileName).\(fileType) file corrupted")
//            return
//        }
//        let jsonDecode = JSONDecoder.init()
//                 
//        guard let modelResponse = try? jsonDecode.decode(Album.self, from: json) else {
//            XCTFail("Json parsing to model failed")
//            return
//        }
        
        guard let modelResponse = localJsonDataForTesting(from: fileName, of: fileType, model: Album.self) else {
            return
        }
        
        albumDetailsViewController.album = modelResponse
        albumModelSample = modelResponse
        albumDetailsViewController.loadViewIfNeeded()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        albumModelSample = nil
    }

    func testAlbumDetailsViewController() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let copyRightLabel = albumDetailsViewController.view.viewWithTag(1) as? UILabel
        XCTAssertNotNil(copyRightLabel)
        let albumTitleLabel = albumDetailsViewController.view.viewWithTag(2) as? UILabel
        XCTAssertNotNil(albumTitleLabel)
        let artistTitleLabel = albumDetailsViewController.view.viewWithTag(3) as? UILabel
        XCTAssertNotNil(artistTitleLabel)
        let genreLabel =  albumDetailsViewController.view.viewWithTag(4) as? UILabel
        XCTAssertNotNil(genreLabel)
        let releaseDateLabel = albumDetailsViewController.view.viewWithTag(5) as? UILabel
        XCTAssertNotNil(releaseDateLabel)
        
        //Validate info displayed
        
        XCTAssertTrue(copyRightLabel?.text == albumModelSample?.copyright, "Copyright details displayed wrong")
        XCTAssertTrue(albumTitleLabel?.text == albumModelSample?.name, "album title displayed wrong")
        XCTAssertTrue(artistTitleLabel?.text == albumModelSample?.artistName, "artist name title displayed wrong")
        XCTAssertTrue(genreLabel?.text == albumModelSample?.genres?.first?.name, "genre details  displayed wrong")
        if let releaseDate = albumModelSample?.releaseDate{
            XCTAssertTrue(releaseDateLabel?.text == "Expected on \(releaseDate)", "release date displayed wrong")
        }
        
    }

}
