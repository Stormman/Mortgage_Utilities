//
//  cashflowTotal_Tests.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 1/2/18.
//  Copyright © 2018 Antonio Muñoz. All rights reserved.
//

import XCTest
@testable import Mortagage_Utilities


class cashflowTotal_Tests: XCTestCase {
    
    func test_simulHipot_and_cfds () {
        
        
        let smih = simulHipot(presta_: 100000, años_: 20, eurib_: 1, diferen_: 0.5)
        
        let f = smih.nextPeriod(numeroPeriodos: 1)
        
        let hipCash = HipotecaCashFlowing(presta_: 100000, años_: 20, eurib_: 1, diferen_: 1, indiceSuscrip: "euribor", diasDeCo: 18, contador: 0, fechaInicioCnt: tDate_(1, 1, 2018)!, tramoF: (nil,nil), tipoFix: 3)
        
        
        let cfd = CFDTot(priceBu: 100, priceV: 101, nContr: 10, mult: 10, contador: 0, indiceSus: "euribor", garantiasPCon: 700)
        
        
        let cash = CashFlowSimul(fechaInic: tDate_(1, 1, 2018)!, fechaFin: tDate_(31, 12, 2038)!, saldoInicial: 120000)
        
        cash.addGtempo(ne: hipCash, isMain: true )
        cash.addGtempo(ne: cfd, isMain: false )
        cash.addGlobalIndic(nameInd: "euribor", valuer: 105)
        
        
        let arr = Array(1...100)
        
        let ot = arr <==> {(_)-> Double  in
            
          cash.nextPeriod()
            
            return cash.saldoTotal
            
            
        }
        
        
        let ff = 900000
        
        
        
        
        
        
        
    }

    
    func test_cfdsSimul() {
        
        
        let cfd = CFDTot(priceBu: 100, priceV: 101, nContr: 10, mult: 10, contador: 0, indiceSus: "euribor", garantiasPCon: 700)
        
        
        let cash = CashFlowSimul(fechaInic: tDate_(1, 1, 2018)!, fechaFin: tDate_(31, 12, 2038)!, saldoInicial: 120000)
        
        
        cash.addGtempo(ne: cfd, isMain: false )
        cash.addGlobalIndic(nameInd: "euribor", valuer: 105)
        
        
        let ot = Array(1...100) <==> {(_)-> Double  in
            
            cash.nextPeriod()
            
            return cash.saldoTotal
            
            
        }
        
        cfd.addContratos(nCont: -1)
        
        cash.nextPeriod()
        
        let sal = cash.saldoTotal
        
        
        let vpp = 900000
        
        
        
    }
    
}
