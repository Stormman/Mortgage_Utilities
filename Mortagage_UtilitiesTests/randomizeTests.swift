//
//  randomizeTests.swift
//  Mortagage_UtilitiesTests
//
//  Created by Antonio Muñoz on 1/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest
@testable import Mortagage_Utilities

class randomizeTests: XCTestCase {
    
    struct n : metrizable {
        var stepMinim: Double
        
        var bounds: (Double, Double)
        
    }
     typealias po = mathFunctions__.Point
  // typealias fde =  CompoundVAleatoria__.
    
    
    
    
    override func setUp() {
        super.setUp()
        
        
            
            
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        
        self.measure(){
        
        let v = varAleatoria(descrip: "pepe", step: 0.5, boundss: (0,7), generato: funcToExaple)
        
        let v2 = waysOfIO.proof()
        
        
        let gppp = v2.generateTheWayValues()
        
        
            let fg = 90}
        

    }
    
    func testFuntions() {
        
       
        
        let mn = n(stepMinim: 9, bounds: (-100, 100))
        
        let arr = metrizarArray(mn)
        
        
        
        XCTAssert(arr.count == 66)
        
        
        
        let ggg = 0.1
        
        
        
    }
    
    
    func testStepsto() {
        
        let mn = n(stepMinim: 3, bounds: (-100, 100))
        
        let paso = stepsNeceseToArrive(mn,mn.bounds.1)
        
        
        
        XCTAssert( paso == 66 )
    }
    
    
    func testobtenerintervalosdelametrica() {
        
        let mn = n(stepMinim: 3, bounds: (-100, 100))
        
        
        let metric = obtenerIntervalosDeLaMetrica(mn)
        
        let fg = 9000001
        
        
        
    }
    
    func testLocalizableDoubleInmetric () {
        
        
        let mn = n(stepMinim: 3, bounds: (-100, 100))
        
            let inv = localizableDoubleInMetric(12, mn)
        
        let fg = 9000
        
        
        
    }
    
    func testDoubleinintervalWhereIs () {
        
        let mn = n(stepMinim: 3, bounds: (-100, 100))
        
        
        let metric = obtenerIntervalosDeLaMetrica(mn)
        
        
        let donde = doubleInIntervalswhereIs(8, metric!)
        
        XCTAssert(donde!.pos == 36 && donde!.inter.lowBound == 8 && donde!.inter.upBound == 11)
        
        let oo = 90000
        
    }
    
    func testIntervalosmetricosStruct () {
        
        let mn = n(stepMinim: 3, bounds: (-100, 100))
        var  iv = intervalosMetricos(metri: mn)
        
        
        iv?.appendValue(8, 20)
        
        print (iv?.dicMetr)
        
        
        
        
        let fppp = 9000000
        
        
        
        
        
        
    }
    
    func testObtainfDBmemoize() {
        
        
         let v = varAleatoria(descrip: "pepe", step: 0.5, boundss: (0,7), generato: funcToExaple)
        
        
        let fdb = obtainFDBOfMemoize(v)
        
        
        fdb(1)
        
        fdb(1)
        
        
        
        let fdb2 = obtainFDBOf(v)
        
        (1...20).forEach{ print(fdb2(Double($0)))     }
        
        
        
        
    }
    
