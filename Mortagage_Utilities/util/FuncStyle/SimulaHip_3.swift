//
//  SimulaHip_3.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 10/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation
protocol strEnumer{}

typealias waysOfInd = [String : [[Double]]]
typealias wayConcrete = Dictionary<String, Optional<Double>>
typealias wayenumerStr = Dictionary< indexesHipoSample, Optional<Double>>
typealias resultsEnumStr = Dictionary< resultsHipoSample, Optional<Double>>


protocol DictionableResultable{
    
    associatedtype A : RawRepresentable, Hashable where A.RawValue == String
    
    var bookTrade : Dictionary< A, Optional<Double>> {get}
    
    
}
protocol DictionableToStadisticar {
    
    associatedtype A : RawRepresentable, Hashable where A.RawValue == String
    
    var bookTrade : Dictionary< A, Array<Optional<Double>>> {get set }
    
   // init(_ bk: Dictionary< A, Array<Optional<Double>>>)

    
    
}

struct DictioToStd< C :Hashable & RawRepresentable>  where C.RawValue == String {
   
    init(_ bookTrade_ :Dictionary< C, Array<Optional<Double>>>) {
        
        bookTrade = bookTrade_
        
    }
    
    init() {
        
        
        bookTrade = Dictionary< C, Array<Optional<Double>>>()
        
    }
    
    func identity() -> DictioToStd {
        
        let t = self.bookTrade.mapValues{_ in Array<Optional<Double>>()}
        //let dic = Dictionary(t , uniquingKeysWith: {(f,s) in f })
        //return DictioToStd(dic)
        
        return DictioToStd(t)
    }
    
    var bookTrade : Dictionary< C, Array<Optional<Double>>>
    
    
}




func ++++ < A:DictionableResultable , B:DictionableResultable > ( first:  A,second: B ) -> DictioToStd<A.A>   where A.A == B.A {
    
    typealias dcitRes = Dictionary<A.A,Array<Optional<Double>>>
    
    let t = [first.bookTrade, second.bookTrade]
    
    let todaslospares = (t <==> {$0.map{($0,$1)}}) .flatMap{$0}
    
    let po = todaslospares <==> {($0,[$1])}
        
    let dictT = Dictionary(po, uniquingKeysWith: {(f,s) in f + s         })
    
    return DictioToStd( dictT)
    
    
}

func ++++ < A:DictionableResultable  > ( first:  A,second: DictioToStd<A.A> ) -> DictioToStd<A.A>    {
    
    typealias dcitRes = Dictionary<A.A,Array<Optional<Double>>>
    
    
    
    
    let bookSec = second.bookTrade
    
    let gg = first.bookTrade.map(){ (k:A.A , v:Optional<Double>) -> (A.A, Array<Optional<Double>>) in
        
        if (bookSec.index(forKey: k) != nil) { return ( k, [v] + bookSec[k]!)          }  else {
            
            
            
            
            return (k,[v])
            
        }
        
    }
    
   
    
  
    let dict = Dictionary(gg, uniquingKeysWith:{ (f,_)  in f} )
   
    
    
    
    
    
    return DictioToStd( dict)
    
    
    
    
    
    
    
}




func ++++ <A> ( first: DictioToStd<A>, second : DictioToStd<A>  )-> DictioToStd<A>  {
    
    let di = first.bookTrade.merging(second.bookTrade, uniquingKeysWith: {$0 + $1})
    
    return DictioToStd<A>(di)
    
    
}






struct rHipotSample : DictionableResultable {
    
    
    var bookTrade : Dictionary< resultsHipoSample, Optional<Double>>
    
}
func + (f:rHipotSample, sec:rHipotSample) -> rHipotSample {
    
    
    let newDic = f.bookTrade.mapWithKey { (r1 : resultsHipoSample, dou: Optional<Double>) -> Optional<Double>  in
        
        guard let d = dou else {return nil}
        guard let otrod = sec.bookTrade[r1] else {return nil}
        
        
        let newd = d + otrod!
        
        return newd
        
        
        
    }
    
    return rHipotSample(bookTrade: newDic)
    
    
}


struct indHpotecSample : DictionableResultable {
    
    var bookTrade : Dictionary< indexesHipoSample, Optional<Double>>
    
    
}


enum resultsHipoSample: String   {
    
    case beneficios = "Beneficios"
    case cash = "Cash"
    case garantias = "Garantias"
    case perdidasAcumuladas = "Perdidas Acumuladas"
    
    
    
}
enum indexesHipoSample : String {
    
    case euribor1año = "Euribor 1 año"
    case bono10Esp = "Bono 10 Esp"
    case eurodollar = "EuroDollar"
    
    
}

// WAYS OF INDEXES +++++++++++++++++++++++++++++++++++++++++

struct WaysOfIndexes {
    
    let ways : waysOfInd
    
    let nDays : Int
    
    let nSimul : Int
    
