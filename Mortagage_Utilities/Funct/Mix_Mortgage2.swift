//
//  Mix_Mortgage2.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 23/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation


struct product {
    let name:String
    let priceBuy:Double
    let multiplier:Double
    let contrats:Double
    let dateBuy: Int
    let garantiasPorContrato:Double
}
let pr1 = product(name: "euriborCFD", priceBuy: 100.1, multiplier: 100, contrats: 5, dateBuy: 1, garantiasPorContrato: 250)
let pr2 = product(name: "Bono10AñosEsp", priceBuy: 105, multiplier: 100, contrats: 0.5, dateBuy: 1, garantiasPorContrato: 100)

struct portFolio {
    let products : [product]
    let dateAct : Int
    let saldo:Double
    let garantias:Double
    let PyGLantentes:Double
    let PYGRealizadas:Double
}
let portf = portFolio(products: [], dateAct: 1, saldo: 1000, garantias: 0, PyGLantentes: 0, PYGRealizadas: 0)




struct prestamoHipotecario {
    let CapitalVivoRestante : Double
    let tipo : Double
    let dateActual:Int
    let unperiodo:Int //cuantos datacuales tiene un periodo, ex, 31 dias tienen un periodo por pagar
    let periodosPorPagar : Int
}

func addToPortfolio(_ ps: [product]) -> State<portFolio,rHipotSample>  {
    
    return State{portf in
    
    let newPro = portf.products + ps
    let newSaldo = portf.saldo - 1000
    let newGaran = portf.garantias + 1000
    
    
    let newPort = portFolio(products: newPro, dateAct: portf.dateAct + 1, saldo: newSaldo, garantias: newGaran, PyGLantentes: 0, PYGRealizadas: 0)
    let res = rHipotSample(bookTrade: [resultsHipoSample.cash : -1000     ])
        
        return (res,newPort   )
        
         }
}

func closeAllPositions() -> State<portFolio,rHipotSample>  {
    
    
    return State {portf in
        
       
        let newSaldo = portf.saldo - 2000
        
        
        
        let newPort = portFolio(products: [], dateAct: portf.dateAct + 1, saldo: newSaldo, garantias: 0, PyGLantentes: 0, PYGRealizadas: -1000)
        let res = rHipotSample(bookTrade: [resultsHipoSample.cash : -1000     ])
        
        return (res,newPort   )
        
        
    }
    
    
    
}

// CFDSS ///////////////////////////////////////////////////////////////////////

func resultadoOfCfd( period: Int, ind: indHpotecSample) -> State<portFolio,rHipotSample> {
    
   return   State{ portf in  ( rHipotSample(bookTrade: [resultsHipoSample.cash : -1000]) , portf)}
}

















