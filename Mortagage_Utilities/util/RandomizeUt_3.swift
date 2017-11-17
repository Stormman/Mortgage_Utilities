//
//  RandomizeUt_3.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 16/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation


//funcion generadora de funciones aleatorias
// los intervalos con [low, upb), [Low , up) ..... [..)
struct CompoundVAleatoria<FU: doubleGenerMetrizable>  {
    
    
    let funcs : [FU ]
    
    func fde( _ x: Double) -> Double? {
        
        guard let ind = CompVAleatoria.whatIvIs(x, funcs ) else {return nil }
        
        return  funcs[ind].generat <> x
        
        
        
    }
    
    
    
    
    
    
}

final class CompVAleatoria {

   

    static func whatIvIs<MET : metrizable>( _ x: Double ,_ arrMEt : [MET] )-> Int?  {
        
        guard   let el = arrMEt.index(
            where: { ((x >= $0.bounds.0 ) && ( x < $0.bounds.1   )     )    })
            else {return nil }
        return el
        
        
    }

     

}