    func testCheckVarAleat () {
        
       let v = varAleatoria(descrip: "pepe", step: 0.5, boundss: (0,8), generato: funcToExaple)
        
        let sum = checkVarAlea(varAle: v)
        
        
        let wio = waysOfIO.proof()
        
        let sum2 = checkVarAlea(varAle: wio.vAlea)
        
        
        let fg = 900000
        
    }
    
    
    func test_checkGenerAleatorioSimple () {
        
        let intervSingle: [(Double,Double)] = [(3,2),(8,12),(38,27),(78,107)    ]
        
        guard let f = CompoundVAleatoria__.concatenateIntervWtihLines(intervSingle, stepm: 0.5) else {return }
        
        let fi = checkGenerAleatorioSimple(varAl: f[0])
        
        let sec = checkGenerAleatorioSimple(varAl: f[1])
        let ter = checkGenerAleatorioSimple(varAl: f[2])
        
        XCTAssert(fi == 65)
        XCTAssert(sec == 1162.5)
        XCTAssert(ter == 5320)
        
        
        
        let ffp = 9990
        
        
        
        
        
        
    }
    
    
    func test_checkVARALEAFUNC() {
        
     
        let intervSingle: [(Double,Double)] = [(3,2),(8,12),(38,27),(78,107)    ]
        
        guard let f = CompoundVAleatoria__.concatenateIntervWtihLines(intervSingle, stepm: 0.5) else {return }
        
        let tot = checkVARALEAFUNC(funcs: f)
        
        XCTAssert(tot == 6547.5)
        
        let intervSingle2: [(Double,Double)] = [(-3,0.15),(-2,0.02),(0,0.005),(2,0.212),(3,0.17)    ]
        
        guard let f2 = CompoundVAleatoria__.concatenateIntervWtihLines(intervSingle2, stepm: 0.5) else {return }
        
        let tot2 = checkVARALEAFUNC(funcs: f2)
        
        XCTAssert(tot2 == 1.026)
       
        let r = 900000
    }
    
    
    func test_FBde(){
        
        let intervSingle2Bis: [(Double,Double)] = [(-3,0.15),(-2,0.02),(0,0.005),(2,0.205),(3,0.17)    ]
        
        let intervSingle2: [(Double,Double)] = [(-3,6),(-2,4),(-1,2),(1,3),(2,5),(3,7)    ]
        
        guard let f2 = CompoundVAleatoria__.concatenateIntervWtihLines(intervSingle2, stepm: 0.5) else {return }
        
        let tot2 = checkVARALEAFUNC(funcs: f2)
        
        
        
       
        
        
        //let db2 = CompoundVAleatoria__.FBde(f2, 3)
        
       // let db3 = CompoundVAleatoria__.FBde(f2, 3.01)
        
        let db1 = CompoundVAleatoria__.FBde(f2, -3)
        let db2 = CompoundVAleatoria__.FBde(f2, -2.7)
         let db3 = CompoundVAleatoria__.FBde(f2, -2.3)
         let db4 = CompoundVAleatoria__.FBde(f2, -2)
         let db5 = CompoundVAleatoria__.FBde(f2, -1.7)
         let db6 = CompoundVAleatoria__.FBde(f2, -1.5)
         let db7 = CompoundVAleatoria__.FBde(f2, -1)
        
        XCTAssert(db1 == )
        
        
        
        
        
        let fg = 9000000
        
        
        
        
    }
    
    func test_fDBoneparticularFunc () {
        
        let intervSingle2: [(Double,Double)] = [(-3,6),(-2,4),(-1,2),(1,3),(2,5),(3,7)    ]
        
        guard let f2 = CompoundVAleatoria__.concatenateIntervWtihLines(intervSingle2, stepm: 0.5) else {return }
        
        let tot2 = checkVARALEAFUNC(funcs: f2)
        
        //let t1 = fDBoneparticularFunc(f2[0], -2)
        
        
        
        let t2 = fDBoneparticularFunc(f2[1], -1.3)
        
        let t3 = fDBoneparticularFunc(f2[2], 0.9)
        let t31 = fDBoneparticularFunc(f2[3], 1.1)
        let t32 = fDBoneparticularFunc(f2[3], 1.5)
        let t33 = fDBoneparticularFunc(f2[3], 1.7)
       
        
        
        let t4 = fDBoneparticularFunc(f2[4], 2)
        
        let t45 = fDBoneparticularFunc(f2[4], 2.4)
        let t46 = fDBoneparticularFunc(f2[4], 2.5)
         let t47 = fDBoneparticularFunc(f2[4], 2.6)
        
        XCTAssert(t2 == 7)
         XCTAssert(t3 == 9.5)
         XCTAssert(t31 == 3)
         XCTAssert(t32 == 7)
         XCTAssert(t33 == 7)
         XCTAssert(t4 == 5)
         XCTAssert(t45 == 5)
         XCTAssert(t46 == 11)
         XCTAssert(t47 == 11)
        //let t5 = fDBoneparticularFunc(f2[4], 3)
        
        
        
        
        let fg = 9900000
        
        
        
        
    }
    
