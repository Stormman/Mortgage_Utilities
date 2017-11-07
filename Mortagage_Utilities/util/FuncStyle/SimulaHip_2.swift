//
//  SimulaHip_2.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 5/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation

typealias waysOfInd = [String : [[Double]]]

struct WaysOfIndexes {
    
    let ways : waysOfInd
    
    let nDays : Int
    
    let nSimul : Int
    
    func proof() -> WaysOfIndexes {
        
        let waExamp : waysOfInd = [ "Euribor" :
            [ [12,13,14,15,16,17,20,24,25,29,30,31],
              [13,15,18,20,22,23,22,21,22,19,16,14],
              [14,17,20,23,24,25,21,23,24,29,30,33]
            
            ]     ]
        
        
        return WaysOfIndexes(ways: waExamp, nDays: 3, nSimul: 12)
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
}

//seqSImul ///////////////////////////////////////////////////////////////

class  SeqSimul : Sequence {
    
    //func intToDouD ( dict :[String:Double], )
    let stopsAt : Int
    
    init( _ length : Int) {stopsAt = length}
    
    func makeIterator() -> AnyIterator<Double>  {
        
        var interaCount = 0
        
        return AnyIterator {
            
            guard interaCount < self.stopsAt else {return nil}
            
            interaCount += 1
            
            return Double(interaCount)
            
            
            
        }
        
        
    }
    
    
    
    
}
func <=> <B> ( x: SeqSimul , f: @escaping (Double ) -> B ) -> [B] { return x.map(f)        }
func <=> <B> ( f: @escaping (Double ) -> B,x: SeqSimul  ) -> [B] { return x.map(f)         }



// protocol SIMNExt //////////////////////////////////////////////////////////

protocol simNext :Sequence {
    
    var stopsAt : Int {get set }
    
    init( _ length : Int , _ clos : @escaping funcIntToDoub)
    
    func makeIterator() -> AnyIterator<Double>
    
    
    var  retDoubleInIteration : funcIntToDoub {get set }
    
    
}

extension simNext {
    
 
    func makeIterator() -> AnyIterator<Double>{
        
        var interaCount = 0
        
        return AnyIterator {
            
            guard interaCount < self.stopsAt else {return nil}
            
            interaCount += 1
            
            
            
            
            return self.retDoubleInIteration(interaCount)
            
            
            
        }
        
        
    }
        
        
        
    }
    

struct miPNext : simNext {
    
    init(_ length: Int, _ clos: @escaping (Int) -> Double) {
        
        stopsAt = length
        retDoubleInIteration = clos
        
        
    }
    
   
  
    
    var retDoubleInIteration: funcIntToDoub
    
    var   stopsAt: Int
    
    
    
    
    
    
}
    
func <=> <B> ( x: miPNext , f: @escaping (Double ) -> B ) -> [B] { return x.map(f)        }
func <=> <B> ( f: @escaping (Double ) -> B,x: miPNext  ) -> [B] { return x.map(f)         }
    

// //////////////////////////////////////////////////////////////////////

protocol funcNextt {
    
    associatedtype A
    associatedtype B
    
    func funcNext( _ a: A) -> B
    
    
    
    
}

protocol toApplyFunNextsss {
    
    associatedtype RES
    associatedtype IND
    associatedtype TOAPPTONEXTS
    
    func toApplyToFuncNexts( _ x: RES) -> (IND) -> TOAPPTONEXTS
    
    
}


struct fff  : funcNextt{

     typealias  A = iEuri
    typealias B  = dou
    
    func funcNext( _ a: iEuri) -> dou {
        
        
        return dou( (a.euribor / 100) + Double(a.nIterac))
        
        
    }
    
    
        
}

struct ggg : funcNextt {
    
    typealias A = iDollar
    typealias B = dou
    
    func funcNext(_ a: iDollar   ) -> dou    {
        
        return dou(a.eurodoll + Double(a.nIterac))
    }
    
    
    
    
}
struct iDollar {
    
    let eurodoll : Double
    let nIterac : Int
    
    
}


struct iEuri {
    
    let euribor : Double
    let nIterac : Int
    
    
}
struct  dou {
    
    init(_ d : Double) { resulDoub = d}
    
    let resulDoub : Double
    
    
    
}

let gpo = fff.funcNext

//-----------



//ejemplo de resultados e indexes

struct res {let cash : Double ; let garantias :Double ; let perdidasAcumuladas : Double ; let iterac : Int}
struct inde {let euribor : Double; let bono : Double; let eurodollar :Double    }



//func toApplyToFunctions<RESUL ,INDEXes,B> ( x: RESUL  ) -> (INDEXes)->  B {}








func toApplyToFuncNexts( x: res) -> (inde) -> iEuri {
    
    return {indexess in iEuri( euribor : indexess.euribor, nIterac: x.iterac )  }
}
func toApplyToFuncNexts( x: res) -> (inde) -> iDollar {
    
    return {indexess in iDollar(eurodoll : indexess.eurodollar , nIterac: x.iterac) }
}

//.........

let resEx = res(cash: 1000, garantias: 1000, perdidasAcumuladas: 10, iterac: 3)
let indeEx = inde(euribor: 1.45, bono: 100.23, eurodollar: 1.2345)

/*

let oook = fff() <> gpo
let kkkko = ggg() <> ggg.funcNext


let jjjnnd = oook <> (toApplyToFuncNexts <> resEx <> indeEx)
let otrojj = kkkko <> (toApplyToFuncNexts <> resEx <> indeEx)
*/

//--------------------------------------------------


protocol controllerSim {
    
    associatedtype B: funcNextt
    
    associatedtype RESULTS
    associatedtype INDEXES
    
    func nexttt(x : [B] ) -> RESULTS
    
   // func descriptorMake(x:[E]  ) -> RESULTS
    
    
    
    
    
}

struct controll<BB: funcNextt > : controllerSim{
    
    typealias B = BB
    typealias RESULTS = res
    typealias INDEXES = inde
    
    func nexttt(x: [BB]) -> res {
        
       // x.map{_ in toApplyToFuncNexts <> res <> inde       }
        
    }
    
    
}







