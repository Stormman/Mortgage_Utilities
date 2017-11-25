//
//  Mix_test.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 20/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest

@testable import Mortagage_Utilities


class Mix_test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_chagelastelementArray() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    let arr = [23,34,5,6,7,8]
        
        let new = changelastElementOfAArray(arr: arr) <&> {$0 + 10}
        
    
    XCTAssert(new?.last! == 18)
    
    
    
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
