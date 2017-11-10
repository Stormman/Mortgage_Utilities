//
//  SimulaHip_3.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 10/11/17.
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

func elementIndexOf(_ ways : WaysOfIndexes)-> (String) ->  ( Int) -> (Int) -> Double? {// -> nSim -> day -> Double
    
    return {  name in { nSim  in  {nDay in
        
        guard let po = ways.ways[name]?[nSim][nDay] else {return nil}
        
        return po
        }
        
    }
        
}
    
}




