//
//  RandomizeUt_4.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 21/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation


func IOGenerator<FU: doubleGenerMetrizable>(_ funcs :CompoundVAleatoria<FU> ) -> ((Double,Double  )) -> WaysOfIndexes {
    return {tup in
    
    return WaysOfIndexes.proof()
    }
}
