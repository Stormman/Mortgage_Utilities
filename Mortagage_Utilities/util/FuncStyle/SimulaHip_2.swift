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



// protocol SIMNExt //////......................   ITERATOR

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

// other iterator



protocol simALL  :Sequence {
    
   associatedtype A : ONESIMCONtrollerHIPO__
    
    var stopsAt : Int {get set }
    
    init( _ length : Int , _ clos : @escaping (Int) -> A )
    
    func makeIterator() -> AnyIterator<A>
    
    var  retDoubleInIteration : (Int) -> A {get set }
}

extension simALL  {
    func makeIterator() -> AnyIterator<A>{
        
        var interaCount = 0
        
        return AnyIterator {
            guard interaCount < self.stopsAt else {return nil}
            interaCount += 1
            return self.retDoubleInIteration(interaCount)
        }
    }
    
}


struct simulatSequences<AA : ONESIMCONtrollerHIPO__ > : simALL   {
   
    
    
    typealias A = AA
    
    var stopsAt: Int
    
    init( _ length : Int , _ clos : @escaping (Int) -> AA )  {
        
        stopsAt = length ; retDoubleInIteration = clos
    }
    
    
    
    var retDoubleInIteration: (Int) -> AA
}

//generic s ITERATORrrrr

protocol simALLGener  :Sequence {
    
    associatedtype A : ONESIMCONtrollerHIPO__
    
    var stopsAt : Int {get set }
    
    var element_ : A {get set }
    
    init( _ length : Int , _ clos : @escaping (A) -> A , _firstElement: A)
    
    func makeIterator() -> AnyIterator<A>
    
    var  retDoubleInIteration : (A) -> A {get set }
}

extension simALLGener  {
    func makeIterator() -> AnyIterator<A>{
        
        var interaCount = 0
        var elem : A = element_
 
        
        return AnyIterator {
            guard interaCount < self.stopsAt else {return nil}
            interaCount += 1
            
            let result = self.retDoubleInIteration(elem )
            
              elem = result
            
            return result
        }
    }
    
}
/*
struct simSequeGeneric <B : ONESIMCONtrollerHIPO__> : simALLGener {
    
     typealias A = B
    
    var stopsAt: Int
    var element_: B //initial element
    
    
    init(_ length: Int, _ clos: @escaping (B) -> B, _firstElement: B ) {
        
        self.stopsAt = length
        self.retDoubleInIteration = clos
        self.element_ = _firstElement
    }
    
    var retDoubleInIteration: (B) -> B {
        
        
        
    }
    
    
 
   
    
    
    
    
    
    
}

*/








//++++++++++++++++++++++++++++++++

    
func <=> <B> ( x: miPNext , f: @escaping (Double ) -> B ) -> [B] { return x.map(f)        }
func <=> <B> ( f: @escaping (Double ) -> B,x: miPNext  ) -> [B] { return x.map(f)         }
    

// totalSIMulation ////////
typealias  waysOfIndexes = [String : [Double]]




struct TotalSimulation <A : ONESIMCONtrollerHIPO__ > {
    
    let indexes : waysOfIndexes
    
    let contr : A
    
    let wayToINdexes : wayToInd
    
    typealias  wayToInd = (waysOfIndexes)->  (Int ) -> inde
   // let mapped = contr
   
    
    func totalSimul( _ nSims: Int ,_ OneSim : A, _ indexess_: waysOfIndexes ,_ ways: @escaping wayToInd) -> [A.RESU] {
        
        //contr.enumerated().
        
        //func simul (n:Int ,)
        
       let ind =  Array(1...nSims) <=> {    ways <> indexess_ <> $0 }
        
       // let re = ind.reduce(OneSim ) { (res, ind) -> A in
        
        //    res.NextALL(ind)
        
        
       // }
        
        let reArr = ind.reduce([OneSim ]) { (res: [A],indes : inde ) -> [A ] in
            
            res + [(res.last?.NextALL(indes))!]
            
            
            
        }
        
        
        let resultados = reArr <=> {$0.result }
        
        return resultados
        
    }
    
    
}









// //////////////////////////////////////////////////////////////////////

