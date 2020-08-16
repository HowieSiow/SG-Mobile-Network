//
//  SG_Mobile_NetworkTests.swift
//  SG Mobile NetworkTests
//
//  Created by Howie Siow on 13/8/20.
//  Copyright © 2020 Chang. All rights reserved.
//

import XCTest
@testable import SG_Mobile_Network

class SG_Mobile_NetworkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testImageClick()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageClick() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var vc = MainPageViewController()
        vc.getData()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
