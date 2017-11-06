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

struct SeqSimul : Sequence {
    
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

