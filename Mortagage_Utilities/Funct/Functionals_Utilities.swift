//
//  Functionals_Utilities.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 24/10/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation


//  Mix.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 24/10/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//



precedencegroup gr {
    associativity : left
    
    
}


infix operator <&> : gr
//infix operator <!> : gr
//infix operator <*> : gr
infix operator <==> : gr //map
infix operator ++++ : gr // suma dictionable resultable , lso values se amontonan en un array
infix operator ++ : gr

//infix operator <-> : gr  //monad
//infix operator <*> : gr // aplicative



func <&> < A , B > ( f:  (A) ->B,x: A ) -> B {return f(x)}

func <&> < A , B > (x:A, f:  (A) ->B ) -> B {return f(x)}

func <&> <A,B,C> ( f:@escaping (A) -> B ,g:@escaping  (B) -> C  ) -> ((A) ->C) {return { a in return g( f( a ) )}}


func <==> <A,B> ( x: [A] , f: @escaping (A) -> B ) -> [B] { return x.map(f)         }
func <==> <A,B> ( f: @escaping (A) -> B,x: [A]  ) -> [B] { return x.map(f)         }






func map <A,B> (_ f:@escaping (A) -> B) -> ([A]) -> [B] { return { xs in return xs.map{ f($0)} }}
func filter <A> (_ p : @escaping (A) -> Bool ) -> ([A]) -> [A] {return { xs in return xs.filter{p($0)} }}
func reduce <A,B> (_ initial: B , _ reducer: @escaping (B,A) -> B)->  (([A])-> B ) {return { xs in xs.reduce( initial  ,reducer  )    }}
func take<A> (_ n : Int ) -> ([A]) -> [A] {return { xs in xs.reduce([]) { acc, x in acc.count < n ? acc + [x] : acc   }}}
func flatmap <A,B> (_ f:@escaping (A) -> B) -> ([A]) -> [B] { return { xs in return xs.flatMap{ f($0)} }}

//-----------------compares

func betWeen(_ lowV : Double, _ upVal : Double) ->(Double) -> Bool {
    
    
    return { val  in
        
        if( (val >= lowV ) && (val < upVal)) {return true}
        
        return false
        
        
    }
    
    
    
}






//future_____________

final class Future<A> {
    
    let f:(@escaping (A) -> ()) -> ()
    
    init(_ f_ : @escaping  (@escaping (A) -> ()) -> ()){ self.f = f_}
    func onResult( _ callback: @escaping (A) -> () ) { self.f(callback)      }
    
    func map<B> ( _ g: @escaping (A) -> B) -> Future<B> {
        
        return Future<B> { f in self.onResult{ x in f(g(x)) }  }
    }
    func flatmap<B> ( _ g: @escaping (A) -> Future<B>) -> Future<B> {
        
        return Future<B> { f in self.onResult{ x in g(x).onResult(f) }  }
    }
    
    
    
    
    
    
}

//func <*> <A,B> (f: Future<(A) -> B>, x:Future<A> ) -> Future<B> {
    
//    return f.flatmap{  f in x.map{  x in f(x)  }     }
    
//}
func pure<A> (_ x:A) -> Future<A> {
    return Future <A> {f in f(x)}
}


let resultado  = Future<Int>.onResult



let compute : () -> (Int) = {Array(1...200).reduce(0 , +)}

//Future <Int> { f in   let comp = compute()  ;  f(comp)      }

//    .map{ String($0 + 1)  }
//    .onResult{print($0)}







func delayed<A> (_ x:A) -> Future<A> {
    
    return Future<A> { f in
        print("delaying....")
        DispatchQueue.main.asyncAfter(deadline: .now()  + 1 ) {
            print("Done ¡¡¡")
            f(x)
        }
    }
}

func memoize <T:Hashable,U> (_ fn: @escaping (T) -> U) -> (T) -> U {
    
    var cache = [T:U]()
    
    return { (val:T) -> U in
        
        if cache.index(forKey: val) == nil { cache[val] = fn(val)}
        return cache[val]!
        
        
        
        
    }
    
}

extension Array where Iterator.Element == Double {

    func reduceConcatInArray(_ indexStart: Double, _ inFunctraverse :@escaping  ((Double , Double)) -> Double  )-> Array<Double> {


        let toR : Array<Double> = self.reduce(into: []) { arrAcum , elem in
        
        let last = arrAcum.last ?? indexStart
        let to = inFunctraverse( (elem , last) )
        arrAcum.append(to)
        
        
        }
        return toR
    

    
    
        }
}


func twoDouToDouCurri( _ f: @escaping (Double , Double) -> Double  ) -> (Double) -> (Double) -> Double {
    return {n in  return { x in   f(n,x)        }
    }}


func TodosIguales<A: Numeric> ( _ arrDou: [A])-> Bool  {
    
    
    let sameArray = arrDou
    
   let elem = arrDou.first!
    
    let d = arrDou <==> {($0 == elem)}
    
    let red = d.reduce(true) { ($0 && $1)       }
    
    return red
    
    
}

func BoolToInt(_ d : Bool) -> Int {
    
    switch d {
    case true:
        return 1
    case false:
        return 0
    }
    
    
}
