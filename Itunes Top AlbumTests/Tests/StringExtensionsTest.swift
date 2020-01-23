//
//  StringExtensionsTest.swift
//  Itunes Top AlbumTests
//
//  Created by Dhanasekarapandian Srinivasan on 1/22/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Itunes_Top_Album

class StringExtensionsTest: XCTestCase {
    
    var validExpectedFutureDate : String = "2050-12-30"
    var validExpectedPastDate : String = "2000-12-30"
    var invalidDateFormat_DD_MM_YYYY : String = "30-12-2000"
    var invalidDateFormat_MM_DD_YYYY : String = "12-30-2000"
    var invalidDate : String = "31-31-2000"
    
    func testStringExtension_formattedReleaseDateString() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(validExpectedFutureDate.formattedReleaseDateStringFromYYYYMMDD == "Expected on \(validExpectedFutureDate)")
        XCTAssertTrue(validExpectedPastDate.formattedReleaseDateStringFromYYYYMMDD == "Released on \( validExpectedPastDate)")
        XCTAssertTrue(invalidDateFormat_DD_MM_YYYY.formattedReleaseDateStringFromYYYYMMDD == "", "Unexpected formatted date string")
        XCTAssertTrue(invalidDateFormat_MM_DD_YYYY.formattedReleaseDateStringFromYYYYMMDD == "", "Unexpected formatted date string")
        XCTAssertTrue(invalidDate.formattedReleaseDateStringFromYYYYMMDD == "", "invalid date formatted date string")
    }

}