   static  func proof() -> WaysOfIndexes {
        
        let waExamp : waysOfInd = [ "Euribor1año" :
            [ [0.11,0.13,0.14,0.15,0.16,0.17,0.20,0.24,0.25,0.29,0.30,0.31],
              [0.13,0.15,0.18,0.20,0.22,0.23,0.22,0.21,0.22,0.19,0.16,0.14],
              [0.14,0.17,0.20,0.23,0.24,0.25,0.21,0.23,0.24,0.29,0.30,0.33]
                
            ]   , "EuroDollar" :
                [ [1.12,1.13,1.14,1.15,1.16,1.17,1.20,1.24,1.25,1.29,1.30,1.31],
                  [1.13,1.15,1.18,1.20,1.22,1.23,1.22,1.21,1.22,1.19,1.16,1.14],
                  [1.14,1.17,1.20,1.23,1.24,1.25,1.21,1.23,1.24,1.29,1.30,1.33]
                    
            ]   , "Bono10Esp" :
                [ [100.3,100.3,100.4,100.5,100.6,100.7,200.0,200.4,200.5,200.9,300.0,300.1],
                  [100.3,100.5,100.8,200.0,200.2,200.3,200.2,200.1,200.2,100.9,100.6,100.4],
                  [100.4,100.7,200.0,200.3,200.4,200.5,200.1,200.3,200.4,200.9,300.0,300.3]
                    
            ]        ]
        
        
        return WaysOfIndexes(ways: waExamp, nDays: 3, nSimul: 12)
        }

    
   

}

enum wayCfd {case up;case down}
typealias rangesways = [(wayCfd,CountableClosedRange<Int> )]


//***************
struct waySamplesInClosedRangesUpAndDowns {
    
    let namesAndInitial  = ["euribor" : (0.56, 0.01),"bonos": (100.10, 0.005),"SP500":(2500,0.003)]
  let fwa = [(wayCfd.up,(1...20)), (wayCfd.down, (21...100) ), (wayCfd.down, (101...10000) )    ]
}

func elementInRangecfds(_ rn : rangesways, _ nEl : Int ) -> wayCfd? {
    
    guard let fir = rn.first(where: { $0.1.contains(nEl)}) else {return nil}
    return fir.0
    
}



func newValueOf(_ samplesUpDowns: waySamplesInClosedRangesUpAndDowns, _ name:String, actualValue: Double , inElem:Int ) -> Double? {
    guard  let wahstGoinOnNow = elementInRangecfds(samplesUpDowns.fwa, inElem) else {return nil}
    guard let valTup = samplesUpDowns.namesAndInitial[name] else {return nil}
    switch wahstGoinOnNow {
    case .up : return (valTup.1 + 1) * actualValue
    case .down : return (valTup.1 - 1) * actualValue
    }
}


//+++++++++++++++ protocol Indexes Generator+++++++++++++++++++++++++++++++++++++

protocol IndexesGen {
    
    associatedtype A
    associatedtype B
    
    static func generateIndexes( _ i : A) -> (Int) ->(Int) ->  B
}



protocol IndexerGenerator {
     associatedtype A
    static func generateIndexes( _ i : A) -> (Int) ->(Int) ->  wayConcrete
}

protocol IndexesGeneratorEnumsStr {
    associatedtype A
    static func generateIndexes( _ i : A) -> (Int) ->(Int) -> wayenumerStr
    
    
}

protocol IndexesGenerDictionableResultable {
    
    associatedtype A
    associatedtype B : DictionableResultable
    
    static func generateIndexes( _ i : A) -> (Int) ->(Int) -> B
}
protocol IndexGenDictionableHipo : IndexesGenerDictionableResultable {
    
    static func generateIndexes( _ i : A) -> (Int) ->(Int) -> indHpotecSample
    static func headOf( _ i :A) ->indHpotecSample
    static func elements( _ I :A) -> (Int,Int) //ndays y nSimulaciones
    
}



//**++++++++++++++++++++++++++++++++++++++++
/*
extension WaysOfIndexes : IndexerGenerator {
    
    
   typealias A =  WaysOfIndexes
    
    static func generateIndexes( _ i : WaysOfIndexes) -> (Int) ->(Int) ->  wayConcrete {
        
       
        
        return { nSim in return { nDays in
            
            
            let allIndes = CatchKeysInArray <&> i
            
            let coge = (CogeDelDictDeLosIndexEsto <&> i.ways <&> nSim <&> nDays)
            
            let valuesTo = allIndes <==> coge
            
            //let une = zip(allIndes,valuesTo)
            
            let dicTo = creaDictConesteArrayStringYesteDOuble <&> allIndes <&> valuesTo
            
            return dicTo
            
            }    }
        
        }
}



extension WaysOfIndexes : IndexesGeneratorEnumsStr {
    
    
    
    static func generateIndexes( _ i : WaysOfIndexes) -> (Int) ->(Int) ->  wayenumerStr {
        
        return { nSim in return { nDays in
            
            
            let allIndes = Array(i.ways.keys)
            
            let coge = (CogeDelDictDeLosIndexEsto <&> i.ways <&> nSim <&> nDays)
            
            let valuesTo = allIndes <==> coge
            
            //let une = zip(allIndes,valuesTo)
            
            
            let aLLIndesEnum = ( allIndes <==> { indexesHipoSample(rawValue: $0)     }).flatMap{$0}
            
            let dicTo = CreaDictionaryCOnEStosArrays( fir: aLLIndesEnum , sec: valuesTo)
            
            return dicTo
            
            
            }    }
        
        
    }
    
    
}
*/
extension WaysOfIndexes : IndexGenDictionableHipo  {
    
