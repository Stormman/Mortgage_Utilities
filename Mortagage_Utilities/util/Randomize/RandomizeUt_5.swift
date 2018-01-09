//
//  RandomizeUt_5.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 5/1/18.
//  Copyright © 2018 Antonio Muñoz. All rights reserved.
//

import Foundation


// FACTORY VALEATORIAS------------------

enum slopeVelocity {case verySlow;case slow; case normal; case fast;case veryFast}

enum typesOfVarAleatoria {
    case uniform(metroSimpleWithFunc);
    case upping(metroSimpleWithFunc,slopeVelocity);
    case downing(metroSimpleWithFunc,slopeVelocity);
    case bell(      interval)}
/*
func factoryVAleatoria (_ typeOf: typesOfVarAleatoria ) -> CompoundVAleatoria<doudouMetriz> {
    
    switch(typeOf) {
        
        
    case .uniform(let met ):
        
        
        
    break
    case .upping(let met, let veloc):
        
        
        
        break
    case .downing(let met, let veloc):
        
        break
    case .bell(let inter):
        
        
        break
        
        
        
    }
    
    
    
}
*/


func indexesAndVarAleasOfPrueba(_ indexes:[String] , _ diasSim:(Int,Int))-> WaysOfIndexes {
    
    let intervSingle2: [(Double,Double)] = [(-3,0.12),(-2,0.13),(-1,0.04),(1,0.06),(2,0.10),(3,0.14)    ]
    
     let f2 = CompoundVAleatoria__.concatenateIntervWtihLines(intervSingle2, stepm: 0.5)
    
    let funcs = CompoundVAleatoria(funcs_: f2!)
    
    
    
    
    let arrFuncs = Array<CompoundVAleatoria<doudouMetriz>>.init(repeating: funcs, count: indexes.count)
    
    let indAdnVar = CreaDictionaryCOnEStosArrays(fir: indexes, sec: arrFuncs)
    
    
    return (IOGenerator <&> indAdnVar <&> diasSim)!
    
    
    
    
}









//--------------------------------------
