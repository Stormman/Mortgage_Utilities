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


func generIntInts ( ix : Int  ) -> (Int) -> Double {return {return Double($0) * Double(ix)}}










let arrayDeNumeros = Array(1...100)


typealias  funcIntToDouble = (Int) -> Double

typealias  estadisticoFunction = ([Double]) -> Double

typealias  transfDouble = (Double) -> Double

//estadisticos

func mean(args : [Double]) -> Double {let sum = args.reduce(0, +);return Double(sum) / Double(args.count)}

func Var(args: [Double]) -> Double {
    
    let mea = mean(args: args)
    let pow : transfDouble  = { return $0 * $0}
    let diferCuadrados = args <> map{ $0 - mea} <> map (pow)
    return diferCuadrados.reduce(0,+) / Double(args.count)
}

func desvTip(args:[Double]) -> Double {return sqrt(Var(args: args))}




//

func generaDoubleEnElPeriodo(_ n : Int) -> (funcIntToDouble ) -> Double {
    
    return {xs in return xs(n)}}



let arrpo = arrayDeNumeros <> take(30)

let arrdefunctionsInts = arrpo <> map(  generIntInts )



let curroAhora = generaDoubleEnElPeriodo(12)

let otraSimul = arrayDeNumeros <> take(100) <> map(generIntInts) <> map (curroAhora)




func generateSamplesOfFuncIntToDou (_ n: Int) -> [funcIntToDouble] {return Array(1...n) <> map(generIntInts)}

let sampleFuncArray = generateSamplesOfFuncIntToDou(20)


struct generatorsOfSimul {
    
    let functionsOf : [funcIntToDouble]
    
    let estadisitcos :[estadisticoFunction]
    
    
    func simulateIn (_ n :Int) -> Double {
        
        let arrayTo = self.functionsOf <> map(generaDoubleEnElPeriodo(n))
        
        return arrayTo.reduce(0, +)
        
        
    }
    
    func getEstadisticosInNSimulatiosTotal( _ nSimulations: Int) -> [Double] {
        
        
        let simulatTotal : [[Double]]
        
        return [0]
        
        
    }
    
    
    
    
}

let simula3 = sampleFuncArray <> map( generaDoubleEnElPeriodo(10)  )

let fGen :generatorsOfSimul = generatorsOfSimul(functionsOf: generateSamplesOfFuncIntToDou(20), estadisitcos: [mean,desvTip])

let simu1 = fGen.simulateIn(2)

let simul3 = fGen.simulateIn(20)

