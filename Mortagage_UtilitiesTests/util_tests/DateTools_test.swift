//
//  DateTools_test.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 13/12/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest

@testable import Mortagage_Utilities

class DateTools_test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_addtoPortfolio() {
        
        
     let port1 = Std.addToPortfolio(nContIni: 10, priceIni: 5, nContrToAdd: 5, newPrice: 6)
    
     let port2 = Std.addToPortfolio(nContIni: 10, priceIni: 5, nContrToAdd: -5, newPrice: 5)
        
      let port3 = Std.addToPortfolio(nContIni: -10, priceIni: -5, nContrToAdd: -5, newPrice: 6)
        
     let port4 = Std.addToPortfolio(nContIni: -10, priceIni: 5, nContrToAdd: 5, newPrice: 6)
        
        
       let p1 = Std.toSaldoAdd(nContIni: 10, priceIni: 5, mult: 100, nContrToAdd: 5, newPrice: 6)
        
        XCTAssertTrue(p1 == 0)
        
        let p2 = Std.toSaldoAdd(nContIni: 10, priceIni: 5, mult: 100, nContrToAdd: -6, newPrice: 6)
        
        XCTAssertTrue(p2 == 600)
        
        let p3 = Std.toSaldoAdd(nContIni: 10, priceIni: 5, mult: 100, nContrToAdd: -10, newPrice: 6)
        
        XCTAssertTrue(p3 == 1000)
        
        let q1 = Std.toSaldoAdd(nContIni: -10, priceIni: 5, mult: 100, nContrToAdd: -5, newPrice: 6)
        
        XCTAssertTrue(q1 == 0)
        
        let q2 = Std.toSaldoAdd(nContIni: -10, priceIni: 5, mult: 100, nContrToAdd: 6, newPrice: 6)
        
        XCTAssertTrue(q2 == -600)
        
        let q3 = Std.toSaldoAdd(nContIni: -10, priceIni: 5, mult: 100, nContrToAdd: 10, newPrice: 6)
        
        XCTAssertTrue(q3 == -1000)
        
        
        
        
        
        let fg = 9000000
        
        
      
        
        
        
        
    }
}
