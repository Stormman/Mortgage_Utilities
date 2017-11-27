//
//  ArrayExtension_test.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 26/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest

@testable import Mortagage_Utilities


class ArrayExtension_test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_scans () {
        
        let array = [2,3,6,8,9,11,23,45,67,89]
        
        
        let tranf : (String ,Int) -> String  = {$0 + String($1)      }
        
        
        
        
        
        let sc = array.scanl("eee", tranf)
        
        
       
        
        
        
    }
    
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
