//
//  AppleSeedTestDataParsable.swift
//  Itunes Top AlbumTests
//
//  Created by Dhanasekarapandian Srinivasan on 1/27/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest

protocol AppleSeedTestDataParsable {
    func localJsonDataForTesting<T>( from fileName : String, of fileType : String, model to : T.Type) -> T? where T : Codable
}

extension XCTestCase : AppleSeedTestDataParsable {
    func localJsonDataForTesting<T>(from fileName: String, of fileType: String, model to: T.Type) -> T? where T : Decodable, T : Encodable {
        let testBundle = Bundle(for: type(of: self))
              guard let url = testBundle.url(forResource: fileName, withExtension: fileType) else {
                  XCTFail("\(fileName).\(fileType) is not found")
                  return nil
              }

              guard let json = try? Data(contentsOf: url) else{
                  XCTFail("\(fileName).\(fileType) file corrupted")
                  return nil
              }
        
              let jsonDecode = JSONDecoder.init()
              guard let modelResponse = try? jsonDecode.decode(T.self, from: json) else {
                        XCTFail("Json parsing to model failed")
                        return nil
                    }
              return modelResponse
    }
}
