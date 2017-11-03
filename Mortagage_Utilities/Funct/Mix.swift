import Foundation



// añadir el (0)porcen%(tanto por uno) al siguiente(1)
func porcentAddable( _ pair: ( Double, Double) ) ->(Double)   {
return  (  (  (pair.0 / 100) + 1   ) * pair.1  )}