struct res {let cash : Double ; let garantias :Double ; let perdidasAcumuladas : Double ; let iterac : Int}
struct inde {let euribor : Double; let bono : Double; let eurodollar :Double    }

struct iDollar {let eurodoll : Double;let nIterac : Int}


struct iEuri {let euribor : Double;let nIterac : Int}
struct  dou {init(_ d : Double) { resulDoub = d};let resulDoub : Double}
struct douComp {let cash:Double;let garantiasFluj:Double }

/*func sumatorio(_ x:[res]) -> res {
 
 
 
 
}
*/



protocol funcNextt {
    
    associatedtype A
    associatedtype B
    associatedtype RES
    associatedtype IND
    
    func funcNext( _ a: A) -> B
    
    func toApplyToFuncNexts( _ x: RES) -> (IND) -> A
    
    
}


// / //////////////// funnext NEVOOOO
protocol funcNEXTT_ {
    
    associatedtype RES
    associatedtype IND
    associatedtype B
    
    func applyNEXT_( _ res: RES ) -> (IND) -> B
}

protocol ONESIMCONtroller_ {
    
    associatedtype RESU
    associatedtype INDE
    
    var  result : RESU {get set}
    var  indexx : INDE {get set }
    
    
    func nexttt() -> RESU
    
    func NextALL(_ indices: INDE) -> Self
    
    func NextALL() -> Self
    
   
    
    
}

protocol  funcNEXTTHIpo_ : funcNEXTT_ where RES == res , IND == inde{
    func applyNEXT_( _ res: res ) -> (inde) -> B
}
//erasure for funnexxxtHTTP

struct AnyfunNEXXTHIpo<BB> : funcNEXTT_ {
   
    typealias RES = res
    
    typealias IND = inde
    
    typealias B = BB
    
    private let _applyNEXT_: (res) -> (inde) -> BB
    
    init<U : funcNEXTT_>(_ funce : U  ) where U.RES == res, U.IND == inde, U.B == BB {
        
        _applyNEXT_ = funce.applyNEXT_
    }
    
    func applyNEXT_(_ res: res) -> (inde) -> BB {
        return _applyNEXT_(res)
    }
}




protocol ONESIMCONtrollerHIPO__ : ONESIMCONtroller_ where RESU == res, INDE == inde {
    
    var  result : res {get set}
    var  indexx : inde {get set}
    func nexttt() -> res //nuevo resultado
    
     func NextALL(_ indices: inde ) -> Self
    
    func NextALL() -> Self
    
    
}




struct ONESIMCOntr<B>  : ONESIMCONtrollerHIPO__ {
    
    
    
    
    var result : res
    var indexx : inde
    
    let arrFunc : [AnyfunNEXXTHIpo<B>]
    
    //
    let converResulIndividToAgregate : ([B ]) -> (res) -> res//hay que sumar uno a la iteracion
    
    
    func nexttt() -> res {
        
        // extraemos las salidas de todas las cunNExts
        
        let fu = arrFunc <=> {$0.applyNEXT_(self.result ) }
        
        let ff = fu <=> {$0 <> self.indexx}
        
        //trasladar cada salida de cada funcoi al resultado gwneral
        
        let toRet = converResulIndividToAgregate <> ff <> self.result
        
        return toRet
        
        
        
    }
    
    func NextALL(_ Proximosindices: inde) -> ONESIMCOntr {//preparado para la proxima iteracion
        
        let toRet = ONESIMCOntr(result: self.nexttt(), indexx:Proximosindices,arrFunc: self.arrFunc,converResulIndividToAgregate: self.converResulIndividToAgregate )
        
        return toRet
        
    }
    
    func NextALL() -> ONESIMCOntr {
        
        let toRet = ONESIMCOntr(result: self.nexttt(), indexx:indexx ,arrFunc: self.arrFunc,converResulIndividToAgregate: self.converResulIndividToAgregate )
        
        return toRet
        
        
        
    }
    
    
    
    
    
    
    
}




//    ///////////////////////////////////////////






//examples------------

let resEx = res(cash: 1000, garantias: 1000, perdidasAcumuladas: 10, iterac: 3)
let indeEx = inde(euribor: 1.45, bono: 100.23, eurodollar: 1.2345)






