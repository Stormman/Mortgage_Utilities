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
    
    func testLocalizableDoubleInmetric () {
        
        
        let mn = n(stepMinim: 3, bounds: (-100, 100))
        
            let inv = localizableDoubleInMetric(12, mn)
        
        let fg = 9000
        
        
        
    }
    
    func testDoubleinintervalWhereIs () {
        
        let mn = n(stepMinim: 3, bounds: (-100, 100))
        
        
        let metric = obtenerIntervalosDeLaMetrica(mn)
        
        
        let donde = doubleInIntervalswhereIs(8, metric!)
        
        XCTAssert(donde!.pos == 36 && donde!.inter.lowBound == 8 && donde!.inter.upBound == 11)
        
        let oo = 90000
        
    }
    
    func testIntervalosmetricosStruct () {
        
        let mn = n(stepMinim: 3, bounds: (-100, 100))
        var  iv = intervalosMetricos(metri: mn)
        
        
        iv?.appendValue(8, 20)
        
        print (iv?.dicMetr)
        
        
        
        
        let fppp = 9000000
        
        
        
        
        
        
    }
    
    func testObtainfDBmemoize() {
        
        
         let v = varAleatoria(descrip: "pepe", step: 0.5, boundss: (0,7), generato: funcToExaple)
        
        
        let fdb = obtainFDBOfMemoize(v)
        
        
        fdb(1)
        
        fdb(1)
        
        
        
        let fdb2 = obtainFDBOf(v)
        
        (1...20).forEach{ print(fdb2(Double($0)))     }
        
        
        
        
    }
    
    func testCheckVarAleat () {
        
       let v = varAleatoria(descrip: "pepe", step: 0.5, boundss: (0,8), generato: funcToExaple)
        
        let sum = checkVarAlea(varAle: v)
        
        
        let wio = waysOfIO.proof()
        
        let sum2 = checkVarAlea(varAle: wio.vAlea)
        
        
        let fg = 900000
        
    }
    
    
    
    func testWaysIO () {
        
        
        let wa = waysOfIO.proof()
        
        let genr = wa.generateTheWayValues()
        
        
        let fop = 9000
        
        
       
        
        
        
        
        
        
    }
    
    
    func test_WhativIs() {
        
        
        
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    
}
