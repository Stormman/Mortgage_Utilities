//
//  Mix_Mortgage2.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 23/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation

class ConstantsHipot {
    
    static let diaDePago_ = 18
    static let diaRenovac_ = 15
    static let frecuenciaNormalMensuaRenovacio_ = 6
}




struct product {
    let name:String
    let priceBuy:Double
    let multiplier:Double
    let contrats:Double
    let dateBuy: Double
    let garantiasPorContrato:Double
}
let pr1 = product(name: "euriborCFD", priceBuy: 100.1, multiplier: 100, contrats: 5, dateBuy: 1, garantiasPorContrato: 250)
let pr2 = product(name: "Bono10AñosEsp", priceBuy: 105, multiplier: 100, contrats: 0.5, dateBuy: 1, garantiasPorContrato: 100)

struct portFolio {
    let products : [product]
    let dateAct : Double
    let saldo:Double
    let garantias:Double
    let PyGLantentes:Double
    let PYGRealizadas:Double
}
let portf = portFolio(products: [], dateAct: 1, saldo: 1000, garantias: 0, PyGLantentes: 0, PYGRealizadas: 0)


protocol prestamoH {
    
    var fechaInicio : Date {get}
    
    var  CapitalVivoRestante : Double {get}
    
    var tipoActual : Double {get}//tipo actual del mercado hipotecario
    
    
    
    var dateActual:Double{get}
    var  isThisPeriodoToPay: (Double) -> Bool{get} //
    var  dateIntTOString: (Double) -> String{get} // nos da la fech formateada
    
    
    
    var  periodosPorPagar : Int{get}// cuantos pediodos mensuales
    
    func nextCuota() -> (Double,Double) //intereses y amortizacion
    func euriborWithPeriod() -> Double
    func nextdate(withIndex: Double ) -> prestamoH? //devuelve el miusmo objeto mutado con el paso de un periodo o dia
}
extension prestamoH {
    
    
    var actualDateSt : String {return dateIntTOString(dateActual)}
    
    var cuotaDeHoy : (Double,Double) {
        
        if (isThisPeriodoToPay(dateActual)){ return nextCuota()          } else {return (0,0)}
    }
    
    
}




//pasos secuenciales uno a uno
struct prestamoHipotecarioFijo : prestamoH {
    
    
    let fechaInicio: Date
    let CapitalVivoRestante : Double
    var  tipo : Double
    
    let tipoActual: Double
    let dateActual:Double
    
    let isThisPeriodoToPay: (Double) -> Bool //
    
    // nos da la fech formateada
    let dateIntTOString: (Double) -> String = {$0.dateAssoccDouble.toStringRepresent()!}
    
    let periodosPorPagar : Int// cuantos pediodos mensuales
    
    func nextCuota() -> (Double,Double) {
        
        
        let cuo = prestamos.cuotaDividida(capPte: CapitalVivoRestante, tipo: euriborWithPeriod(), periodosRestan: periodosPorPagar)
        
        return cuo
        
    }
    func euriborWithPeriod() -> Double {return self.tipo}
    
    
    func nextdate(withIndex: Double) -> prestamoH?{
        
        let cuota = self.cuotaDeHoy
        
        let newCap = self.CapitalVivoRestante - cuota.1
        let newDay = self.dateActual + SEcondsPerDay
        let newPer = (isThisPeriodoToPay(self.dateActual)) ? (self.periodosPorPagar - 1) : (self.periodosPorPagar)
        
        
        if(newCap <= 0 || newPer == 0) {return nil}
        
        let newPrest = prestamoHipotecarioFijo(fechaInicio: fechaInicio, CapitalVivoRestante: newCap, tipo: self.tipo, tipoActual: withIndex, dateActual: newDay, isThisPeriodoToPay: self.isThisPeriodoToPay, periodosPorPagar: newPer)
        
        return newPrest
        
        
        
        
        
    }
    
}