    func testWaysIO () {
        
        
        let wa = waysOfIO.proof()
        
        let genr = wa.generateTheWayValues()
        
        
        let fop = 9000
        
        
       
        
        
        
        
        
        
    }
    
    
    func test_numerosToIntervalosTuples() {
        
        
        
        let arr : [Double] = [1,3,5,6,9]
        let ivTuples = CompoundVAleatoria__.numerosToIntervalosTuples(arr)!
        
      XCTAssert(ivTuples[0].0 == 1 && ivTuples[0].1 == 3)
       XCTAssert(ivTuples[1].0 == 3 && ivTuples[1].1 == 5)
       XCTAssert(ivTuples[2].0 == 5 && ivTuples[2].1 == 6)
        XCTAssert(ivTuples[3].0 == 6 && ivTuples[3].1 == 9)
        XCTAssert(ivTuples.count == 4)
    }
    
    func test_metrizarfuncionmatematica() {
        
        
        let ff = mathFunctions__.curve(.line, po(x: 1,y: 1), po(x: 10,y: 10))
        
        let metr = CompoundVAleatoria__.metrizarfuncionmatematica(ff, stepm: 0.5, upBounds: 10, lowBounds: 1)
        
        
        XCTAssert(metr.stepMinim == 0.5 && metr.bounds.0 == 1 && metr.bounds.1 == 10)
        
        
    }
    
    
    
    func test_funcintervabilizada() {
        
        let arr : [Double] = [1,3,5,6,9]
        
        
        let ff = mathFunctions__.curve(.line, po(x: 1,y: 1), po(x: 10,y: 10))
        let metr = CompoundVAleatoria__.metrizarfuncionmatematica(ff, stepm: 0.5, upBounds: 10, lowBounds: 1)
        
        let finv = CompoundVAleatoria__.funcintervabilizada(metr) {($0 + $1)/2    }
        
        
        
        let arpr : [Double] = [finv(1)!,finv(1.2)!,finv(1.5)!,finv(1.75)!,finv(10)!]
        let res = [1.25,1.25,1.75,1.75,9.75]
        
        
      
        
        
        XCTAssertEqual(arpr, res)
        XCTAssert(finv(0.5) == nil && finv(10.01) == nil)
        
        
        
    }
    
    
    func test_concatenateIntervWtihLines() {
        
        let intervSingle: [(Double,Double)] = [(3,2),(8,12),(38,27),(78,107)    ]
        
        guard let f = CompoundVAleatoria__.concatenateIntervWtihLines(intervSingle, stepm: 0.5) else {return }
        
        
        
        let matRres: [Double?]=[f[0].generat(3), f[0].generat(5), f[1].generat(8) , f[1].generat(20),f[2].generat(38),f[2].generat(60),f[2].generat(78),f[2].generat(80)   ]
        
        let matRresSucc : [Double? ] = [2,6,12,18,27,71,107,.none     ]
        
       
        XCTAssert(matRres[0] == matRresSucc[0] )
        XCTAssert(matRres[1] == matRresSucc[1] )
        XCTAssert(matRres[2] == matRresSucc[2] )
        XCTAssert(matRres[3] == matRresSucc[3] )
        XCTAssert(matRres[4] == matRresSucc[4] )
        XCTAssert(matRres[5] == matRresSucc[5] )
       // XCTAssert(matRres[6] == matRresSucc[6] )
        
        let g = CompoundVAleatoria__.concatenateIntervWtihLines([(1,1)], stepm: 0.5)
        XCTAssert(g == nil)
        
    }
    
    
    func test_fde() {
        
        let intervSingle: [(Double,Double)] = [(3,2),(8,12),(38,27),(78,107)    ]
        
        guard let f = CompoundVAleatoria__.concatenateIntervWtihLines(intervSingle, stepm: 0.5) else {return }
        
        let comp = CompoundVAleatoria(funcs_: f)
        
        let r = CompoundVAleatoria__.fde(f)
        let res1 = r <> 4
        let res2 = r <>  8
       let res3 = r <>  10
        let res4 = r <>  38
        let res5 = r <>  78.01
        let res6 = r <>  2.90
        
        XCTAssert(res5 == nil)
        XCTAssert(res6 == nil)
        XCTAssert(res1 == 4.50)
        XCTAssert(res2 == 12.125)
        XCTAssert(res3 == 13.125)
        XCTAssert(res4 == 27.5)
        
        
        //let otrosRes = []
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
    
    

