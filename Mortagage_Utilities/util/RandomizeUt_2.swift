//
//  RandomizeUt_2.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 1/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation

typealias tupDou = (Double,Double)
typealias tupInt = (Int,Int)

func metrizarArray<A>  (_ metr: A   ) -> [Double] where A : metrizable {
    
    let pasos = stepsNeceseToArrive(metr, metr.bounds.1)
    
    let mapp = arrayOfOrdeneredZEroIndex(pasos! + 1 ) <> map{ (Double($0) * metr.stepMinim) + metr.bounds.0    }
    
    return mapp
    
    
}

/*
func localizableDoubleInMetric<A>( _ val: Double , _ inMetr : A ) -> interval where A : metrizable {
    
    
    
    
 
    
    
    
    
}
*/
func obtenerIntervalosDeLaMetrica<A> ( _ metr: A) -> [interval]?  where A : metrizable{
  
    
    
    
    let step_ = stepsNeceseToArrive(metr, metr.bounds.1)
    
    guard let steps = step_ else {return nil}
    
    let mappe = arrayOfOrdered <> steps <> map {($0,$0)}
    
    let metrIni = metr.bounds.0
    
    func convert<A : metrizable> (_ tup: tupInt, _ metri : A ) -> tupDou?  {
       
        let metIni = metri.bounds.0
        
        let stepss_ =  metri.stepMinim
        
        
        
        
        
        let first = (Double ( (tup.0 - 1) ) * stepss_)  + metIni
        let second = (Double  ((tup.0 )) * stepss_)  + metIni
        
        return (first, second)
        
        
    }
    
    
    let mappedd = mappe <> map {convert($0,metr)  }
    
    let toMetr = mappedd  <> map {  interval(lowBound: $0!.0, upBound: $0!.1 )        }
    
    
    return toMetr
    
    
    
    
}


/*

struct intervalosMetricos: metrizable {
    
    var stepMinim: Double
    
    var bounds: (Double, Double)
    
    var dicMetr : [interval : Double]
    
    
    func valueForKey(_ ke : Double )-> Double  {
        
        
        
    }
    
    func keyForValue( _ val : Double) -> interval {
        
        
        
        
    }
    
    
    mutating func appendValue( _ valueX: Double , _ ofFx:Double ) {
        
        
        
    }
    
    
}


*/




/*

func obtainFDBOfMemoize< A>(_ valea : A) -> funcDouToDOu where A: doubleGenerMetrizable{
    
    
    var cache : [interval : Double] = [:]
    
    return { x in
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
*/