//constructor hipo fija
func prestFijo (_ Capit: Double) -> (Double) -> (Date) ->(Int)-> prestamoHipotecarioFijo {
    
    return {tipo  in {fechaInicio in { años in
        
        
        let componentesFInicio = fechaInicio.componetsOf()!
        let nuevaFechaFinal = Date.dateWithDayMonthAndYear(componentesFInicio.day!, componentesFInicio.month!, componentesFInicio.year! + años)
        
        
        let hi = hipotDate(fInit: fechaInicio, fEnd: nuevaFechaFinal!, dayToPay: ConstantsHipot.diaDePago_)
        
        let isthisPe = isFechaPxoimoPagoDouble <&> hi
        
        let p = prestamoHipotecarioFijo(fechaInicio: fechaInicio, CapitalVivoRestante: Capit, tipo: tipo, tipoActual: tipo, dateActual:fechaInicio.numberAssoc, isThisPeriodoToPay: isthisPe, periodosPorPagar: (años * 12))
        
        return p
        
        
        } }}
    
    
    
    
}

//nos da el prestamo en un periodo dado si existe
func prestamoInThePeriod_ (_ pre: prestamoH) -> (Int) -> prestamoH? {
    
    return {period in
        
       let tipoFi = pre.tipoActual
        
        let dar = Array(0...period).scanl(pre) { (p : prestamoH?, e: Int ) -> prestamoH? in
            p?.nextdate(withIndex: tipoFi ) }
        
        guard let t = dar.last else {return nil}
        
        return t
}}

//nos da el recorrido del prestamo en el periodo
func prestamosAllInTHePeriod_ (pre:prestamoH) ->(Int)-> [prestamoH?] {
    
    return { period in
    let tipoFi = pre.tipoActual
    
    let dar = Array(0...period).scanl(pre) { (p : prestamoH?, e: Int ) -> prestamoH? in
        p?.nextdate(withIndex: tipoFi ) }
    
    return dar
    }
}


//nos da el ultimo prestamo dado el recorrido del euribor para prestvar o semivariables
func prestamoInThePeriod_ (_ pre: prestamoH) -> ([Double]) -> (Int) -> prestamoH? {
    
    return {indes in {period in
        
        let indexpr = (take <&> period) <&> indes
        
        let dar = indexpr.scanl(pre){ (p : prestamoH?, e: Double) -> prestamoH? in
            p?.nextdate(withIndex: e)
            
        }
        
        guard let dt = dar.last  else {return nil}
        return dt
        
    }}
}

//nos da el recorrido del prestamo dado el recorrido del euribor para prestvar o semivariables
func prestamoInThePeriod_all (_ pre: prestamoH) -> ([Double]) -> (Int) -> [prestamoH?] {
    
    return {indes in {period in
        
        let indexpr = (take <&> period) <&> indes
        
        let dar = indexpr.scanl(pre){ (p : prestamoH?, e: Double) -> prestamoH? in
            p?.nextdate(withIndex: e)
            
        }
        
       return dar
        }}
}

struct prestamoHipotecarioVariable : prestamoH {
    let  fechaInicio: Date
    
   
   
    
    let CapitalVivoRestante : Double
   
    var tipoActual: Double
    
    let tipoFijadoDelPeriodo : Double
    
    let dateActual:Double
    
    let isThisPeriodoToPay: (Double) -> Bool //
    let dateIntTOString: (Double) -> String = {$0.dateAssoccDouble.toStringRepresent()!}
    
    let periodosPorPagar : Int// cuantos pediodos mensuales
    
    func nextCuota() -> (Double,Double) {
        let cuo = prestamos.cuotaDividida(capPte: CapitalVivoRestante, tipo: euriborWithPeriod(), periodosRestan: periodosPorPagar)
        
        return cuo
        
    }
    
    func euriborWithPeriod() -> Double {
        
       return tipoFijadoDelPeriodo
        
    }
    
