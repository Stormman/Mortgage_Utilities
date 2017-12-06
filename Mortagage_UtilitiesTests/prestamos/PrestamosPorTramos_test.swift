//
//  PrestamosPorTramos_test.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 5/12/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest
@testable import Mortagage_Utilities

class PrestamosPorTramos_test: XCTestCase {
    
     let presTram =  prestamoPorTramos <&> 120000.00 <&> tDate_(1, 1, 2018)! <&> 120 <&> [0:tipo.fijo(0.02),160:tipo.fijo(0.07),200:tipo.variable]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_ConstructorRetunrsPrestPortramos() {
        
        
      
        
        XCTAssertTrue(presTram is prestamoHipotTramos)
        
        
    }
    
    func test_euriborAppliedInEachPeriodCorrespondWithThetramo() {
        
        
        
      let euriborrecorrido = recorridoEuribor(10000)
    
        
       let actuA150 = actualizePrestamoHipotecario <&> 100 <&> euriborrecorrido
       let actuA160 = actualizePrestamoHipotecario <&> 160 <&> euriborrecorrido
        let actuA180 = actualizePrestamoHipotecario <&> 180 <&> euriborrecorrido
        let actuA200 = actualizePrestamoHipotecario <&> 200 <&> euriborrecorrido
        let actuA250 = actualizePrestamoHipotecario <&> 250 <&> euriborrecorrido
        
        
        let pre150 = actuA150.exec(presTram)
        XCTAssertTrue(pre150!.euriborWithPeriod() == 0.02)
        
        let pre160 = actuA160.exec(presTram)
        XCTAssertTrue(pre160!.euriborWithPeriod() == 0.07)
        
        let pre180 = actuA180.exec(presTram)
        XCTAssertTrue(pre180!.euriborWithPeriod() == 0.07)
        
        let pre200 = actuA200.exec(presTram)
        XCTAssertTrue(pre200!.euriborWithPeriod() == 0.05)
        
        let pre250 = actuA250.exec(presTram)
        XCTAssertTrue(pre250!.euriborWithPeriod() == 0.05)
        
        
    }
    
    
    
    
}
