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
    
        
        let toRet = infVar.mapValues{ (generByAleatorLists <> $0 <> tup.0 <> tup.1)!        }
        
    
        
        return toRet
        
    
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

func generByAleator_ ( _ varAlea: CompoundVAleatoria<doudouMetriz>) -> (Int) -> [Double]? {
    
    return {nNum  in
        let simplesAleatoriosde1a100 = Array(1...nNum) <=> {_ in Double(simpleGenerations() <> 100)}
        guard  let inver = InvertFunctionOp(varAlea) else {return nil}
        let simplesAleatajustadosAlafunc = simplesAleatoriosde1a100 <=> {$0 / 100}
        let re = simplesAleatajustadosAlafunc <=>  inver
        let sre = re.flatMap{$0}
       // print("aleatorio ......")
        
        return sre}
}

func generByAleatorLists(_ varAlea : CompoundVAleatoria<doudouMetriz>) -> (Int) -> (Int)-> [[Double]]? {
    return { nDias in { nSmus in
        let f = arrayOfOrdeneredZEroIndex(nSmus) <=> {_ in (generByAleator_ <> varAlea <> nDias)!  }
        
        // print("aleatorio list -------------------------")
        return f
    }}}





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

func InvertFunctionOp<FU:doubleGenerMetrizable>(_ f:CompoundVAleatoria<FU>) -> funcDouToDouOp? {
    
    
    guard let met = CompoundVAleatoria__.obtainMetricaAllFuncTogether(f) else {return nil}
    
    func inverter ( val: Double, ff: funcDouToDouOp, steps:Double, min: Double, bounds: (Double,Double)  )-> Double? {
        
        if(val < bounds.0){return nil}
        //if(val > bounds.1){return nil}
        
        
        if( min  < bounds.0 ) {return nil}
        if( min > bounds.1) {return nil}
        
        guard let fmi = ff(min) else {return nil}
        
        if ( fmi >= val) {
            return min
        } else {
            
            //if( min  > bounds.1) {return nil}
            
            return inverter(val: val , ff: ff , steps: steps , min: min  + steps ,bounds: bounds  )
        }}
   
    return {x in
        
        let fToDb = CompoundVAleatoria__.FBdec(f)
        
        return inverter(val: x, ff: fToDb , steps: met.stepMinim, min:met.bounds.0, bounds:(met.bounds.0, met.bounds.1))
        
        
    }
    
    
}