    let  IsthisPeriodRevisedIndexEurib: (Double) -> Bool = {d in
        
      let t =  isfechaProximaRenovacionIndice <&> ConstantsHipot.diaRenovac_ <&> ConstantsHipot.frecuenciaNormalMensuaRenovacio_ <&> d.dateAssoccDouble
        return t
        
    }
    
    
    func nextdate(withIndex: Double) -> prestamoH? {
        
         let cuota = self.cuotaDeHoy
        
        let newCap = self.CapitalVivoRestante - cuota.1
        let newDay = self.dateActual + SEcondsPerDay
        
        
        let newPer = (isThisPeriodoToPay(self.dateActual)) ? (self.periodosPorPagar - 1) : (self.periodosPorPagar)
        
        if( newPer == 0) {return nil}
        
        let newTipo = IsthisPeriodRevisedIndexEurib(newDay ) ? (withIndex) : (self.tipoFijadoDelPeriodo)
        
        
        
        let newPrest = prestamoHipotecarioVariable(fechaInicio: fechaInicio, CapitalVivoRestante: newCap, tipoActual: withIndex, tipoFijadoDelPeriodo: newTipo, dateActual: newDay, isThisPeriodoToPay: isThisPeriodoToPay, periodosPorPagar: newPer)
        
        return newPrest
        
        
        
        
        
    }
    
}

//constructor hipoteca Vairable
func prestamoVariable (_ Capit: Double) -> (Double) -> (Date) ->(Int)-> prestamoHipotecarioVariable {
    
    return {tipo  in {fechaInicio in { años in
        
        
        let componentesFInicio = fechaInicio.componetsOf()!
        let nuevaFechaFinal = Date.dateWithDayMonthAndYear(componentesFInicio.day!, componentesFInicio.month!, componentesFInicio.year! + años)
        
        
        let hi = hipotDate(fInit: fechaInicio, fEnd: nuevaFechaFinal!, dayToPay: ConstantsHipot.diaDePago_)
        
        let isthisPe = isFechaPxoimoPagoDouble <&> hi
        
        //let p = prestamoHipotecarioFijo(CapitalVivoRestante: Capit, tipo: tipo, tipoActual: tipo, dateActual:fechaInicio.numberAssoc, isThisPeriodoToPay: isthisPe, periodosPorPagar: (años * 12))
        
        let p = prestamoHipotecarioVariable(fechaInicio: fechaInicio, CapitalVivoRestante: Capit, tipoActual: tipo, tipoFijadoDelPeriodo: tipo, dateActual: fechaInicio.numberAssoc, isThisPeriodoToPay: isthisPe, periodosPorPagar: (años * 12))
        
        return p
        
        
        } }}
    
    
    
    
}

enum tipo {
    
    case variable
    case fijo(Double)
    
    
}
//prestamo hipotecario por tramos
struct prestamoHipotTramos : prestamoH {
    
    let  fechaInicio: Date
    
    
    //tipofijado del periodo es el ue tenemos que aplicar, el tipoactual es el de mercado y
   
    
    
    
    
    let CapitalVivoRestante : Double
    var tipoActual : Double
    let tipoFijadoDelPeriodo : Double
    let tramos : [Double : tipo]
  
    
    let dateActual:Double
    let isThisPeriodoToPay: (Double) -> Bool //
    let dateIntTOString: (Double) -> String = {$0.dateAssoccDouble.toStringRepresent()!}
    
    let periodosPorPagar : Int// cuantos pediodos mensuales
    
