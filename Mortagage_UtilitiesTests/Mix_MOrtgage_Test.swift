//
//  Mix_MOrtgage_Test.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 23/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest
@testable import Mortagage_Utilities


class Mix_MOrtgage_Test: XCTestCase {
    
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
    
    func test_prestamoHipotecario() {
        
        
       let clpo = closeAllPositions()
        
        let addi = addToPortfolio([])
        
        let mona : (product ) -> State<portFolio,rHipotSample> = { pr in addToPortfolio([pr]) }
        
        let otEx = clpo >>- addi
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
