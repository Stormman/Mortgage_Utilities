//
//  MathFunctions.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 17/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation




final class mathFunctions__ {
    
    struct Point {let x:Double ;let y : Double}
    
    enum kindsOfMAthCurves { case line }
    
    static func curve(_ kin : kindsOfMAthCurves, _ from :Point , _ to:Point ) -> funcDouToDOu {
        
        switch(kin) {
            
            case .line :
            
                return {kx in
                    let pte = (to.y - from.y) / (to.x - from.x)
                    return (kx * pte ) + from.x}
                break
            
            }}
    
    
    
    
    
    
}