    func euriborWithPeriod() -> Double {
        
        let dayActual = dateTools.differenceDays(start: fechaInicio, toDate: dateActual.dateAssoccDouble)
        let fir = tramos.filter({Double(dayActual) >= $0.key})
        
        
        let tipp = fir.keys.sorted()
        let tip = fir[tipp.last!]!
       
        
        switch tip {
        case let tipo.fijo(doy) : return doy
        default: return tipoFijadoDelPeriodo
        }
        
        
       }
    
    
    func nextdate(withIndex: Double) -> prestamoH? {
        
        let cuota = self.cuotaDeHoy
        
        let newCap = self.CapitalVivoRestante - cuota.1
        let newDay = self.dateActual + SEcondsPerDay
        let newPer = (isThisPeriodoToPay(newDay)) ? (self.periodosPorPagar - 1) : (self.periodosPorPagar)
        
       if( newPer == 0) {return nil}
        
        let newTipo = IsthisPeriodRevisedIndexEurib(newDay ) ? (withIndex) : (self.tipoFijadoDelPeriodo)
        
        let newPrest = prestamoHipotTramos(fechaInicio: fechaInicio, CapitalVivoRestante: newCap, tipoActual: self.euriborWithPeriod(), tipoFijadoDelPeriodo: newTipo, tramos: self.tramos, dateActual: newDay, isThisPeriodoToPay: isThisPeriodoToPay, periodosPorPagar: newPer)
        
        return newPrest
        
        
    
        
        
        
        
    }
    

    
    
    
    let  IsthisPeriodRevisedIndexEurib: (Double) -> Bool = {d in
        
        let t =  isfechaProximaRenovacionIndice <&> ConstantsHipot.diaRenovac_ <&> ConstantsHipot.frecuenciaNormalMensuaRenovacio_ <&> d.dateAssoccDouble
        return t
        
    }
    
    //intereses y amortizacion
    func nextCuota() -> (Double, Double) {
        
        let cuo = prestamos.cuotaDividida(capPte: CapitalVivoRestante, tipo: euriborWithPeriod(), periodosRestan: periodosPorPagar)
        
        return cuo
        
        
    }
    

}

//hipot tramos constructor
func prestamoPorTramos(_ capital: Double) -> (Date) -> (Int)-> (Dictionary<Double,tipo>) -> prestamoHipotTramos {
    
    return {fechaInicio in { años in { tramoTipos in
        
        let componentesFInicio = fechaInicio.componetsOf()!
        let nuevaFechaFinal = Date.dateWithDayMonthAndYear(componentesFInicio.day!, componentesFInicio.month!, componentesFInicio.year! + años)
        
        
        let hi = hipotDate(fInit: fechaInicio, fEnd: nuevaFechaFinal!, dayToPay: ConstantsHipot.diaDePago_)
        
        let isthisPe = isFechaPxoimoPagoDouble <&> hi
        
        let presTram = prestamoHipotTramos(fechaInicio: fechaInicio, CapitalVivoRestante: capital, tipoActual:0, tipoFijadoDelPeriodo: 0, tramos: tramoTipos, dateActual: fechaInicio.numberAssoc, isThisPeriodoToPay: isthisPe, periodosPorPagar: (años * 12) + 1)
        return presTram
        
        }}}
    
    
}
func addToPortfolio(_ ps: [product]) -> State<portFolio,rHipotSample>  {
    
    return State{portf in
    
    let newPro = portf.products + ps
    let newSaldo = portf.saldo - 1000
    let newGaran = portf.garantias + 1000
    
    
    let newPort = portFolio(products: newPro, dateAct: portf.dateAct + SEcondsPerDay, saldo: newSaldo, garantias: newGaran, PyGLantentes: 0, PYGRealizadas: 0)
    let res = rHipotSample(bookTrade: [resultsHipoSample.cash : -1000     ])
        
        return (res,newPort   )
        
         }
}

func closeAllPositions() -> State<portFolio,rHipotSample>  {
    
    
    return State {portf in
        
       
        let newSaldo = portf.saldo - 2000
        
        
        
        let newPort = portFolio(products: [], dateAct: portf.dateAct + SEcondsPerDay, saldo: newSaldo, garantias: 0, PyGLantentes: 0, PYGRealizadas: -1000)
        let res = rHipotSample(bookTrade: [resultsHipoSample.cash : -1000     ])
        
        return (res,newPort   )
        
        
    }
    
    
    
}


