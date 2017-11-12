//
//  SimulaHip_2.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 5/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation



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
//typealias  waysOfIndexes = [String : [Double]]


 typealias  wayToInd = (WaysOfIndexes)->  (Int ) -> (Int)-> inde // Nsimumlac -> nDia ...

struct TotalSimulation <A : ONESIMCONtrollerHIPO__ > {
    
    let indexes : WaysOfIndexes
    
    let contr : A
    
    //let wayToINdexes : wayToInd
    
   
   // let mapped = contr
   
    
   
    
}

func SimulateinN_ <A:ONESIMCONtrollerHIPO__,B:IndexGenDictionableHipo >( _ NSims : Int, _ nDays: Int ,  _ OneSim : A, _ ways: B) -> [A.RESU]  where B.A == B {
    
    let indicesEnSimulacionYDiaTal = GEnerateIndexes__ <> ways
    
    //Each one ------------
    
    let indicesCadaDiaEnSimulDada =  Array(1...nDays) <=> {  indicesEnSimulacionYDiaTal <> NSims <> $0    }
    
    let reArr = indicesCadaDiaEnSimulDada.reduce([OneSim ]) { (res: [A],indes : indHpotecSample) -> [A ] in
        
        res + [(res.last?.NextALL(indes))!]}
    
    let resultados = reArr <=> {$0.result }
    
    // each one-------------
    
    
    return resultados
    
}

func totalSims <A:ONESIMCONtrollerHIPO__,B:IndexGenDictionableHipo >(OneSim : A, _ ways: B, days : Int, Simulaciones: Int ) -> [[A.RESU]] where B.A == B  {
    
    
    let resultadosEnCadaSimulacion = Array(1...Simulaciones) <=> {SimulateinN_($0, days , OneSim, ways)}
    
    return resultadosEnCadaSimulacion
    
    
    
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
    
    associatedtype RES : DictionableResultable
    associatedtype IND : DictionableResultable
    associatedtype B
    
    func applyNEXT_( _ res: RES ) -> (IND) -> B
}

protocol ONESIMCONtroller_ {
    
    associatedtype RESU : DictionableResultable
    associatedtype INDE : DictionableResultable
    
    var  result : RESU {get set}
    var  indexx : INDE {get set }
    
    
    func nexttt() -> RESU
    
    func NextALL(_ indices: INDE) -> Self
    
    func NextALL() -> Self
    
   
    
    
}

protocol  funcNEXTTHIpo_ : funcNEXTT_ where RES == rHipotSample , IND == indHpotecSample{
    func applyNEXT_( _ res: rHipotSample ) -> (indHpotecSample) -> B
}
//erasure for funnexxxtHTTP

struct AnyfunNEXXTHIpo<BB> : funcNEXTT_ {
   
    typealias RES = rHipotSample
    
    typealias IND = indHpotecSample
    
    typealias B = BB
    
    private let _applyNEXT_: (rHipotSample) -> (indHpotecSample) -> BB
    
    init<U : funcNEXTT_>(_ funce : U  ) where U.RES == rHipotSample, U.IND == indHpotecSample, U.B == BB {
        
        _applyNEXT_ = funce.applyNEXT_
    }
    
    func applyNEXT_(_ res: rHipotSample) -> (indHpotecSample) -> BB {
        return _applyNEXT_(res)
    }
}




protocol ONESIMCONtrollerHIPO__ : ONESIMCONtroller_ where RESU == rHipotSample, INDE == indHpotecSample {
    
    var  result : rHipotSample {get set}
    var  indexx : indHpotecSample {get set}
    func nexttt() -> rHipotSample //nuevo resultado
    
     func NextALL(_ indices: indHpotecSample ) -> Self
    
    func NextALL() -> Self
    
    
}




struct ONESIMCOntr<B>  : ONESIMCONtrollerHIPO__ {
    
    
    
    
    var result : rHipotSample
    var indexx : indHpotecSample
    
    let arrFunc : [AnyfunNEXXTHIpo<B>]
    
    //
    let converResulIndividToAgregate : ([B ]) -> (rHipotSample) -> rHipotSample//hay que sumar uno a la iteracion
    
    
    func nexttt() -> rHipotSample {
        
        // extraemos las salidas de todas las cunNExts
        
        let fu = arrFunc <=> {$0.applyNEXT_(self.result ) }
        
        let ff = fu <=> {$0 <> self.indexx}
        
        //trasladar cada salida de cada funcoi al resultado gwneral
        
        let toRet = converResulIndividToAgregate <> ff <> self.result
        
        return toRet
        
        
        
    }
    
    func NextALL(_ Proximosindices: indHpotecSample) -> ONESIMCOntr {//preparado para la proxima iteracion
        
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






