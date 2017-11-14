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
    
    func identity() -> DictioToStd {
        
        let t = self.bookTrade.mapValues{_ in Array<Optional<Double>>()}
        //let dic = Dictionary(t , uniquingKeysWith: {(f,s) in f })
        //return DictioToStd(dic)
        
        return DictioToStd(t)
    }
    
    var bookTrade : Dictionary< C, Array<Optional<Double>>>
    
    
}




func +++ < A:DictionableResultable , B:DictionableResultable > ( first:  A,second: B ) -> DictioToStd<A.A>   where A.A == B.A {
    
    typealias dcitRes = Dictionary<A.A,Array<Optional<Double>>>
    
    let t = [first.bookTrade, second.bookTrade]
    
    let todaslospares = (t <=> {$0.map{($0,$1)}}) .flatMap{$0}
    
    let po = todaslospares <=> {($0,[$1])}
        
    let dictT = Dictionary(po, uniquingKeysWith: {(f,s) in f + s         })
    
    return DictioToStd( dictT)
    
    
}
func +++ <A> ( first: DictioToStd<A>, second : DictioToStd<A>  )-> DictioToStd<A>  {
    
    let di = first.bookTrade.merging(second.bookTrade, uniquingKeysWith: {$0 + $1})
    
    return DictioToStd<A>(di)
    
    
}






struct rHipotSample : DictionableResultable {
    
    
    var bookTrade : Dictionary< resultsHipoSample, Optional<Double>>
    
}
struct indHpotecSample : DictionableResultable {
    
    var bookTrade : Dictionary< indexesHipoSample, Optional<Double>>
    
    
}


enum resultsHipoSample: String   {
    
    case beneficios = "Beneficios"
    case cash = "Cash"
    case garantisa = "Garantias"
    case perdidasAcumuladas = "PerdidasAcumuladas"
    case dia = "dia"
    
    
}
enum indexesHipoSample : String {
    
    case euribor1año = "Euribor 1 año"
    case bono10Esp = "Bono 10 años Español"
    case eurodollar = "EuroDollar"
    
    
}

// WAYS OF INDEXES +++++++++++++++++++++++++++++++++++++++++

struct WaysOfIndexes {
    
    let ways : waysOfInd
    
    let nDays : Int
    
    let nSimul : Int
    
    func proof() -> WaysOfIndexes {
        
        let waExamp : waysOfInd = [ "Euribor" :
            [ [12,13,14,15,16,17,20,24,25,29,30,31],
              [13,15,18,20,22,23,22,21,22,19,16,14],
              [14,17,20,23,24,25,21,23,24,29,30,33]
                
            ]   , "Bono10Años" :
                [ [12,13,14,15,16,17,20,24,25,29,30,31],
                  [13,15,18,20,22,23,22,21,22,19,16,14],
                  [14,17,20,23,24,25,21,23,24,29,30,33]
                    
            ]      ]
        
        
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
    
}



//**++++++++++++++++++++++++++++++++++++++++

extension WaysOfIndexes : IndexerGenerator {
    
    
   typealias A =  WaysOfIndexes
    
    static func generateIndexes( _ i : WaysOfIndexes) -> (Int) ->(Int) ->  wayConcrete {
        
       
        
        return { nSim in return { nDays in
            
            
            let allIndes = CatchKeysInArray <> i
            
            let coge = (CogeDelDictDeLosIndexEsto <> i.ways <> nSim <> nDays)
            
            let valuesTo = allIndes <=> coge
            
            //let une = zip(allIndes,valuesTo)
            
            let dicTo = creaDictConesteArrayStringYesteDOuble <> allIndes <> valuesTo
            
            return dicTo
            
            }    }
        
        }
}



extension WaysOfIndexes : IndexesGeneratorEnumsStr {
    
    
    
    static func generateIndexes( _ i : WaysOfIndexes) -> (Int) ->(Int) ->  wayenumerStr {
        
        return { nSim in return { nDays in
            
            
            let allIndes = Array(i.ways.keys)
            
            let coge = (CogeDelDictDeLosIndexEsto <> i.ways <> nSim <> nDays)
            
            let valuesTo = allIndes <=> coge
            
            //let une = zip(allIndes,valuesTo)
            
            
            let aLLIndesEnum = ( allIndes <=> { indexesHipoSample(rawValue: $0)     }).flatMap{$0}
            
            let dicTo = CreaDictionaryCOnEStosArrays( fir: aLLIndesEnum , sec: valuesTo)
            
            return dicTo
            
            
            }    }
        
        
    }
    
    
}

extension WaysOfIndexes : IndexGenDictionableHipo  {
    
    
    
    static func generateIndexes( _ i : WaysOfIndexes) -> (Int) ->(Int) ->  indHpotecSample {
        
        return { nSim in return { nDays in
            
            
            let allIndes = Array(i.ways.keys)
            
            let coge = (CogeDelDictDeLosIndexEsto <> i.ways <> nSim <> nDays)
            
            let valuesTo = allIndes <=> coge
            
            //let une = zip(allIndes,valuesTo)
            
            
            let aLLIndesEnum = ( allIndes <=> { indexesHipoSample(rawValue: $0)     }).flatMap{$0}
            
            let dicTo = CreaDictionaryCOnEStosArrays( fir: aLLIndesEnum , sec: valuesTo)
            
            return indHpotecSample(bookTrade: dicTo)
            
            
            }    }
        
        
        
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
        let varianz = ((d <=> { pow($0-media,2)}).reduce(0, +) ) / Double(d.count)
        
        
        return simpleStd(media: media, varianza: varianz)
        }
}

func aplyEstadOneDict <A : DictionableResultable , B: StadisticalGenerator> ( _ resultadosAgreg : [A] ) -> (B) -> Dictionary<A.A, B.A>?    {
    
    return { stadis in
    
    let convert = resultadosAgreg <=> {$0.bookTrade.mapValues{ [$0]    }    }
   
    let conveObj = convert <=> {DictioToStd<A.A>($0)}
    
    guard let firsObj = conveObj.first else { return nil}
    
    let sumatorioDeTodosLosEnumerables = conveObj.reduce(firsObj.identity()) { (res:DictioToStd<A.A>, el: DictioToStd<A.A> ) -> DictioToStd<A.A> in  res +++ el }
    
        let toRet = sumatorioDeTodosLosEnumerables.bookTrade.mapValues{B.stadistic($0 as! [Double])       }
        //posible errorToSee nohay q convertir as!  DOuble
        return toRet
    }
    
}
    
    
    






//+++++++++++
