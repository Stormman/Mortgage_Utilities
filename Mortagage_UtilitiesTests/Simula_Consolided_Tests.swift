//
//  Simula_Consolided_Tests.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 9/1/18.
//  Copyright © 2018 Antonio Muñoz. All rights reserved.
//

import XCTest
@testable import Mortagage_Utilities


class Simula_Consolided_Tests: XCTestCase {
    
    func testGenerateSimple() {
     
        
        
    //los indexes
     let ind = indexesAndVarAleasOfPrueba(["Euribor 1 año","Bono 10 Esp","EuroDollar"], (100,20))
      
    //ahora los funcxs
         //primero el portfolio
          let today = Date.dateWithDayMonthAndYear(1, 1, 2018)
        
            let productosCfds = [productFactory_(indexesHipoSample.euribor1año, today!, 10, priceBuy: 1.2500),
                                 productFactory_(indexesHipoSample.euribor1año, today!, 5, priceBuy: 100.1)]
        
            let portf = portFolio(products: [], dateAct: today!.numberAssoc, saldo: 100000, garantias: 0, PyGLantentes: 0, PYGRealizadas: 0)
            let addTop = addToPortfolio(productosCfds)
            let portfRes = addTop.exec(portf)
        //ahora los comandosportfolio
        
        
            let pred1 = predicResults.indexPred({$0.bookTrade[indexesHipoSample.eurodollar]!! > 1.2530   })
            let com1 = compPortfolio.closePositions_(quatity: positionsToClose.all, prod: productFactory_(indexesHipoSample.eurodollar, today!, 1, priceBuy: 1))
            let comport = commmandsPortfolio(comm: [(pred1,com1)])
        
           let portSimul = PortfolioSIM(comm: comport, portfol: portf)
        
        // tenemos la cartera creada
        
        let f1 = AnyfunNEXXTHIpo<rHipotSample>(pruebasFX())
        let f2 = AnyfunNEXXTHIpo<rHipotSample>(portSimul)
        
    // creamos el simulador
        
        let resIniti = rHipotSample(bookTrade: [rs.cash : 0 ,rs.beneficios: 0 ])
        
        let ini = genSimInitial <&> resIniti <&> ind <&> [f1,f2] <&> converResulIndividToAgregatePruebas
        

        let to = totalSims(OneSim: ini, ind)
    
        let todos_los_esta_resumen = totalStadistically(simpleS(), resultadosSim: to)
        
    let t = 90000000
        
        
        
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            
         let ind = indexesAndVarAleasOfPrueba(["Euribor 1 año","Bono 10 Esp","EuroDollar"], (100,30))
            
            
        }
    }
   
    
}
