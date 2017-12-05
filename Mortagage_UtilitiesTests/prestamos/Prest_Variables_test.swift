//
//  Prest_Variables_test.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 4/12/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest

@testable import Mortagage_Utilities

class Prest_Variables_test: XCTestCase {
    
     let prestVar = prestamoVariable <&> 120000.00 <&> 0.04 <&> tDate_(1, 1, 2018)! <&> 20
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_COnstructorNotNil() {
        
       
        
        XCTAssert(prestVar != nil)
        XCTAssert(prestVar is prestamoHipotecarioVariable)
        
    }
    
    func test_RenovacionSemestral() {
        
        let p =  prestVar.IsthisPeriodRevisedIndexEurib((tDate_(ConstantsHipot.diaRenovac_, 6, 2018)?.numberAssoc)!)
        
        XCTAssert(p == true)
        
         let p2 =  prestVar.IsthisPeriodRevisedIndexEurib((tDate_(ConstantsHipot.diaRenovac_ + 1 , 6, 2018)?.numberAssoc)!)
        
        XCTAssert(p2 == false)
        
        let p3 =  prestVar.IsthisPeriodRevisedIndexEurib((tDate_(ConstantsHipot.diaRenovac_  , 12, 2018)?.numberAssoc)!)
        
        XCTAssert(p3 == true)
        let p4 =  prestVar.IsthisPeriodRevisedIndexEurib((tDate_(ConstantsHipot.diaRenovac_ + 1 , 12, 2018)?.numberAssoc)!)
        
        XCTAssert(p4 == false)
        
    }
    
    func test_WhenThefuncIsOverPeriodoIsNIll() {
        
        let overPeriod = (31 * 20 * 12 ) + 500
        let pr = prestamoInThePeriod_ <&>  prestVar <&> overPeriod
        
        
        
        
        
        
    }
    func test_whenTheFuncIsOnPeriodIsNotnil() {
        let otroprInTheperiod = prestamoInThePeriod_ <&>  prestVar <&> 100
        XCTAssert(otroprInTheperiod != nil )
        
        let otroprInTheperiod2 = prestamoInThePeriod_ <&>  prestVar <&> 50
        XCTAssert(otroprInTheperiod2 != nil )
        
        let otroprInTheperiod3 = prestamoInThePeriod_ <&>  prestVar <&> 70
        XCTAssert(otroprInTheperiod3 != nil )
        
        let otroprInTheperiod4 = prestamoInThePeriod_ <&>  prestVar <&> 150
        XCTAssert(otroprInTheperiod4 != nil )
    }
    
    
    func test_TheLastperiodISthePrevist()  {
        
        
        let periodsOfPrest = prestamosAllInTHePeriod_ <&> prestVar <&> 12000
        
        let firstNotNIl = periodsOfPrest.filter { $0 != nil   }
        
        let lastFives = firstNotNIl.dropFirst(firstNotNIl.count - 5)
        
        let diaUltimo = firstNotNIl.last!?.actualDateSt
        
        XCTAssert(diaUltimo! == "18-12-2037")
        
        
        
        
    }
    func test_cuotaApagar() {
        
        let cuot = prestVar.nextCuota()
        
        let f = cuot.0 + cuot.1
        
        XCTAssert(f.givemeRoundTwoplaces() == 727.18)
        
        
        
    }
    
    func test_WhenEuriborchanges_theDateOfRenovacArrivesThegiveEuriborChange() {
       
      
        
        let tEnDias = dateTools.differenceDays(start: tDate_(1, 1, 2018)!, toDate: tDate_(15, 6, 2018)!)
        
         let otroprInTheperiod = prestamoInThePeriod_ <&>  prestVar <&> (tEnDias - 2 )
        
        let st =  actualizePrestHIpotecario(period: tEnDias - 1 ,indHpotecSample(bookTrade: [indexesHipoSample.euribor1año:0.03]) )
        
        let pr = st.exec(otroprInTheperiod)
        
        let d = pr?.euriborWithPeriod()
        let dia = pr?.actualDateSt
        let ffp = (pr as! prestamoHipotecarioVariable).IsthisPeriodRevisedIndexEurib((pr?.dateActual)!)
        
        XCTAssert(d == 0.03)
        
        
        
    }
    func test_WhenEuriborchanges_thecnagesnotchangedtothepreviousvalue() {
        
        let tEnDias = dateTools.differenceDays(start: tDate_(1, 1, 2018)!, toDate: tDate_(15, 6, 2018)!)
        
        let otroprInTheperiod = prestamoInThePeriod_ <&>  prestVar <&> (tEnDias - 2 )
        
        let st =  actualizePrestHIpotecario(period: tEnDias  ,indHpotecSample(bookTrade: [indexesHipoSample.euribor1año:0.03]) )
        
        let pr = st.exec(otroprInTheperiod)
        
        let d = pr?.euriborWithPeriod()
        let dia = pr?.actualDateSt
        let ffp = (pr as! prestamoHipotecarioVariable).IsthisPeriodRevisedIndexEurib((pr?.dateActual)!)
        
        XCTAssert(d == 0.03)
        
        
        
    }
    
