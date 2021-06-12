(* Pruebas para simpl *)

(* Básicas *)

(* Neutro *)
val prop1 = disyuncion(variable "p", constante false); (* Resultado: variable "p" *)
val prop2 = disyuncion(constante false, variable "p"); (* Resultado: variable "p" *)
val prop3 = conjuncion(variable "p", constante true); (* Resultado: variable "p" *)
val prop4 = conjuncion(constante true, variable "p"); (* Resultado: variable "p" *)

(* Inversos *)
val prop5 = disyuncion(variable "p", negacion (variable "p")); (* Resultado: constante true *)
val prop6 = disyuncion(negacion (variable "p"), variable "p"); (* Resultado: constante true *)
val prop7 = conjuncion(variable "p", negacion (variable "p")); (* Resultado: constante false *)
val prop8 = conjuncion(negacion (variable "p"), variable "p"); (* Resultado: constante false *)

(* Dominacion *)
val prop9 = conjuncion(variable "p", constante false); (* Resultado: constante false *)
val prop10 = conjuncion(constante false, variable "p"); (* Resultado: constante false *)
val prop11 = disyuncion(variable "p", constante true); (* Resultado: constante true *)
val prop12 = disyuncion(constante true, variable "p"); (* Resultado: constante true *)

(* Doble Negación *)
val prop13 = negacion(negacion(variable "p")); (* Resultado: variable "p" *)
val prop14 = negacion(negacion(constante true)); (* Resultado: constante true *)

(* De Morgan *)
val prop15 = conjuncion(negacion(variable "p"), negacion(variable "q")); (* Resultado: negacion(disyuncion(variable "p", variable "q")) *)
val prop16 = disyuncion(negacion(variable "p"), negacion(variable "q")); (* Resultado: negacion(conjuncion(variable "p", variable "q")) *)

(* Complejas *)
val megaNeg = negacion(negacion(negacion(negacion(constante true)))); (* constante true *)
val eqComp = equivalencia(constante true, conjuncion(constante true,variable "p")); (*Resultado: equivalencia(constante true,variable "p")*)
val compl1 = ((variable "p") :=>: ~:((variable "q") :||: (variable "r"))) :&&: ((variable "p" :||: constante false)); (* Resultado conjuncion(implicacion(variable "p", negacion(variable "q", variable "r *)
val eqCompDoble = equivalencia(disyuncion(constante false,variable "q"),disyuncion(variable "p",constante false)); (*Resultado: equivalencia(variable "q",variable "p")*)
val impComp = implicacion(disyuncion(constante true, variable "q"),conjuncion(constante false , variable "k")); (*Resultado: implicacion(constante true,constante false)*)
(* CASOS *)
val eq = equivalencia(constante true,constante false); (*eq*)

