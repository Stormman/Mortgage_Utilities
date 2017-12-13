//
//  portfolio_tests.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 8/12/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest

@testable import Mortagage_Utilities

class portfolio_tests: XCTestCase {
    
    let pf  =  portfolioEmptyWith <&> 100000 <&> tDate_(1, 1, 2018)!
    
    let prod1 = productFact <&> indexesHipoSample.euribor1año <&> tDate_(1, 1, 2018)! <&> 10 <&> 0.03
    let prod2 = productFact <&> indexesHipoSample.bono10Esp <&> tDate_(1, 1, 2018)! <&> 5 <&> 100.12
    let prod3 = productFact <&> indexesHipoSample.eurodollar <&> tDate_(1,1, 2010)! <&> 6 <&> 1.2334
    
    let prodMinus1_half = productFact <&> indexesHipoSample.euribor1año <&> tDate_(1, 1, 2018)! <&> -6 <&> 0.04
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
       
        
    }
    
    func test_portfolioConstru() {
        
    let portf = portfolioEmptyWith <&> 100000 <&> tDate_(1, 1, 2018)!
        
        
        
     XCTAssertTrue(portf is portFolio)
    }
    
    func test_productsConstru() {
     
        XCTAssertTrue(prod1 is product)
        XCTAssertTrue(prod2 is product)
        XCTAssertTrue(prod3 is product)
    }
    
    func test_addPortfolio_previousEmpty_addedthesame() {
        
       
        
        let addTo = addToPortfolio([prod1, prod2 ])
        
        let prRes = addTo.exec(pf)
       
        
        XCTAssertTrue(prRes.products.count == 2 && prRes.products[0].name == indexesHipoSample.euribor1año.rawValue)
        
        XCTAssertTrue(prRes.products[0].contrats == 10 && prRes.products[0].dateBuy == tDate_(1, 1, 2018)!.numberAssoc)
        
        XCTAssertTrue(prRes.products[1].name == indexesHipoSample.bono10Esp.rawValue)
        
        XCTAssertTrue(prRes.products[1].contrats == 5 && prRes.products[1].dateBuy == tDate_(1, 1, 2018)!.numberAssoc)
        
        
    }
    
    func test_addportfolio_addproductLongPosition_saldominusinthequantity() {
        
      
        
        
        let sldominus1 = prod1.contrats * prod1.priceBuy * prod1.multiplier
        let sldominu2 = prod2.contrats * prod2.priceBuy * prod2.multiplier
        
        let addTo = addToPortfolio([prod1,prod2])
        
        let prRes = addTo.exec(pf)
        
        let saldoResult = pf.saldo - sldominus1 - sldominu2
        
        XCTAssertTrue(prRes.saldo == saldoResult)
    }
    
    func test_addportfolio_addLongToExistedLongPosition_SummOfLongpluslongold() {
        
       
       
        
        let addTo = addToPortfolio([prod1,prod2])
        
       let addAnother = addToPortfolio([prod1])
        
        let addAnotherAnother = addToPortfolio([prod2 ])
        
        let allAdd = ( addTo >+> addAnother) >+> addAnotherAnother
        
        let portfResult = allAdd.exec(pf)
        
        
        XCTAssertTrue(portfResult.products[0].contrats == 20 )
        XCTAssertTrue(portfResult.products[0].name == indexesHipoSample.euribor1año.rawValue)
        
        XCTAssertTrue(portfResult.products[1].contrats == 10 )
        XCTAssertTrue(portfResult.products[1].name == indexesHipoSample.bono10Esp.rawValue)
        
        
    }
    
    func test__addportfolio_addLongPositionToEmptyPortfolio_garantias() {
        
        let addTo = addToPortfolio([prod1, prod2 ])
        
        let prRes = addTo.exec(pf)
        
        let garantiasProd1 = prod1.garantiasPorContrato * prod1.contrats
        let garantiasProd2 = prod2.garantiasPorContrato * prod2.contrats
        
        let totalGarant = garantiasProd1 + garantiasProd2
        
        XCTAssertTrue(prRes.garantias == totalGarant)
     }
    func test__addportfolio_addshortPositionToLongPreexistedPositions_CantidadesExactas() {
        
        let addTo = addToPortfolio([prod1, prod2 ])
        
        let addProd1Minus = addToPortfolio([prodMinus1_half])
        
        let allAdd = addTo >+> addProd1Minus
        
        let prRes = allAdd.exec(pf)
        
        let prodModified = prRes.products.first(where: {$0.name == indexesHipoSample.euribor1año.rawValue})
        
        
        XCTAssertTrue(prodModified!.contrats == 4)
        
        
        
        
        
    }
    
    
    
    
}
