//
//  RandomizeUt.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 1/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation
enum tipoGener { case simple; case booleano}

func SampleRandomGenerator( ) -> (Double ) -> Bool {
    
    
    
    return { prob1 in
        
        let rand = Int(arc4random_uniform(10000))
        
        let pr = Int(prob1 * 10000)
        
        let toR = (pr > rand) ?   true : false
        
        return toR
        
        
        
        
    }
    
}

func simpleGenerations() -> ( Int ) -> Int {
    
    return {bet in
        Int(arc4random_uniform(UInt32(bet)))}
    
    
    
}



protocol metrizable {
    
    
    
    
    
    var  stepMinim : Double {get}
    var   bounds : (Double,Double) {get}
    
}

protocol doubleGenerator {
    
    
    var generat :(Double) -> Double {get}
    
    
    
}

struct   interval  {
    
    var lowBound : Double
    
    
    var upBound : Double
    
    
    
    
}

extension interval : Hashable  {
    
    
    var hashValue : Int {
        
        
        return lowBound.hashValue ^ upBound.hashValue &* 16777619
        
    }
    
    
    static func == (lhs: interval  , rhs: interval    )-> Bool  {
        
        return lhs.lowBound == rhs.lowBound && rhs.upBound == lhs.upBound
        
        
    }
    
    
}




let arrayOfEmpties : (Int) -> Array<Double> = { n in return    Array<Double>(repeating: 0, count: n)       }
let arrayOfOrdered : (Int) -> Array<Int> = { n in return Array(1...n) }
let arrayOfOrdeneredZEroIndex : (Int) -> Array<Int> = { n in return Array(0...(n-1)) }


typealias funcIntToDoub = (Int) -> Double
typealias funcDouToDOu  = (Double) -> Double
typealias funcDouToDouOp = (Double) -> Double?

let funcToExaple : funcDouToDOu = { dou in  if (dou < 5 ) {  return 0.05 } ;if ((dou >=  5) && (dou <= 10) ) {  return 0.09 };if (dou >= 10 ) {  return 0.03 }  ; return  0  }

typealias   doubleGenerMetrizable = doubleGenerator & metrizable


struct varAleatoria : doubleGenerMetrizable {
    
    init( descrip: String, step: Double, boundss : (Double,Double), generato :@escaping funcDouToDOu    ) {
        
        descriptXAxis = descrip
        stepMinim = step
        bounds = boundss
        
        
        generat = generato
        
        fDb = nil
        
        pinit()
        
    }
    
    mutating func pinit() {fDb = obtainFDBOf(self) }
    
    
    let descriptXAxis : String// ejemplo, cuanto sube en un dia,
    
    let stepMinim  : Double
    
    let bounds : (Double,Double )
    
    let generat: (Double) -> Double
    
    var  fDb : ((Double) -> Double)?
    
    
    
    
}

func checkVarAlea(varAle : varAleatoria)-> Double?   {
    
    
    let generator = varAle.generat
    let trans : (interval) -> Double  = {inter in inter.lowBound     }
    let interSum : (interval , Double, Double) -> Double = {inter , steps , fx in
        
        let stepsTotales = Int( (inter.upBound - inter.lowBound) / steps)
        
        
        let sumaInter = arrayOfOrdeneredZEroIndex(stepsTotales) <> map{r in fx} <> reduce(0,+)
        return sumaInter
        
        
    }
    
    guard  let st = intervalosMetricos(metri: varAle) else {return nil  }
    
    
    let stint : [interval] = Array(st.dicMetr.keys)
    
    let stepsTot = Int((stint.first!.upBound -  stint.first!.lowBound)/varAle.stepMinim)
    
    
    
    let ff = stint <> map(trans) <> map(generator)
    
    
    
    let prtt = ff <> map {$0 * Double(stepsTot) } <> reduce (0,+)
    
    
    
    return prtt
    
    
}


