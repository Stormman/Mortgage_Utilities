//
//  Mix_Mortgage3.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 30/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation


let SEcondsPerDay : Double  = 24 * 60 * 60

struct hipotDate {
    
    let fInit : Date
    let fEnd : Date
    let dayToPay: Int
    
   static  func proof() -> hipotDate {
        
        let fechaComienzoHipoteca = Date.dateWithComponents(day: 1, month: 1, year: 2018, hour: 23, minute: 0, second: 0)
        let fechaFinHipoteca = Date.dateWithComponents(day: 31, month: 12, year: 2038, hour: 23, minute: 0, second: 0)
        let diasDePago = 18
        
       
        
        return  hipotDate(fInit:fechaComienzoHipoteca!,fEnd: fechaFinHipoteca!, dayToPay:18)
        
        
        
    }
}
// tiene en cuenta los dias laborables
func fechaProximoPago( dateHipoteca: hipotDate, hoy:Date)-> Date  {
    
   let da =  Date.dateWithComponents(day: dateHipoteca.dayToPay, month: (hoy.componetsOf()?.month!)!, year: (hoy.componetsOf()?.year!)!, hour: 23, minute: 0, second: 0)!
    
    
    let diaLaborable = dateTools.nextLabourDayFrom(dat: da)
    
    return diaLaborable!
    
}
func isFechaProsimoPago(_ hip : hipotDate) -> (Date) -> Bool {
    
    return {dat in
        
        let diaAstring = dat.toStringRepresent()
        
        return diaAstring == fechaProximoPago(dateHipoteca: hip, hoy: dat).toStringRepresent()
        
        
    }
    
    
    
}
func isFechaPxoimoPagoDouble(_ hip : hipotDate) -> (Double) -> Bool {
    
    return {datDouble in
        
        let dat = datDouble.dateAssoccDouble
        
        let diaAstring = dat.toStringRepresent()
        
        return diaAstring == fechaProximoPago(dateHipoteca: hip, hoy: dat).toStringRepresent()
        
    }
    
    
    
}

func isfechaProximaRenovacionIndice(_ diaDeRenov: Int) -> (Int)->(Date)-> Bool  {
    
    return {intervmensual in {today in
        
        let nex = Date.dateOfNextRenovac(dayOfRen: diaDeRenov, monthFrquency: intervmensual, fechaToday: today )
        
        let nexStr = nex.toStringRepresent()
        let tod = today.toStringRepresent()
        
        if nexStr == tod  {return true} else {return false }
        
        
        
        
        }}
    
}

