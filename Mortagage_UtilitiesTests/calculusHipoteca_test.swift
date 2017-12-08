//
//  calculusHipoteca_test.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 7/12/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest

@testable import Mortagage_Utilities


class calculusHipoteca_test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_prestamoCuota() {
        
        let cuot = prestamos.cuota(totalPrestamo: 120000, tipo: 0.02, periodos: 240)
        
        let cuotHipo = prestamos.cuotaHipoteca(totalPrestamo: 120000, tipo: 0.02, periodos: 20)
        
        let intereses = (0.02/12) * 120000
        
        let cuoDivi = prestamos.cuotaDividida(capPte: 120000, tipo: 0.02, periodosRestan: 239)
        
        let ff = "pfppfpfpfp"
        
        
        
    }
    
    
    func test_cuotaDividida() {
    
        let capMain = 120000.00
        
        let cuoDivi = prestamos.cuotaDividida(capPte: capMain, tipo: 0.02, periodosRestan: 240)
        
        let newCap = capMain - cuoDivi.1
        let cuotadiv1 = prestamos.cuotaDividida(capPte:newCap  , tipo: 0.02, periodosRestan: 239)
        
        let newCap2 = newCap - cuotadiv1.1
        let cuotadiv2 = prestamos.cuotaDividida(capPte:newCap2  , tipo: 0.02, periodosRestan: 238)
        
        let newCap3 = newCap2 - cuotadiv2.1
        let cuotadiv3 = prestamos.cuotaDividida(capPte:newCap3  , tipo: 0.02, periodosRestan: 237)
        
        let cuotaAmort3 = cuotadiv3.1.givemeRoundTwoplaces()
        
        
        
       let ff = "pfppfpfpfp"
        
        
        
    }
    
    
}