func obtainFDBOf< A>(_ valea : A) -> funcDouToDOu where A: doubleGenerMetrizable  {
    
    return { gener in
        
        let pasosNece: Int? = stepsNeceseToArrive(valea, gener)
        
        
        
        if (pasosNece == nil) {return 0}
        
        if(pasosNece == 0) { return valea.generat(valea.bounds.0)    }
        assert(pasosNece != 0, "zero")
        
        
        let mapped = arrayOfOrdeneredZEroIndex(pasosNece!) <> map{ (Double($0) * valea.stepMinim) + valea.bounds.0 }
        
        let mapped2 = mapped <> map{ valea.generat($0)}
        
        let acum = mapped2 <> reduce(0,+)
        
        return acum
        
        
    }
    
    
    
    
}


func stepsNeceseToArrive<A: metrizable> ( _ valu: A, _ valorTo : Double ) -> Int? {
    
    let bounsMin = valu.bounds.0
    
    let bounsMax = valu.bounds.1
    
    
    if (bounsMin >= bounsMax) {return nil}
    if (valorTo > bounsMax) {return nil}
    if( valorTo < bounsMin) {return nil}
    
    let dife = valorTo - bounsMin
    
    let pasosTo = dife / valu.stepMinim
    
    return Int(pasosTo)
    
    
    
    
    
    
    
    
    
    
}


protocol invertible: doubleGenerMetrizable {
    
    
    
    
    
    
    func inversefun(_ finv: Double ) ->Double
}

extension invertible {
    
    func inversefun(_ finv : Double) -> Double {
        
      
        
        func inverter ( val: Double, ff: funcDouToDOu, steps:Double, min: Double )-> Double {
            
           
            
            
            if ( ff(min) >= val) {return min   } else { return inverter(val: val , ff: ff , steps: steps , min: min  + steps )            }
            
            
            
        }
        
        
        
        return inverter(val: finv , ff: generat, steps: stepMinim    , min: bounds.0)
        
        
    }
    
}
struct invv: invertible {
    
    var generat: (Double) -> Double
    
    var stepMinim: Double
    
    var bounds: (Double, Double)
    
    
}

let gener = SampleRandomGenerator()
let numeroR = gener(0.56)


struct waysOfIO {
    
    
    let elements : Int
    
    let vAlea: varAleatoria
    
    let indexStarter : Double
    
    ///////
    
    
    
    
    static func proof() -> waysOfIO {
        
        let funcToExaple_ : funcDouToDOu = { dou in  if (dou < -2 ) {  return 0.01 } ;if ((dou >=  -2) && (dou <= 2) ) {  return 0.04 };if (dou >= 2 ) {  return 0.1 }  ; return  0  }
        
        let va = varAleatoria(descrip: "rentabilidad", step: 0.25, boundss: (-3,3), generato: funcToExaple_)
        
        
        
        
        let w = waysOfIO(elements: 100, vAlea: va, indexStarter: 21.00)
        
        return w
        
    }
    
    func generateTheWayValues () -> [Double] {
        
        
        let relatWithIndex : (Double) -> (Double) -> Double = { mult in return { idx  in idx * ((mult / 100) + 1)      }}
        
        
        var arr : [Double] = []
        
        let fR = simpleGenerations()
        
        let invert =  invv(generat: vAlea.fDb!, stepMinim: vAlea.stepMinim, bounds: vAlea.bounds).inversefun
        
        
        let m = arrayOfEmpties(elements) <> map{(Double(fR(1000))/1000) + $0} <> map{  invert($0)    }
        
        //let res = m <> reduce(self.indexStarter) {  relatWithIndex($0)($1)   }
       /*
        let retTo: [Double] = m.reduce(into: []) { arrAcum , elem in
            
            let last = arrAcum.last ?? indexStarter
            let to = relatWithIndex(elem  )(last  )
            arrAcum.append(to) }
            return retTo
        }
    */
        
        
       // let retTo = m.reduceConcatInArray( indexStarter)  { elem , last in   last * ((elem / 100) + 1)   }
    
        let retTo = m.reduceConcatInArray(indexStarter,  porcentAddable )
        
        
    return retTo
    
    
    
    
    
}

}




