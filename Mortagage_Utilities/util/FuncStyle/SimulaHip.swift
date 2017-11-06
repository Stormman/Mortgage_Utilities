//
//  SimulaHip.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 5/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation

func generIntInts ( ix : Int  ) -> (Int) -> Double {return {return Double($0) * Double(ix)}}










let arrayDeNumeros = Array(1...100)


typealias  funcIntToDouble = (Int) -> Double

typealias  estadisticoFunction = ([Double]) -> Double

typealias  transfDouble = (Double) -> Double

//estadisticos

func mean(args : [Double]) -> Double {let sum = args.reduce(0, +);return Double(sum) / Double(args.count)}

func Var(args: [Double]) -> Double {
    
    let mea = mean(args: args)
    let pow : transfDouble  = { return $0 * $0}
    let diferCuadrados = args <> map{ $0 - mea} <> map (pow)
    return diferCuadrados.reduce(0,+) / Double(args.count)
}

func desvTip(args:[Double]) -> Double {return sqrt(Var(args: args))}




//

func generaDoubleEnElPeriodo(_ n : Int) -> (funcIntToDouble ) -> Double {
    
    return {xs in return xs(n)}}



let arrpo = arrayDeNumeros <> take(30)

let arrdefunctionsInts = arrpo <> map(  generIntInts )



let curroAhora = generaDoubleEnElPeriodo(12)

let otraSimul = arrayDeNumeros <> take(100) <> map(generIntInts) <> map (curroAhora)




func generateSamplesOfFuncIntToDou (_ n: Int) -> [funcIntToDouble] {return Array(1...n) <> map(generIntInts)}

let sampleFuncArray = generateSamplesOfFuncIntToDou(20)



let simula3 = sampleFuncArray <> map( generaDoubleEnElPeriodo(10)  )

//let fGen :generatorsOfSimul = generatorsOfSimul(functionsOf: generateSamplesOfFuncIntToDou(20), estadisitcos: [mean,desvTip])

//let simu1 = fGen.simulateIn(2)

//let simul3 = fGen.simulateIn(20)



struct generatorsOfSimul {
    
    let functionsOf : [funcIntToDouble]
    
    let estadisitcos :[estadisticoFunction]
    
    //let indexes : [ String : Double]
    
    //let dictIndexes : [ String : [Double]   ]
    
    
    func simulateIn (_ n :Int) -> Double {
        
        let arrayTo = self.functionsOf <> map(generaDoubleEnElPeriodo(n))
        
        return arrayTo.reduce(0, +)
        
        
    }
    
    func SimulatiosTotal() -> [Double] {
        
        
        let simulatTotal : [[Double]]
        
        return [0]
        
        
    }
    
    
    
    
}

// constructor curried
func simulacionDe( _ fs: [funcIntToDouble]) -> ([estadisticoFunction]) -> generatorsOfSimul {
    return { estd in generatorsOfSimul(functionsOf: fs, estadisitcos: estd)}
}

//shorts to members
 let simulatIn = generatorsOfSimul.simulateIn


