//
//  randomizeTests.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 1/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest
@testable import Mortagage_Utilities

class randomizeTests: XCTestCase {
    
    struct n : metrizable {
        var stepMinim: Double
        
        var bounds: (Double, Double)
        
    }
    
    
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        
        self.measure(){
        
        let v = varAleatoria(descrip: "pepe", step: 0.5, boundss: (0,7), generato: funcToExaple)
        
        let v2 = waysOfIO.proof()
        
        
        let gppp = v2.generateTheWayValues()
        
        
            let fg = 90}
        

    }
    
    func testFuntions() {
        
       
        
        let mn = n(stepMinim: 9, bounds: (-100, 100))
        
        let arr = metrizarArray(mn)
        
        
        
        XCTAssert(arr.count == 66)
        
        
        
        let ggg = 0.1
        
        
        
    }
    
    
    func testStepsto() {
        
        let mn = n(stepMinim: 3, bounds: (-100, 100))
        
        let paso = stepsNeceseToArrive(mn,mn.bounds.1)
        
        
        
        XCTAssert( paso == 66 )
    }
    
    
    func testobtenerintervalosdelametrica() {
        
        let mn = n(stepMinim: 3, bounds: (-100, 100))
        
        
        let metric = obtenerIntervalosDeLaMetrica(mn)
        
        let fg = 9000001
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    
}
