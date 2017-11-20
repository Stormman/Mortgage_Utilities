//
//  RandomizeUt_3.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 16/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation

typealias   po = mathFunctions__.Point
//funcion generadora de funciones aleatorias
// los intervalos con [low, upb), [Low , up) ..... [..)
struct CompoundVAleatoria<FU: doubleGenerMetrizable>  {
    let funcs_ : [FU ]
}

final class CompoundVAleatoria__ {

    
    //funcion de densidad de probabilidad de un array de funciones, ya devuelve intervabilizada
    static func fde<FU :doubleGenerMetrizable>(_ funcs: [FU] ) -> ( Double) -> Double? {
        return {x in
            
        guard let ind = CompoundVAleatoria__.whatIvIs(x, funcs ) else {return nil }
        
        let fintevr =   CompoundVAleatoria__.funcintervabilizada(funcs[ind]) {($0+$1)/2}
        
        guard let toR = fintevr(x) else {return nil}
        
            return toR}
        
    }
    
    static func FBde<FU:doubleGenerMetrizable>(_ funcs: [FU],  _ x: Double) -> Double? {
        
        
        guard let ind = CompoundVAleatoria__.whatIvIs(x, funcs ) else {return nil }
        
        
        //let fdbb = obtainFDBOfMemoize(funcs[ind])
        
        //let fdbb = obtainFDBOf(funcs[ind])
        
        let fdbb = obtainFDBofFuncss(funcs)
        
        return fdbb(x)
        
        
        
    }
    
    //********************
    
    static func whatIvIs<MET : metrizable>( _ x: Double ,_ arrMEt : [MET] )-> Int?  {
        
        guard let las = arrMEt.last else {return nil}
        
        if (x == las.bounds.1) {return arrMEt.count - 1 } // si es el ultimo valor del ultimo intervalo queda dentro de la funcion
        
        
        guard   let el = arrMEt.index(
            where: { ((x >= $0.bounds.0 ) && ( x < $0.bounds.1   )     )    })
            else {return nil }
        return el
        
        
    }

    
    // pasa una funcion matematica a metrizada,o a intervalos
    // g nos da que valor cogemos de ambos del intervalo
    static func funcintervabilizada<FM : doubleGenerMetrizable> (_ x : FM , _ g :@escaping  ((Double,Double )) -> Double ) ->  (Double) -> Double? {
        
        return {xn in
            
            guard let intervaloDondeesta_xn = localizableDoubleInMetric(xn, x) else {return nil }
            
            return g((x.generat(intervaloDondeesta_xn.lowBound), x.generat(intervaloDondeesta_xn.upBound)))
            
            
    }}
    
    
    //++++++++++++++++++++++++
    
    //convierte una funcion matematica en metrizable
    
    static func metrizarfuncionmatematica( _ f:@escaping funcDouToDOu , stepm: Double, upBounds: Double, lowBounds:Double) -> doudouMetriz {
        return doudouMetriz(stepMinim: stepm, bounds: (lowBounds,upBounds), generat: f)
        }
    
    
    
    // convierte una secuencia de nuemros, q son intervalos, y una secuencia de densidades que son lineas en una aleatoria
    // ejemplo: [1,3,5,70,90 ] -> [iv(1,3) , iv(3,5) , iv(5,70) ,iv(70,90)  ] y las imagenes por otro lado [f(1), f(3),f(5), f(70) f(90)]
    //intervsingles son el iniciodel intervalo y su imagen de la funcion de densidd deseaada
    
    //intervSingleadnImages = tuples donde el primer elemento es el inicio del intervalo y su valor en la f de densidad de la var aleatoria
    
    static func concatenateIntervWtihLines(_ intervSinglesandImages : [(Double,Double )], stepm: Double )-> [doudouMetriz ]? {
        
        
        guard intervSinglesandImages.count > 1 else {return nil}
        
        let images_Of_Funciotns_Density_Desired = intervSinglesandImages <=> {$0.1}
        
        guard  let intervalos_Tuplas = CompoundVAleatoria__.numerosToIntervalosTuples((intervSinglesandImages <=> {$0.0}) ) else {return nil }
        
        let arrBase = Array(0...intervalos_Tuplas.count - 1 )
        
       let iamgesOfEachInter = arrBase <=> {(images_Of_Funciotns_Density_Desired[$0], images_Of_Funciotns_Density_Desired[$0 + 1]    )        }
        
        let points_to_make_lines = arrBase <=> {(po(x: intervalos_Tuplas[$0].0, y: iamgesOfEachInter[$0].0),po(x: intervalos_Tuplas[$0].1, y: iamgesOfEachInter[$0].1)                                          )}
        
        let funciones_de_cada_intervalo = arrBase <=> {mathFunctions__.curve(.line, points_to_make_lines[$0].0, points_to_make_lines[$0].1)}
        
        let funciones_Metrizadas = funciones_de_cada_intervalo.enumerated().map {metrizarfuncionmatematica($1, stepm: stepm, upBounds:intervalos_Tuplas[$0].1 , lowBounds:intervalos_Tuplas[$0].0 )}
        
        return funciones_Metrizadas
        
    }
    
    
    
    // convierte una secuencia de numeros en secuencia de intervalos tuplas del tipo [1,3) [3,5) [5,12) ....
    
    static func numerosToIntervalosTuples( _ sec: [Double]) -> [(Double,Double)]? {
        
        guard sec.count > 1 else {return nil  }
        
        let conv = Array(0...sec.count-2)
            
        
        let interv = conv.map{(sec[$0], sec[$0+1])}
        
        return interv
        
        
        }
        
        
        
        
    }
    
    

    
    
    
    


