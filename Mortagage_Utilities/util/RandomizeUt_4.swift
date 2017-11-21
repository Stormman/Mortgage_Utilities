//
//  RandomizeUt_4.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 21/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation

typealias  indexesAndVarAleatoria = [String : CompoundVAleatoria<doudouMetriz> ]

func IOGenerator(_ funcs :indexesAndVarAleatoria ) -> ((Int,Int  )) -> WaysOfIndexes? {
    return {tup in
    
     
        guard let xx = extraa <> funcs <> tup else {return nil}
        
        
         let waTor = WaysOfIndexes(ways: xx , nDays: tup.0, nSimul: tup.1)
        
        
        
    return waTor
    }
}

func extraa(_ infVar : indexesAndVarAleatoria) ->((Int,Int))-> waysOfInd? {
    
    
    return {tup in
    
        let k = Array(infVar.keys)
    
        
        let cadastringConsusdias = Array(0...k.count-1) <=> {_ in Array<Double>(repeatElement(1.00, count: tup.1))}
        
        let tot = cadastringConsusdias <=> {$0 <=> {_ in Array<Double>(repeatElement(1.00, count: tup.0))} }
        
        
        //let arrOfDa = arrayOfArr <=> {_ in Array<Double>(repeatElement(1.00, count: tup.1))}
    
        let b = creawaysConEstos(firs: k, sec: tot)
    
        return Optional<waysOfInd>(b)
        
    
    }
    
    
}

func compoundAleaDePrueba () -> CompoundVAleatoria<doudouMetriz> {
    
    let intervSingle2: [(Double,Double)] = [(-3,0.12),(-2,0.13),(-1,0.04),(1,0.06),(2,0.10),(3,0.14)    ]
    
     let f2 = CompoundVAleatoria__.concatenateIntervWtihLines(intervSingle2, stepm: 0.5)
    
    return  CompoundVAleatoria(funcs_: f2!)
    
}

func generByAleator_ ( _ varAlea: CompoundVAleatoria<doudouMetriz>) -> (Int) -> [Double] {
    
    return {nNum  in
        
        
        
        return Array<Double>(repeatElement(1.00, count: nNum ))
        
        
        
    }
    
    
    
    
}