func actualizeProduct(_ val: indHpotecSample) -> State<product,rHipotSample> {
    
    return State{prod in ( rHipotSample(bookTrade: [resultsHipoSample.perdidasAcumuladas : -1000     ]) ,prod   )   }
    
    
    
}
// CFDSS ///////////////////////////////////////////////////////////////////////

func actualizePortfolio( period: Double, ind: indHpotecSample) -> State<portFolio,rHipotSample> {
    
  
    
    
    let qappl = actualizeProduct(ind)
    
    
    return   State{ portf in
        
        let res = rHipotSample(bookTrade: [resultsHipoSample.cash : -1000     ])
        let newProds = portf.products <==> qappl.exec
        let newPortf = portFolio(products: newProds, dateAct: period, saldo: 0, garantias: 0, PyGLantentes: 0, PYGRealizadas: 0)
        
        
       return  (res,newPortf  ) }
    
    
}




enum compPortfolio {
    
    case addPortfolio (prs: [product])
    case closeAllPositions
}
enum predicResults {
    
    case resultsPred ((rHipotSample) -> Bool  )
    case indexPred ((indHpotecSample) -> Bool)
    case BothResultsAndIndexPred( (indHpotecSample)->(rHipotSample)-> Bool )
}
struct commmandsPortfolio {
    
    let comm : [(predicResults,compPortfolio)]
    
    func nextCommand( _ resultsandIndexes: (rHipotSample, indHpotecSample)) -> State<portFolio,rHipotSample>?{
        
        // buscar en la matriz la condicion que sea true
        //aplicar el comando con un pattenr matching de switch
        
        
        
        
        return State {portf in (  rHipotSample(bookTrade: [resultsHipoSample.cash : -1000     ]) ,portf)     }
        
    }
}

struct PortfolioSIM {
    let comm : commmandsPortfolio
    let portfol : portFolio
    
    
    
}


func >+><A> ( firs : State<A,rHipotSample> , seco : State<A, rHipotSample>        ) -> State<A,rHipotSample>  {
    
    return State {portf in
        let newRe = firs.eval(portf) + seco.eval(firs.exec(portf))
        return ( newRe, seco.exec(firs.exec(portf)))
    }
}





extension PortfolioSIM : funcNX {
    
    func applyNEXT_(_ res: rHipotSample) -> (Int) -> (indHpotecSample) -> rHipotSample{
        
        var cache : portFolio?
        
        return {iter in  { ides in
            
            let porAct  = actualizePortfolio(period: Double(iter), ind: ides)
            
            let commandsTo = self.comm.nextCommand((res, ides))
            
            
            if let portAnterior = cache { // si hay en cache el portfolio anterior
         
                if let comandos_aplicar = commandsTo {// hay comandos que aplicar
                  
                    //antes de nuevos indices y nuevo dia
                 let newP = comandos_aplicar.exec(portAnterior)
                 let newR = comandos_aplicar.eval(portAnterior)
                  //  ^^^^^^ esto es antes de aplicar el nuevo indice y el nuevo dia ^^^
                    
                  let newnewP = porAct.exec(newP)
                let newnewR = porAct.eval(newP) + newR
                   
                    cache = newnewP
                    return newnewR
                    
                    
                }else{ // no hay comandos que aplicar
                
                
                
                let toretResult = porAct.eval(portAnterior)
                
                let newPortf = porAct.exec(portAnterior)
            
                return toretResult
                }
                
            }else {// si en cache no hay nada, es el primer porfolio
                
                if let comandos_aplicar = commandsTo {// hay comandos que aplicar
                    
                    //antes de nuevos indices y nuevo dia
                    let newP = comandos_aplicar.exec(self.portfol)
                    let newR = comandos_aplicar.eval(self.portfol)
                    //  ^^^^^^ esto es antes de aplicar el nuevo indice y el nuevo dia ^^^
                    
                    let newnewP = porAct.exec(newP)
                    let newnewR = porAct.eval(newP) + newR
                    
                    cache = newnewP
                    
                    
                    
                    return newnewR
                    
                    
                }else{ // no hay comandos que aplicar
                    
                    
                    
                    
                    
                    let tor = porAct.eval (self.portfol)
                    
                    cache = porAct.exec (self.portfol)
                    
                    
                    return tor
                    
                }
                
                
                
                
                
               
            }
            
            
            
            
            
            
            
            
            
            
            
            }}
    }
}


