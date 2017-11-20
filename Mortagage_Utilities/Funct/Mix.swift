import Foundation



// añadir el (0)porcen%(tanto por uno) al siguiente(1)
func porcentAddable( _ pair: ( Double, Double) ) ->(Double)   {
return  (  (  (pair.0 / 100) + 1   ) * pair.1  )}

func glueDicts<A,B>( _ dictOne : Dictionary<A,B>) -> (Dictionary<A,B>) -> Dictionary<A,B> {
    
    return {  otherDict in  dictOne.merging(otherDict){ (a,_) in  a } }
    
    
    
}

let CatchKeysInArray :(WaysOfIndexes) -> Array<String>   = {wa in Array(wa.ways.keys) }

let CogeDelDictDeLosIndexEsto :  (waysOfInd) -> (Int) -> (Int) ->(String)-> Double? = { way  in
    return  { nFirst  in { nSecond in {str in
        guard let elem = way[str]?[nFirst][nSecond] else {return nil}
        return elem
        }}}}

func  CreaDictionaryCOnEStosArrays<A,B> (fir : [A], sec: [B]) -> Dictionary<A,B> {
    
    var dic :Dictionary<A,B> = [:]
    
    
    let une = zip(fir,sec).map{dic[$0] = $1}
    
    return dic
    
}

let creaDictConesteArrayStringYesteDOuble : ([String]) -> ([Double?]) -> [String:Double?] = { strArr in {
    douArray in CreaDictionaryCOnEStosArrays(fir: strArr, sec: douArray)
    }
    
    
}

 func contiene_algun_nil<A>( _ arr:[Optional<A> ]) -> Bool  {if (arr.contains(where: {$0 == nil  })) {return true} else {return false}}

func changelastElementOfAArray<A> ( arr:[A]) -> ((A) -> A) -> [A]? {
   
    return { f in
    guard let lasElement = arr.last  else {return nil}
    
    var newElement = f(lasElement)
   
     var newArr = arr
        newArr.removeLast()
    
    newArr.append(newElement)
    
        return newArr}
    
}

let pasosIntroNewInter = 0.01

