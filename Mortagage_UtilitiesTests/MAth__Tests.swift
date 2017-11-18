//
//  MAth__Tests.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 17/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest


@testable import Mortagage_Utilities


class MAth__Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_curves() {
        
        typealias po = mathFunctions__.Point
        
        let ff = mathFunctions__.curve(.line, po(x: 4,y: 8), po(x: 10,y: 20))
        
        
        let p = ff <> 8
        
        XCTAssert(p == 16)
        
        let ffg = 910000
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
