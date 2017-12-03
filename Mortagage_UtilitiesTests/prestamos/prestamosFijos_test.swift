//
//  prestamosFijos_test.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 3/12/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest
@testable import Mortagage_Utilities


class prestamosFijos_test: XCTestCase {
    
    
    
    
    let prestamoFijo_ = prestFijo <&> 120000.00 <&> 0.04 <&> tDate_(1, 1, 2018)! <&> 20
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_WheThefuncIsOverPeriodoIsNIll() {
        
        
        let overPeriod = (31 * 20 ) + 500
        
        let pr = prestamoInThePeriod_ <&> prestamoFijo_ <&> overPeriod
        
        XCTAssert(pr == nil)
        
        
        
        
    }
    
    func test_WhenThefuncIsOverPeriodoIsNIll() {
        let overPeriod = (31 * 20 ) + 500
        let pr = prestamoInThePeriod_ <&> prestamoFijo_ <&> overPeriod
        XCTAssert(pr == nil)
    }
    
    func test_whenTheFuncIsOnPeriodIsNotnil() {
        let otroprInTheperiod = prestamoInThePeriod_ <&> prestamoFijo_ <&> 100
        XCTAssert(otroprInTheperiod != nil )
        
        let otroprInTheperiod2 = prestamoInThePeriod_ <&> prestamoFijo_ <&> 50
        XCTAssert(otroprInTheperiod2 != nil )
        
        let otroprInTheperiod3 = prestamoInThePeriod_ <&> prestamoFijo_ <&> 70
        XCTAssert(otroprInTheperiod3 != nil )
        
        let otroprInTheperiod4 = prestamoInThePeriod_ <&> prestamoFijo_ <&> 150
        XCTAssert(otroprInTheperiod4 != nil )
    }


   
    
}
