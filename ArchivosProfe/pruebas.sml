(* pruebas con constantes *)

val f = constante false
val t = constante true

val prop2 = f :=>: f :<=>: ~: f :||: f
val prop1 = f :=>: f :<=>: ~: f :=>: ~: f
;

val p = f;
val q = t;

val prop3 = p :=>: q :<=>: ~: p :||: q
val prop4 = p :=>: q :<=>: ~: q :=>: ~: p
;

(* pruebas *)

val pru1 = 	(variable "p") :=>: (variable "q") ;
val pru2 = (constante true) :=>: (variable "q") ;
val pru3 = (variable "p") :=>: ((variable "q") :=>: (variable "q")) ;
val pru4 = t :=>: f ;
val pru5 = f :=>: t ;

val vp = variable "p" ;
val vq = variable "q" ;

val pru6 = vp :&&: vq :=>: vq :||: vp ; (* SÍ es una tautología *)
val pru7 = vq :||: vp :=>: vp :&&: vq ; (* NO es una tautología *)

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
val eqCompDoble = equivalencia(disyuncion(constante false,variable "q"),disyuncion(variable "p",constante false)); (*Resultado: equivalencia(variable "q",variable "p")*)
val impComp = implicacion(disyuncion(constante true, variable "q"),conjuncion(constante false , variable "k")); (*Resultado: implicacion(constante true,constante false)*)
(* CASOS *)
val eq = equivalencia(constante true,constante false); (*eq*)
val compl1 = ((variable "p") :=>: ~:((variable "q") :||: (variable "r"))) :&&: ((variable "p" :||: constante false)); 
(* Resultado conjuncion(implicacion(variable "p", negacion(variable "q", variable "r *)
val compl2 = ((variable "p") :=>: (variable "q")) :&&: (~:((variable "p") :=>: (variable "q"))) 
(* Resultado: constante false *)
val compl3 = ((variable "p") :=>: (variable "q")) :||: (~:((variable "p") :=>: (variable "q"))) 
(* Resultado: constante true *)
val compl4 = ~:(~:((~:((variable "p"):||:(variable "q"))):&&:((variable "p"):&&:(~:(variable "p")))))
(* Resultado: constante false *)
val compl5 = ~:( (~:(variable "p")) :&&: (~:((variable "q") :||: (variable "p"))) )
(* Resultado: disyuncion(variable "p", disyuncion(variable "q", variable "p")) *)
val compl6 = ~:( ( (~:(variable "p")) :&&: (~:(((variable "q") :||: (variable "r")))) ) )
(* Resultado: disyuncion(variable "p", disyuncion(variable "q", variable "r"))) *)
val compl7 = (~:((variable "p") :&&: (constante false))) :=>: (~: ( (~:(variable "r")) :&&: (~:(variable "q"))))