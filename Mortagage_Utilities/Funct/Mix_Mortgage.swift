//
//  Mix_Mortgage.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 24/10/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation


struct CuadroAmortizcionPrestamo {
    
    var cuadroMain: [(Double,Double)]// amort, interest
    
    func interestCuotOf(period:Int ) ->Double {return cuadroMain[period].1}
    
    
    func amortCuota(period:Int) ->Double {return cuadroMain[period].0}
    
    func elementos() -> Int { return cuadroMain.count}
    
    
    
    
    
    
}

struct hipoteca {let totalPrestado: Double;let alTipo:Double;let periodoAños:Int
    
    //var cuadroAmortizacion :[(Double,Double)]
    
    
    init( total: Double, tipo:Double,periodoAños_:Int) {
        
        self.totalPrestado = total
        self.alTipo = tipo
        self.periodoAños = periodoAños_
        
        self.cuadroAmortizacion = CuadroAmortizcionPrestamo(cuadroMain: [])
        
        
    }
    
    var cuadroAmortizacion : CuadroAmortizcionPrestamo
    
    func arrayDeLosPeriodos()->[Int] {
        return Array(1...(periodoAños * 12))
        
        
    }
    
    func cuota() -> (Double) {return  prestamos.cuotaHipoteca(totalPrestamo: totalPrestado, tipo: alTipo, periodos: periodoAños)}
    
    
    
    mutating func cuotaTotal( enelPeriodo: Int) -> (Double,Double)
    {
        let alTipoMensual = alTipo / 12
        
        if( cuadroAmortizacion.elementos() == 0) {
            
            
            
            // self.cuadroAmortizacion = CuadroAmortizcionPrestamo( cuadroMain: Array(1...periodoMeses).map{cuotaInMes(mes: $0)})
            
            let capitalPendiente = arrayDeLosPeriodos().map{ totalPrestado - (Double($0) * cuota())       }
            
            let arrAmort = capitalPendiente.map{ (   cuota() - ($0 * alTipoMensual) , $0 * alTipoMensual    )        }
            
            
            cuadroAmortizacion = CuadroAmortizcionPrestamo(cuadroMain: arrAmort)
        }
        
        return (self.cuadroAmortizacion.amortCuota(period: enelPeriodo), self.cuadroAmortizacion.interestCuotOf(period: enelPeriodo))
        
        
        
    }
    
}


