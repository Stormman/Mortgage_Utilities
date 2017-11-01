//
//  functionalTests.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 1/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest

@testable import Mortagage_Utilities

class functionalTests: XCTestCase {
    
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
    
    func testMemoize() {
        
        let funt = memoize{ x in return x*2               }
        
        let fv = funt(2)
        
        let bbp = funt(2)
        
        
        XCTAssert(fv == bbp && fv == 2)
        
        
    }
    
    func testBetweee () {
        
        let funiiceroDiex = betWeen(8, 10)
        
        let kkkd = funiiceroDiex(9)
        
        let fera = funiiceroDiex(20)
        
        
        XCTAssert(kkkd == true)
        XCTAssert(fera == false)
        
        let fg = 90
        
        
        
        
        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
