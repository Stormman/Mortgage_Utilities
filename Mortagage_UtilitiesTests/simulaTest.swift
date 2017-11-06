//
//  simulaTest.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 4/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest
@testable import Mortagage_Utilities

class simulaTest: XCTestCase {
    
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
    
    func testgeneratorOfSimulT() {
        
        let funcsGeneratordeprueba = generateSamplesOfFuncIntToDou <> 10
        
        let doubles = funcsGeneratordeprueba <=> ( generaDoubleEnElPeriodo <> 20 )
        
        let estadisticosTipicos = [mean , desvTip]
        
        
       // let fGe = generatorsOfSimul(functionsOf: funcsGeneratordeprueba, estadisitcos: estadisticosTipicos)
        
        let fGe2 = simulacionDe <> funcsGeneratordeprueba <> estadisticosTipicos
        
        
       
        
        let sim = fGe2 <> simulatIn <> 5
        
        print (sim)
        
        
        
        let ar = (arrayDeNumeros <> take(20) ) <=> (fGe2 <> simulatIn)
        
        
        
        
        let fffp = 988888
        
        let ffg = 12000
        
    }
    
    func testIterator() {
        
      let se = SeqSimul(20)
        
        
        let set = {(s : Double ) in String(s)   }
        
        let eee = se.map(set)
        
        let ooo = se <=> set
        
        
        let rrr = 900000
        
        
        
        
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
