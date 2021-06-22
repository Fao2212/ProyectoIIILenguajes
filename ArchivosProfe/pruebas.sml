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
val compl8 = (~:((variable "p") :&&: (variable "p"))) :=>: (~: ( (~:(variable "r")) :&&: (~:(variable "q"))));

(*Pruebas vars*)

vars pru1;
vars pru2;
vars pru4;
vars pru7;
vars prop8;
vars prop15;
vars eqComp;
vars compl1;
vars compl4;
vars compl8;
(*Pruebas gen_bools*)

gen_bools 0;
gen_bools 1;
gen_bools 2;
gen_bools 3;
gen_bools 4;

(*Pruebas as_vals*)

val g2 = [true,false]
val g3 = [true,false,true]

val pru = vars pru1;
val av1 = as_vals pru g2;

val pru = vars pru2;
val av2 = as_vals pru g2;

val pru = vars pru4;
val av3 = as_vals pru g2;

val pru = vars pru7;
val av4 = as_vals pru g2;

val pru = vars prop8;
val av5 = as_vals pru g2;

val pru = vars prop15;
val av6 = as_vals pru g2;

val pru = vars eqComp;
val av7 = as_vals pru g2;

val pru = vars compl1;
val av8 = as_vals pru g3;

val pru = vars compl4;
val av9 = as_vals pru g2;

val pru = vars compl8;
val av10 = as_vals pru g2;


(*Pruebas eval_prop*)

evalProp av1 pru1; (*Sientase libre de cambiar las pruebas que quiera. Algunas no funcionan porque eran errores de las pruebas de e*)
evalProp av4 pru7;
evalProp av6 prop15;
evalProp av8 compl1;
evalProp av9 compl4;

(*Pruebas bonita*)

bonita pru1;
bonita pru2;
bonita pru3;
bonita pru4;
bonita pru5;
bonita pru6;
bonita pru7;
bonita prop1;
bonita prop2;
bonita prop3;
bonita prop4;
bonita prop5;
bonita prop6;
bonita prop7;
bonita prop8;
bonita prop9;
bonita prop10;
bonita prop11;
bonita prop12;
bonita prop13;
bonita prop14;
bonita prop15;
bonita prop16;
bonita megaNeg;
bonita eqComp;
bonita eqCompDoble;
bonita impComp;
bonita compl1;
bonita compl2;
bonita compl3;
bonita compl4;
bonita compl5;
bonita compl6;
bonita compl7;
bonita compl8;


(*Pruebas fnd*)

fnd pru1;
fnd pru2;
fnd pru3;
fnd pru4;
fnd pru5;
fnd pru6;
fnd pru7;
fnd prop1;
fnd prop2;
fnd prop3;
fnd prop4;
fnd prop5;
fnd prop6;
fnd prop7;
fnd prop8;
fnd prop9;
fnd prop10;
fnd prop11;
fnd prop12;
fnd prop13;
fnd prop14;
fnd prop15;
fnd prop16;
fnd megaNeg;
fnd eqComp;
fnd eqCompDoble;
fnd impComp;
fnd compl1;
fnd compl2;
fnd compl3;
fnd compl4;
fnd compl5;
fnd compl6;
fnd compl7;
fnd compl8;

(*Pruebas simpl*)

simpl pru1;
simpl pru2;
simpl pru3;
simpl pru4;
simpl pru5;
simpl pru6;
simpl pru7;
simpl prop1;
simpl prop2;
simpl prop3;
simpl prop4;
simpl prop5;
simpl prop6;
simpl prop7;
simpl prop8;
simpl prop9;
simpl prop10;
simpl prop11;
simpl prop12;
simpl prop13;
simpl prop14;
simpl prop15;
simpl prop16;
simpl megaNeg;
simpl eqComp;
simpl eqCompDoble;
simpl impComp;
simpl compl1;
simpl compl2;
simpl compl3;
simpl compl4;
simpl compl5;
simpl compl6;
simpl compl7;
simpl compl8;