//
//  Mix_Mortgage2.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 23/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation


struct product {
    let name:String
    let priceBuy:Double
    let multiplier:Double
    let contrats:Double
    let dateBuy: Int
    let garantiasPorContrato:Double
}
let pr1 = product(name: "euriborCFD", priceBuy: 100.1, multiplier: 100, contrats: 5, dateBuy: 1, garantiasPorContrato: 250)
let pr2 = product(name: "Bono10AñosEsp", priceBuy: 105, multiplier: 100, contrats: 0.5, dateBuy: 1, garantiasPorContrato: 100)

struct portFolio {
    let products : [product]
    let dateAct : Int
    let saldo:Double
    let garantias:Double
    let PyGLantentes:Double
    let PYGRealizadas:Double
}
let portf = portFolio(products: [], dateAct: 1, saldo: 1000, garantias: 0, PyGLantentes: 0, PYGRealizadas: 0)


protocol prestamoH {
    
    var  CapitalVivoRestante : Double {get}
    var tipo : Double{get}
    var dateActual:Int{get}
    var  isThisPeriodoToPay: (Int) -> Bool{get} //
    var  dateIntTOString: (Int) -> String{get} // nos da la fech formateada
    
    var  periodosPorPagar : Int{get}// cuantos pediodos mensuales
    
    func nextCuota() -> Double
    
    
    
    
}





//pasos secuenciales uno a uno
struct prestamoHipotecario : prestamoH {
    
    let CapitalVivoRestante : Double
    let tipo : Double
    let dateActual:Int
    let isThisPeriodoToPay: (Int) -> Bool //
    let dateIntTOString: (Int) -> String // nos da la fech formateada
    
    let periodosPorPagar : Int// cuantos pediodos mensuales
    
    func nextCuota() -> Double{return 1000}
    
    
}


let prest = prestamoHipotecario(CapitalVivoRestante: 120000, tipo: 0.03, dateActual: 0, isThisPeriodoToPay: { $0 % 30 == 0     }, dateIntTOString: {String($0) + "/00/2000"}, periodosPorPagar: 300)

func addToPortfolio(_ ps: [product]) -> State<portFolio,rHipotSample>  {
    
    return State{portf in
    
    let newPro = portf.products + ps
    let newSaldo = portf.saldo - 1000
    let newGaran = portf.garantias + 1000
    
    
    let newPort = portFolio(products: newPro, dateAct: portf.dateAct + 1, saldo: newSaldo, garantias: newGaran, PyGLantentes: 0, PYGRealizadas: 0)
    let res = rHipotSample(bookTrade: [resultsHipoSample.cash : -1000     ])
        
        return (res,newPort   )
        
         }
}

func closeAllPositions() -> State<portFolio,rHipotSample>  {
    
    
    return State {portf in
        
       
        let newSaldo = portf.saldo - 2000
        
        
        
        let newPort = portFolio(products: [], dateAct: portf.dateAct + 1, saldo: newSaldo, garantias: 0, PyGLantentes: 0, PYGRealizadas: -1000)
        let res = rHipotSample(bookTrade: [resultsHipoSample.cash : -1000     ])
        
        return (res,newPort   )
        
        
    }
    
    
    
}


func actualizeProduct(_ val: indHpotecSample) -> State<product,rHipotSample> {
    
    return State{prod in ( rHipotSample(bookTrade: [resultsHipoSample.perdidasAcumuladas : -1000     ]) ,prod   )   }
    
    
    
}
// CFDSS ///////////////////////////////////////////////////////////////////////

func actualizePortfolio( period: Int, ind: indHpotecSample) -> State<portFolio,rHipotSample> {
    
  
    
    
    let qappl = actualizeProduct(ind)
    
    
    return   State{ portf in
        
        let res = rHipotSample(bookTrade: [resultsHipoSample.cash : -1000     ])
        let newProds = portf.products <==> qappl.exec
        let newPortf = portFolio(products: newProds, dateAct: period, saldo: 0, garantias: 0, PyGLantentes: 0, PYGRealizadas: 0)
        
        
       return  (res,newPortf  ) }
    
    
}


func actualizePrestHIpotecario(period: Int, _ val: indHpotecSample) -> State<prestamoHipotecario,rHipotSample  >? {
    
    
   
    
    return State {prest in
        
        var newCap : Double
        
        if prest.isThisPeriodoToPay(period) {
            
            newCap = prest.CapitalVivoRestante - prest.nextCuota()
            
            
        }else {  newCap = prest.CapitalVivoRestante    }
        
        let newPrest = prestamoHipotecario(CapitalVivoRestante: newCap , tipo: 0.03, dateActual: prest.dateActual + 1, isThisPeriodoToPay: prest.isThisPeriodoToPay, dateIntTOString: prest.dateIntTOString, periodosPorPagar: prest.periodosPorPagar)
        
        
        
        
        
        return ( rHipotSample(bookTrade: [resultsHipoSample.cash : -1000     ])   ,  newPrest     )            }
    
    
    
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
            
            let porAct  = actualizePortfolio(period: iter, ind: ides)
            
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










