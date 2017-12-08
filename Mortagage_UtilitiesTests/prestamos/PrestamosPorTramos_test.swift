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
    
    let presTram =  prestamoPorTramos <&> 120000.00 <&> tDate_(1, 1, 2018)! <&> 20 <&> [0:tipo.fijo(0.02),355:tipo.fijo(0.07),903:tipo.variable,2191:tipo.fijo(0.08)]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_ConstructorRetunrsPrestPortramos() {
        
        
      
        
        XCTAssertTrue(presTram is prestamoHipotTramos)
        
        
    }
    
    func test_euriborAppliedInEachPeriodCorrespondWithThetramo() {
        
        
        
      let euriborrecorrido = recorridoEuribor(10000)
    
        
       let actuA150 = actualizePrestamoHipotecario <&> 150 <&> euriborrecorrido
       let actuA260 = actualizePrestamoHipotecario <&> 260 <&> euriborrecorrido
        let actuA910 = actualizePrestamoHipotecario <&> 910 <&> euriborrecorrido
        let actuA1200 = actualizePrestamoHipotecario <&> 1200 <&> euriborrecorrido
        let actuA2200 = actualizePrestamoHipotecario <&> 2200 <&> euriborrecorrido
        
        
        let pre150 = actuA150.exec(presTram)
        XCTAssertTrue(pre150!.euriborWithPeriod() == 0.02)
        
        let pre260 = actuA260.exec(presTram)
        XCTAssertTrue(pre260!.euriborWithPeriod() == 0.02)
        
        let pre910 = actuA910.exec(presTram)
        XCTAssertTrue(pre910!.euriborWithPeriod() == 0.06)
        
        let pre1200 = actuA1200.exec(presTram)
        XCTAssertTrue(pre1200!.euriborWithPeriod() == 0.06)
        
        let pre2200 = actuA2200.exec(presTram)
        XCTAssertTrue(pre2200!.euriborWithPeriod() == 0.08)
        
        
        let daysInt = [150,260,910,1200,2200]
        
        let addedDesdeEl112018 = {(d:Double) -> Double in d + (tDate_(1, 1, 2018)?.numberAssoc)!}
        let addedLosSeconds : (Int) -> Double = {Double($0) * SEcondsPerDay   }
        let dates = {(d:Double) -> Date in d.dateAssoccDouble}
        let stringDeLaFecha = {(d:Date) -> String in d.toStringRepresent()! }
        
        let datesDadaLaDiferencia = daysInt <==> addedLosSeconds <==> addedDesdeEl112018 <==> dates <==> stringDeLaFecha
        
        let ffff = "ododod"
        
    }
    
    func test_theLastPrestNothasCapitalPendiente() {
        
     
        let euribRecorrido = recorridoEuribor <&> 7500
        
        let presAll = prestamoInThePeriod_all  <&> presTram <&> euribRecorrido <&> 7500
        
        let sinnil = presAll.flatMap{$0}
        
        let lastPrestamo = sinnil.last!
        
        let lasprestDia = lastPrestamo.actualDateSt
        
       let lasCapPte = lastPrestamo.CapitalVivoRestante.givemeRoundTwoplaces()
        
        XCTAssertTrue(lasCapPte == 0)
        
        
        
        let ff = 900000
        
        
    }
        
        
    func test_days() {
        
        let days = [(1,1,2018),(22,12,2018),(22,6,2020),(1,1,2024)]
        
        let datesInDays =  (days <==> tD) <&> sinNil
        
        let datDif = curry(dateTools.differenceDays)
        
        let difdesdeel112018 = datDif <&> tDate_(1, 1, 2018)!
        
        let diff = datesInDays <==> difdesdeel112018
        
        let pppp = 92992929
        
    
        
        
    }
    
    
    func test_ejemplosParaVer() {
        
        let euriborrecorrido = recorridoEuribor(10000)
        
        let todo = prestamoInThePeriod_all  <&> presTram <&> euriborrecorrido <&> 7291
        
       
        
        let primerCuota = todo.first!?.nextCuota()
        
        let todoSinnil = sinNil <&> todo
        
        let EsdiaDeCobro: (prestamoH) -> Bool = {$0.isThisPeriodoToPay <&> $0.dateActual  }
        let elCapPte :(prestamoH) -> Double = {$0.CapitalVivoRestante}
        let cuotaAmorti :(prestamoH) -> Double = {$0.cuotaDeHoy.1}
        let diasPtesDePago :(prestamoH) -> Int = {$0.periodosPorPagar}
        
        let soloCuandohayqueCObrar = todoSinnil.filter(EsdiaDeCobro)
        
        let cpPte = soloCuandohayqueCObrar <==> elCapPte
        let cuotaAmort = soloCuandohayqueCObrar <==> cuotaAmorti
        let diasPtes = soloCuandohayqueCObrar <==> diasPtesDePago
        
         let todoCaptPte = todoSinnil <==> diasPtesDePago
        
        
        let di = 900000
        
        
        
        
    }
    
    func test_CapitalPendienteInDays() {
        
        let euriborrecorrido = recorridoEuribor(10000)
        
        
        let actuA150 = actualizePrestamoHipotecario <&> 150 <&> euriborrecorrido
        let actuA260 = actualizePrestamoHipotecario <&> 260 <&> euriborrecorrido
        let actuA910 = actualizePrestamoHipotecario <&> 910 <&> euriborrecorrido
        let actuA1200 = actualizePrestamoHipotecario <&> 1200 <&> euriborrecorrido
        let actuA2200 = actualizePrestamoHipotecario <&> 2200 <&> euriborrecorrido
        
        let actu20 = actualizePrestamoHipotecario <&> 2 <&> euriborrecorrido
        let capPte20 = actu20.exec(presTram)?.CapitalVivoRestante
        let eurib = (actu20.exec <&> presTram )?.euriborWithPeriod()
        let cuot = (actu20.exec <&> presTram )?.nextCuota()
        
        
        
        
        let pre150 = actuA150.exec(presTram)
        let capPte150 = pre150?.CapitalVivoRestante
        
        
        //XCTAssertTrue(pre150!.euriborWithPeriod() == 0.02)
        
        let pre260 = actuA260.exec(presTram)
        let capPte260 = pre260?.CapitalVivoRestante
        //XCTAssertTrue(pre260!.euriborWithPeriod() == 0.02)
        
        let pre910 = actuA910.exec(presTram)
        let capPte910 = pre910?.CapitalVivoRestante
        //XCTAssertTrue(pre910!.euriborWithPeriod() == 0.06)
        
        let pre1200 = actuA1200.exec(presTram)
        let capPte1200 = pre1200?.CapitalVivoRestante
        //XCTAssertTrue(pre1200!.euriborWithPeriod() == 0.06)
        
        let pre2200 = actuA2200.exec(presTram)
        let capPte2200 = pre2200?.CapitalVivoRestante
        //XCTAssertTrue(pre2200!.euriborWithPeriod() == 0.08)
        
        
        
        
        let ffp = 40404040400404
        
        
        
        
        
    }
    func test_fiveFirstMonths() {
        
        // n Month , intereses, amortizacion , capitalPte and yield
        let cases_ = [(0,120000,200.00,407.06),(1,119592.94,199.32,407.74),(2,119185.20,198.64,408.42),(3,118776.78,197.96,409.10)]
        
        let euriborrecorrido = recorridoEuribor(10000)
        
        let todo = prestamoInThePeriod_all  <&> presTram <&> euriborrecorrido <&> 7291
        
        let primerCuota = todo.first!?.nextCuota()
        
        let todoSinnil = sinNil <&> todo
        
        let EsdiaDeCobro: (prestamoH) -> Bool = {$0.isThisPeriodoToPay <&> $0.dateActual  }
        let elCapPte :(prestamoH) -> Double = {$0.CapitalVivoRestante}
        let cuotaAmorti :(prestamoH) -> Double = {$0.cuotaDeHoy.1}
        
       
        
        let soloCuandohayqueCObrar = todoSinnil.filter(EsdiaDeCobro)
        
        
        let capV = soloCuandohayqueCObrar[0].CapitalVivoRestante
        let cuotInt = (soloCuandohayqueCObrar[0].cuotaDeHoy.0).givemeRoundTwoplaces() == 200.00
        let coutAmor = (soloCuandohayqueCObrar[0].cuotaDeHoy.1).givemeRoundTwoplaces()
        
       // print( "el rdo es :" +  String(BoolToInt(cuotInt)) + String(BoolToInt(coutAmor)))
        
        
        
        
       
        XCTAssertTrue((soloCuandohayqueCObrar[0].CapitalVivoRestante).givemeRoundTwoplaces() == cases_[0].1)
        XCTAssertTrue((soloCuandohayqueCObrar[0].cuotaDeHoy.0).givemeRoundTwoplaces() == cases_[0].2)
        XCTAssertTrue((soloCuandohayqueCObrar[0].cuotaDeHoy.1).givemeRoundTwoplaces() == cases_[0].3)
        XCTAssertTrue((soloCuandohayqueCObrar[1].CapitalVivoRestante).givemeRoundTwoplaces() == cases_[1].1)
        XCTAssertTrue((soloCuandohayqueCObrar[1].cuotaDeHoy.0).givemeRoundTwoplaces() == cases_[1].2)
        XCTAssertTrue((soloCuandohayqueCObrar[1].cuotaDeHoy.1).givemeRoundTwoplaces() == cases_[1].3)
        XCTAssertTrue((soloCuandohayqueCObrar[2].CapitalVivoRestante).givemeRoundTwoplaces() == cases_[2].1)
        XCTAssertTrue((soloCuandohayqueCObrar[2].cuotaDeHoy.0).givemeRoundTwoplaces() == cases_[2].2)
        XCTAssertTrue((soloCuandohayqueCObrar[2].cuotaDeHoy.1).givemeRoundTwoplaces() == cases_[2].3)
        XCTAssertTrue((soloCuandohayqueCObrar[3].CapitalVivoRestante).givemeRoundTwoplaces() == cases_[3].1)
        XCTAssertTrue((soloCuandohayqueCObrar[3].cuotaDeHoy.0).givemeRoundTwoplaces() == cases_[3].2)
        XCTAssertTrue((soloCuandohayqueCObrar[3].cuotaDeHoy.1).givemeRoundTwoplaces() == cases_[3].3)
        
        
        
        
    }
    
    
    
}
