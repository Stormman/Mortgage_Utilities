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
        
        let clpo = closeAllPositions()
        
        let addi = addToPortfolio([])
        
        let act = actualizeProduct(indHpotecSample(bookTrade: [:]))
        
        let actpo = curry(actualizePortfolio)
        
        let transpo = clpo >+> addi >+> clpo
        
        let po : Int? = nil
        let nu : Double? = 78.90
        
        let dt = curry(Date.dateWithDayMonthAndYear)
        
        let ff = dt <&> 14 <&> 12 <&> 2018
        
        let fffff = 900000
        
        
        
        
    }
    
    func test_prestamoHipotecarioFijo() {
        
       // let presF = prestamoHipotecarioFijo(CapitalVivoRestante: 120000, tipo: 0.04, tipoActual: 0.04, dateActual: 0, isThisPeriodoToPay: <#T##(Int) -> Bool#>, dateIntTOString: <#T##(Int) -> String#>, periodosPorPagar: <#T##Int#>)
       
        
        
       
        
        
        
       //
        
       
        
        
        
    }
    
    func test_fechaProximopago () {
        
        // quiero que dada una fecha y unos meses
        
        let fechaComienzoHipoteca = Date.dateWithComponents(day: 1, month: 1, year: 2018, hour: 23, minute: 0, second: 0)
        let fechaFinHipoteca = Date.dateWithComponents(day: 31, month: 12, year: 2038, hour: 23, minute: 0, second: 0)
        let diasDePago = 18
        
        let today = Date.dateWithComponents(day: 2, month: 1, year: 2018, hour: 23, minute: 0, second: 0)
        
        let fechaHip : hipotDate = hipotDate(fInit:fechaComienzoHipoteca!,fEnd: fechaFinHipoteca!, dayToPay:18)
        
        let dia : Date = fechaProximoPago(dateHipoteca: fechaHip, hoy: today!   )
        
        let st = dia.toStringRepresent()
        
        
        XCTAssert(st  == "18-01-2018")
        
        
        let tod = Date.dateWithComponents(day: 2, month: 2, year: 2018, hour: 23, minute: 0, second: 0)
        let dia2 : Date = fechaProximoPago(dateHipoteca: fechaHip, hoy: tod!   )
        
        XCTAssert(dia2.toStringRepresent() == "19-02-2018")
        
        
        let tod2 = Date.dateWithComponents(day: 2, month: 3, year: 2019, hour: 23, minute: 0, second: 0)
        let dia3 : Date = fechaProximoPago(dateHipoteca: fechaHip, hoy: tod2!   )
        
        XCTAssert(dia3.toStringRepresent() == "18-03-2019")
        
      XCTAssert(dia.componetsOf()?.weekday == 5)
        XCTAssert(dia2.componetsOf()?.weekday == 2)
        XCTAssert(dia3.componetsOf()?.weekday == 2)
        
        
        
    }
    
    func test_isfechaprosimopago() {
        
        let fechaComienzoHipoteca = Date.dateWithComponents(day: 1, month: 1, year: 2018, hour: 23, minute: 0, second: 0)
        let fechaFinHipoteca = Date.dateWithComponents(day: 31, month: 12, year: 2038, hour: 23, minute: 0, second: 0)
        let diasDePago = 18
        
        let today: Date! = Date.dateWithComponents(day: 19, month: 2, year: 2018, hour: 23, minute: 0, second: 0)
        
        let fechaHip : hipotDate = hipotDate(fInit:fechaComienzoHipoteca!,fEnd: fechaFinHipoteca!, dayToPay:18)
        
        let proxim = isFechaProsimoPago <&> fechaHip
        
        let yesono = proxim <&> today
        
        
        XCTAssert(yesono == true )
        
         let today2: Date! = Date.dateWithComponents(day: 18, month: 2, year: 2018, hour: 23, minute: 0, second: 0)
        let yesono2 = proxim <&> today2
        
        
        XCTAssert(yesono2 == false )
        
        let today3: Date! = Date.dateWithComponents(day: 18, month: 5, year: 2019, hour: 23, minute: 0, second: 0)
        let yesono3 = proxim <&> today3
        
        
        XCTAssert(yesono3 == false )
        
        let today4: Date! = Date.dateWithComponents(day: 20, month: 5, year: 2019, hour: 23, minute: 0, second: 0)
        let yesono4 = proxim <&> today4
        
        
        XCTAssert(yesono4 == true )
        
    }
    
    func test_isProximaRenovac() {
        
        
        //let hipo = hipotDate.proof()
        
        let cada3mesesElDia15 = isfechaProximaRenovacionIndice <&> 15 <&> 3
        
        let today1 :Date! = Date.dateWithDayMonthAndYear(15, 3, 2018)
        
        let resul = cada3mesesElDia15 <&> today1
        
        XCTAssert(resul == true)
        
        
        let today2 :Date! = Date.dateWithDayMonthAndYear(17, 3, 2018)
        
        let resul2 = cada3mesesElDia15 <&> today2
        
        XCTAssert(resul2 == false )
        
        
        let today3 :Date! = Date.dateWithDayMonthAndYear(15, 6, 2018)
        
        let resul3 = cada3mesesElDia15 <&> today3
        
        XCTAssert(resul3 == true)
        
        let today4 :Date! = Date.dateWithDayMonthAndYear(1, 1, 2018)
        
        let resul4 = cada3mesesElDia15 <&> today4
        
        XCTAssert(resul4 == true)
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