    static func generateIndexes( _ i : WaysOfIndexes) -> (Int) ->(Int) ->  indHpotecSample {
        
        return { nSim in return { nDays in
            
            
            let allIndes = Array(i.ways.keys)
            
            let coge = (CogeDelDictDeLosIndexEsto <&> i.ways <&> nSim <&> nDays)
            
            let valuesTo = allIndes <==> coge
            
            //let une = zip(allIndes,valuesTo)
            
            
            let aLLIndesEnum = ( allIndes <==> { indexesHipoSample(rawValue: $0)     }).flatMap{$0}
            
            let dicTo = CreaDictionaryCOnEStosArrays( fir: aLLIndesEnum , sec: valuesTo)
            
            return indHpotecSample(bookTrade: dicTo)
            
            
            }    }
        
        
        
    }
    
    static func headOf(_ i: WaysOfIndexes) -> indHpotecSample {
        
            return WaysOfIndexes.generateIndexes(i)(0)(0)
        
        
        
    }
    
    static func elements(_ I: WaysOfIndexes) -> (Int, Int) {
        
       let elem = I.ways.first!.value
        
        let dias = elem.first!.count
        let sims = elem.count
        return (dias,sims)
        
        
    }
    
    
}


 func GEnerateIndexes__ <B:IndexesGeneratorEnumsStr>  ( _ l: B) -> (Int) -> (Int) -> wayenumerStr where B.A == B {
    
    return B.generateIndexes(l)
}
 func GEnerateIndexes__ <B:IndexerGenerator>  ( _ l: B) -> (Int) -> (Int) -> wayConcrete where B.A == B {
    
    return B.generateIndexes(l)
}

func GEnerateIndexes__ <B:IndexGenDictionableHipo >  ( _ l: B) -> (Int) -> (Int) -> indHpotecSample where B.A == B {
    
    return B.generateIndexes(l)
}

func HEadOf<B:IndexGenDictionableHipo >  ( _ l: B) -> indHpotecSample where B.A == B  {return B.headOf(l) }

func ElementsOfWay<B:IndexGenDictionableHipo >  ( _ l: B) -> (Int,Int) where B.A == B  {return B.elements(l) }
        
//++++++++++++++++++++++++++++++++++


// +++++++++++++++++++Statdistical Generatorç
protocol DictionableEstadisticable{
    
    associatedtype A : RawRepresentable, Hashable where A.RawValue == String
    
    associatedtype B : StadisticalGenerator
    
    var bookTrade : Dictionary< A, Optional<B>> {get}
    
    
}


protocol StadisticalGenerator {  associatedtype A     ;     static func stadistic(_ d : [Double]) -> A   }

struct simpleStd  {
    let media : Double
    let varianza : Double
    var desvTipica : Double {return sqrt(varianza)}
        
       func  ident() -> simpleStd { return simpleStd(media:0,varianza:0)   }
        
    
}

struct  simpleS : StadisticalGenerator {
    
   
    
    static func stadistic(_ d : [Double]) -> simpleStd {
        
        let media = (d.reduce(0,+) ) / Double(d.count)
        let varianz = ((d <==> { pow($0-media,2)}).reduce(0, +) ) / Double(d.count)
        
        
        return simpleStd(media: media, varianza: varianz)
        }
}

func aplyEstadOneDict <A : DictionableResultable , B: StadisticalGenerator> ( _ resultadosAgreg : [A] , _ estadis: B)  -> Dictionary<A.A, B.A>?   {
    
    
    
    let convert = resultadosAgreg <==> {$0.bookTrade.mapValues{ [$0]    }}
   
    let conveObj = convert <==> {DictioToStd<A.A>($0)}
    
    guard let firsObj = conveObj.first else { return nil}
    
    let sumatorioDeTodosLosEnumerables = conveObj.reduce(firsObj.identity()) { (res:DictioToStd<A.A>, el: DictioToStd<A.A> ) -> DictioToStd<A.A> in  res ++++ el }
    
        let toRet = sumatorioDeTodosLosEnumerables.bookTrade.mapValues{B.stadistic($0 as! [Double])       }
        //posible errorToSee nohay q convertir as!  DOuble
        return toRet
    
    
}
    
    
    






//+++++++++++
