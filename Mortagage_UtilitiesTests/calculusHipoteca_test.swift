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
        
        let ff = "pfppfpfpfp"
        
        
        
    }
    
}
