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
    
    let mapp = arrayOfOrdeneredZEroIndex(pasos! + 1 ) <&> map{ (Double($0) * metr.stepMinim) + metr.bounds.0    }
    
    return mapp
    
    
}


func localizableDoubleInMetric<A>( _ val: Double , _ inMetr : A ) -> interval? where A : metrizable {
    
   let intervalosTot = obtenerIntervalosDeLaMetrica(inMetr)
    
   
    
    
    guard let invT = intervalosTot else {return  nil }
    guard  (invT.count != 0) else {return nil}
    
    if( val == inMetr.bounds.1) {return invT.last}
    
    let arr = arrayOfOrdeneredZEroIndex((invT.count))
    
    let zipped =  zip(arr,invT)
    
    //let filt = zipped.filter { (val >= $1.lowBound) && (val <= $1.upBound )  }
    
     //if( val == inMetr.bounds.1) {return filt.last!.
    
    let filt = zipped.filter { betWeen($1.lowBound, $1.upBound)(val)  }
    
   
    
    guard ( (filt.count != 0) ) else {return nil}
    
    
    
    return filt.first!.1
    
    
    
    
    
    
}

func obtenerIntervalosDeLaMetrica<A> ( _ metr: A) -> [interval]?  where A : metrizable{
  
    
    
    
    let step_ = stepsNeceseToArrive(metr, metr.bounds.1)
    
    guard let steps = step_ else {return nil}
    
    let mappe = arrayOfOrdered <&> steps <&> map {($0,$0)}
    
    let metrIni = metr.bounds.0
    
    func convert<A : metrizable> (_ tup: tupInt, _ metri : A ) -> tupDou?  {
       
        let metIni = metri.bounds.0
        
        let stepss_ =  metri.stepMinim
        
        
        
        
        
        let first = (Double ( (tup.0 - 1) ) * stepss_)  + metIni
        let second = (Double  ((tup.0 )) * stepss_)  + metIni
        
        return (first, second)
        
        
    }
    
    
    let mappedd = mappe <&> map {convert($0,metr)  }
    
    let toMetr = mappedd  <&> map {  interval(lowBound: $0!.0, upBound: $0!.1 )        }
    
    
    return toMetr
    
    
    
    
}

func doubleInIntervalswhereIs(_ val: Double, _ intervals: [interval]) -> (inter:interval, pos:Int)? {
    
    let arr = arrayOfOrdeneredZEroIndex((intervals.count))
    
    let zipped =  zip(arr,intervals )
    
    //let filt = zipped.filter { (val >= $1.lowBound) && (val <= $1.upBound )  }
    
    let filt = zipped.filter { betWeen($1.lowBound, $1.upBound)(val)  }
    
    guard ( (filt.count != 0) ) else {return nil}
    
    return (inter : filt.last!.1 , pos: filt.last!.0)
    
    
    
}



struct intervalosMetricos <A: metrizable> {
    
    init?(metri: A) {
        
        let obt = obtenerIntervalosDeLaMetrica(metri)
        
        guard let obtain = obt else {return nil}
        
        
        dicMetr = [interval:Double?]()
        
        let coun = obtain.count - 1
        
        (0...coun).forEach{ dicMetr[obtain[$0]] = Optional<Double>.none    }
        
        
       
        
    }
    
    var dicMetr : [interval : Double?]
    
    
    func valueForKey(_ ke : Double )-> Double?  {
        
       let donde = doubleInIntervalswhereIs(ke, Array(dicMetr.keys))
        
        guard let wh = donde else {return nil}
        
        guard let po = dicMetr[wh.inter] else {  return nil     }
        
        return po
        
        
    }
    
    /*func keyForValue( _ val : Double) -> interval {
        
        
        
        
    }*/
    
    
    mutating func appendValue( _ valueX: Double , _ ofFx:Double ) {
        
        let keyss = Array(dicMetr.keys)
        
        let inter = doubleInIntervalswhereIs(valueX, keyss)
        
        guard let iv = inter?.inter else {return}
        
        
        dicMetr[iv] = ofFx
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
}










func obtainFDBOfMemoize< A>(_ valea : A) -> funcDouToDOu where A: doubleGenerMetrizable{
    
    
    var cache : intervalosMetricos = intervalosMetricos(metri: valea)!
    
    return { gener  in
        
        
        guard let cac = cache.valueForKey(gener) else {
            
            
            
            let pasosNece: Int? = stepsNeceseToArrive(valea, gener)
            if (pasosNece == nil) {return 0}
            if(pasosNece == 0) { return valea.generat(valea.bounds.0)    }
            assert(pasosNece != 0, "zero")
            let mapped = arrayOfOrdeneredZEroIndex(pasosNece!) <&> map{ (Double($0) * valea.stepMinim) + valea.bounds.0 }
            let mapped2 = mapped <&> map{ valea.generat($0)}
            let acum = mapped2 <&> reduce(0,+)
            
            cache.appendValue(gener, acum)
            
            return acum
            }
        
        
        return cac
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}

