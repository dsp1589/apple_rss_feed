//
//  TopAlbumsTableViewControllerTest.swift
//  Itunes Top AlbumTests
//
//  Created by Dhanasekarapandian Srinivasan on 1/23/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Itunes_Top_Album

class TopAlbumsTableViewControllerTest: XCTestCase {
    
    let fileName = "AlbumData"
       let fileType = "json"
    
    var topAlbumsViewController = TopAlbumsTableViewController.init(style: .grouped)
    
    override func setUp() {
        topAlbumsViewController.loadViewIfNeeded()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewControllerTitle(){
        XCTAssertEqual(topAlbumsViewController.title, NSLocalizedString("Top Albums", comment: "album title \(String(describing: topAlbumsViewController.title))"))
    }
    
    func testTableViewConfigure(){
        
        let tableView = topAlbumsViewController.tableView
        XCTAssertTrue(tableView?.separatorInset == UIEdgeInsets(top: 0, left: 140, bottom: 0, right: 0), "Edge inset for table view cell separator found changed")
        
        let cellRegistered = tableView?.dequeueReusableCell(withIdentifier: "TopAlbumsTableViewCell") as? AlbumCell
        XCTAssertNotNil(cellRegistered)
    }
    
    func testRefreshControlConfig(){
        let refreshControl = topAlbumsViewController.refreshControl
        XCTAssertNotNil(refreshControl)
        XCTAssertTrue(refreshControl?.tintColor == UIColor.systemPink, "Tint color is not system pink")
        XCTAssertTrue(refreshControl?.actions(forTarget: topAlbumsViewController, forControlEvent: UIControl.Event.valueChanged)?.first == "fetchTopAlbums", "Refresh control method action incorrect")
    }
    
    func testAlbumCell(){
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
                
       guard let modelResponse = try? jsonDecode.decode(Album.self, from: json) else {
           XCTFail("Json parsing to model failed")
           return
       }
        let cell = AlbumCell.init(style: .default, reuseIdentifier: "someidentifier")
        cell.album = modelResponse
        
        XCTAssertTrue(cell.albumTitleLabel.text == modelResponse.name, "Value set in uilabel for albumtitle is not correct")
        XCTAssertTrue(cell.artistNameLabel.text == modelResponse.artistName, "Value set in uilabel for albumtitle is not correct")
    }
    
    

}