    func test_itCanProduceArecorridoOfPrestamosWithRecorridoeuriborthere(){
        
        
         let tEnDias = dateTools.differenceDays(start: tDate_(1, 1, 2018)!, toDate: tDate_(15, 12, 2018)!)
        
        
        
        let unrecorridodelEuribor = recorridoEuribor <&> 12000
        
        let noigual = TodosIguales(unrecorridodelEuribor)
        
        XCTAssert(noigual == false )
        
        
        
        let prestIn = prestamoInThePeriod_ <&> prestVar <&> unrecorridodelEuribor <&> 200
        
        XCTAssert(prestIn != nil)
        
        let euriborenelperiodo = prestIn?.euriborWithPeriod()
        
        XCTAssert(prestIn?.euriborWithPeriod() == 0.05)
        
        
        
        
    }
    
    func test_AcutalizrPrestamoHipotecario_Exists() {
        
        let unrecorridodelEuribor = recorridoEuribor <&> 12000
        
        let actualPresstamoState = actualizePrestamoHipotecario  <&> 560 <&> unrecorridodelEuribor
        
        XCTAssertNotNil(actualPresstamoState)
        XCTAssertTrue(actualPresstamoState is State<prestamoH?, rHipotSample> )
    }
    func test_ActualizePrestamoHipotecario_returnsStateThaCOnvertThrprestamoInotherPrest() {
        
        let unrecorridodelEuribor = recorridoEuribor <&> 12000
        
        let actualPresstamoState = actualizePrestamoHipotecario  <&> 560 <&> unrecorridodelEuribor
        
        
        let anotherPrest = actualPresstamoState.exec(prestVar)
        XCTAssertTrue(anotherPrest is prestamoH?)
        
    }
    
    
    func test_ActualizePrestamoHipotecario_returnsStateThaCOnvertThrprestamoInotherPrestinThisPeriodExact() {
        
        
        let unrecorridodelEuribor = recorridoEuribor <&> 12000
        
        let actualPresstamoState = actualizePrestamoHipotecario  <&> 560 <&> unrecorridodelEuribor
        
        
        let anotherPrest = actualPresstamoState.exec(prestVar)
        
        
        let gg = (tDate_(1, 1, 2018)!.numberAssoc + SEcondsPerDay * 560).dateAssoccDouble.toStringRepresent()
        
        let dif = dateTools.differenceDays(start: tDate_(1, 1, 2018)!, toDate: tDate_(15, 7, 2019)!)
        
        let fechaPrestModified = anotherPrest?.actualDateSt
        
        XCTAssertTrue(fechaPrestModified == gg!)
        
        
        
    }
    
    func test_ActualizePrestamoHipotecario_returnsStateThaCOnvertThrprestamoInotherPrestwithcashresultdiffZero(){
        
        let unrecorridodelEuribor = recorridoEuribor <&> 12000
        
        let actualPresstamoState = actualizePrestamoHipotecario  <&> 160 <&> unrecorridodelEuribor
        
        
        let anotherPrest = actualPresstamoState.exec(prestVar)
        
        
        let resultado = actualPresstamoState.eval(prestVar)
        
        let resCash = resultado.bookTrade[resultsHipoSample.cash]
        
        XCTAssertTrue(resCash! != 0)
        
        
        
        
    }
    
    func testex() {
        
        let unrecorridodelEuribor = recorridoEuribor <&> 12000
        
        let actualPresstamoState = actualizePrestamoHipotecario  <&> 560 <&> unrecorridodelEuribor
        
        
        let anotherPrest = actualPresstamoState.exec(prestVar)
        
        
        
        
        
        
        
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
