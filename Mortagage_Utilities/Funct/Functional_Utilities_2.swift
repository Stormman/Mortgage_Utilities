//
//  Functional_Utilities_2.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 1/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import Foundation



//composable setter stephen celis

func first<A,B>( _ f: @escaping(A) -> A) -> ((A,B)) -> (A,B) {
    
    return { pair in return (f(pair.0),pair.1)}
    
    
}
func first<A,B,C >( _ f: @escaping(A) -> C) -> ((A,B)) -> (C,B) {
    
    return { pair in return (f(pair.0),pair.1)}
    
    
}
func second<A,B>( _ f: @escaping(B) -> B) -> ((A,B)) -> (A,B) {
    
    return { pair in return (pair.0,f(pair.1))}
    
    
}
func second<A,B,C >( _ f: @escaping(B) -> C) -> ((A,B)) -> (A,C) {
    
    return { pair in return ((pair.0,f(pair.1)))}
    
    
}

//da error no funciona
func prop<Root,Value>(_ keyPath: WritableKeyPath<Root,Value>)
-> (@escaping (Value) -> Value)
-> (Root)
    -> Root {

        return { update in
            { root in
                var copy = root
                copy[keyPath: keyPath] = update(copy[keyPath:keyPath])
            
                return copy
                
            }
            
        }
        
        
}


// result da error muy raro posblemten un bug

enum Result<A> {
    
    case succes(A)
    case failure(String )
    
    func map<B> ( _ f: (A) -> B) -> Result<B> {
        switch self {
            case let .succes(x): return .succes(f(x))
            case let .failure(e): return .failure(e)
            
        }
    }
    
    func flatMap<B> ( _ f: (A) -> Result<B> ) -> Result<B> {
        switch self {
        case let .succes(x): return f(x)
        case let .failure(e): return .failure(e)
            
        }
    }
    
    
    
    
}

func map <A,B> (_ f:@escaping (A) -> B) -> (Result<A>) -> Result<B> { return { xs in return xs.map{ f($0)} }}

func pure<A> (_ x:A) -> Result<A> {
    
    return Result.succes(x)
    
    
}

func <=> <A,B> ( x: Result<A>  , f: @escaping (A) -> B ) -> Result<B>  { return x.map(f)         }
func <=> <A,B> ( f: @escaping (A) -> B,x: Result<A>   ) -> Result<B>  { return x.map(f)         }

/*

func value_< A,B > ( _ f: @escaping (A) -> B)-> (Result< A>) -> Result<B> {
    
    return { result in
        
        switch result {
            
        case let .succes(succes):
            return .succes(f(succes ))
            
        case let .failure(failure):
            return .failure(failure )
            
            
        }
        
    }
}
*/

//-----------------------------------------------------------



