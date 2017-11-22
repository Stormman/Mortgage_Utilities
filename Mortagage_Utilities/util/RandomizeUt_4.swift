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

func compoundvAleaTeste() -> CompoundVAleatoria<doudouMetriz> {
    
    let intervSingle2: [(Double,Double)] = [(-3,6),(-2,4),(-1,2),(1,3),(2,5),(3,7)    ]
    
   let f2 = CompoundVAleatoria__.concatenateIntervWtihLines(intervSingle2, stepm: 0.5)
    
    return CompoundVAleatoria(funcs_: f2!)
    
}

func generByAleator_ ( _ varAlea: CompoundVAleatoria<doudouMetriz>) -> (Int) -> [Double] {
    
    return {nNum  in
        
        
        
        let simplesAleatoriosde1a100 = Array(1...nNum) <=> {_ in simpleGenerations() <> 100}
        
        
        
        
        
        
        return Array<Double>(repeatElement(1.00, count: nNum ))
        
        
        
    }
    
    
    
    
}


func InvertFunction(_ f : doudouMetriz) -> funcDouToDouOp {
    
   
        
        
        
    func inverter ( val: Double, ff: funcDouToDOu, steps:Double, min: Double, bounds: (Double,Double)  )-> Double? {
        
        if(val < bounds.0){return nil}
        //if(val > bounds.1){return nil}
        
        
        if( min  < bounds.0 ) {return nil}
        if( min > bounds.1) {return nil}
        
        if ( ff(min) >= val) {
            return min
       } else {
            
            //if( min  > bounds.1) {return nil}
            
            return inverter(val: val , ff: ff , steps: steps , min: min  + steps ,bounds: bounds  )
        }}
        
    return {x in
        
        return inverter(val: x, ff: f.generat, steps: f.stepMinim, min: f.bounds.0, bounds: f.bounds)
        
        
    }
        
    
        
        
    
    
    
    
}




