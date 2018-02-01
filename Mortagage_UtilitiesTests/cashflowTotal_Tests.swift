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
    
    func test_simulHipot () {
        
        
        let smih = simulHipot(presta_: 100000, años_: 25, eurib_: 1, diferen_: 0.5)
        
        let f = smih.nextPeriod(numeroPeriodos: 1)
        
        let hipCash = HipotecaCashFlowing(presta_: 100000, años_: 25, eurib_: 1, diferen_: 1, indiceSuscrip: "euribor", diasDeCo: 18, contador: 0, fechaInicioCnt: tDate_(1, 1, 2018)!, tramoF: (nil,nil), tipoFix: 3)
        
        
        
        
        
        
        
        
        
    }
    
}