struct hipotecaSIM<A:prestamoH>  {
    
    let prestam : A
    
    
    
    
}
func actualizePrestHIpotecario(period: Int, _ val: indHpotecSample) -> State<prestamoH?,rHipotSample> {
    
    
    
    
    return State {prest in
        
        
        // ante sde darle al nexdate tneemos que actualizarlo
        
        let indiEuri = val.bookTrade[indexesHipoSample.euribor1año] ?? 0.03
        
        let newPrest =  prest!.nextdate(withIndex: indiEuri!)
        
        //ahora sacamos la cuota
        let cuo = prest!.nextCuota()
        
        
        return ( rHipotSample(bookTrade: [resultsHipoSample.cash : cuo.0 + cuo.1     ])   ,  newPrest     )            }
    
    
    
}

func actualizePrestamoHipotecario(period : Int) -> ([Double]) -> State<prestamoH?,rHipotSample> {
    
    return  {indes in
        
        State {pre in
            
            let indexpr = (take <&> period) <&> indes
            
            let newS = indexpr.scanl(pre) { (pr:prestamoH?, d:Double) -> prestamoH? in
                guard let prr = pr else {return nil}
                guard let qr = prr.nextdate(withIndex: d) else {return nil }
                
                
                return qr}
            
            let newPre = newS.last ?? nil
            
            let cuotas = newS.flatMap{$0} <==> {($0.cuotaDeHoy.0) + ($0.cuotaDeHoy.1) }
            let sumaDelascuotas = cuotas.reduce(0) {$0 + $1}
            
            
            return (rHipotSample(bookTrade: [resultsHipoSample.cash: -sumaDelascuotas]), newPre)}
        
    }
}

extension hipotecaSIM : funcNX{
    
    func applyNEXT_(_ res: rHipotSample) -> (Int) -> (indHpotecSample) -> rHipotSample {
        
         var cache : prestamoH?
        
        return {iter in  { ides in
            
            let rId = rHipotSample(bookTrade: [:])
        
             let hipAtc = actualizePrestHIpotecario(period: iter, ides)
            
            switch cache {
                
            case nil :
                
               
                
                let fff = hipAtc.exec(self.prestam)
                
                cache = fff
                
                
                return hipAtc.eval(self.prestam)
            
            case _?:
                
                let fff = hipAtc.exec(cache!)
                let res = hipAtc.eval(cache!)
                
                cache = fff
                
                return res
                
                }
            
            
            }}
    }
}

//++++++++++++++++++++++++++
func recorridoEuribor( _ elem: Int) -> [Double]  {
    
    let f = Array(repeatElement(0.03, count: 160))
    let s = Array(repeatElement(0.05, count: 200))
    let t = Array(repeatElement(0.06, count: elem - 360))
    
    
    return f + s + t
}

func prestamosResultAbout(_ reocrridoEuri: [Double] ) -> [prestamoH] {
    
    let pres = prestFijo <&> 120000.00 <&> 0.04 <&> tDate_(1, 1, 2018)! <&> 20
    
    
return Array(repeatElement(pres , count: reocrridoEuri.count))
    
    
}

