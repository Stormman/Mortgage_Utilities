//
//  SimulaHip_3.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 10/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation

typealias waysOfInd = [String : [[Double]]]
typealias wayConcrete = [String:Double?]

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


//+++++++++++++++ protocol Indexes Generator

protocol IndexerGenerator {
  
    associatedtype A
    
    func generateIndexes( _ i : A) -> (Int) ->(Int) ->  wayConcrete
    
    
    
}

extension WaysOfIndexes : IndexerGenerator {
    
    func generateIndexes( _ i : WaysOfIndexes) -> (Int) ->(Int) ->  wayConcrete {
        
       
        
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





//+++++++++


func elementIndexOf(_ ways : WaysOfIndexes)-> (String) ->  ( Int) -> (Int) -> Double? {// -> nSim -> day -> Double
    
    return {  name in { nSim  in  {nDay in
        
        guard let po = ways.ways[name]?[nSim][nDay] else {return nil}
        
        return po
        }
        
    }
        
}
    
}

func elementIndexOf(_ ways : waySamplesInClosedRangesUpAndDowns)-> (String) ->  ( Int) -> (Int) -> Double? {// -> nSim -> day -> Double
    
    return {  name in { nSim  in  {nDay in
        
        
        guard let valorInd = ways.namesAndInitial[name]?.0 else {return nil}
        guard let po = newValueOf(ways, name, actualValue: valorInd, inElem: nDay ) else {return nil}
        
        return po
        }
        
        }
        
    }
    
}


