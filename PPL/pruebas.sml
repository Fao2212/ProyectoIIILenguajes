(* Variables para las pruebas *)

val f = constante false
val t = constante true

val pru1 = 	(variable "p") :=>: (variable "q") ;
val pru2 = (constante true) :=>: (variable "q") ;
val pru3 = (variable "p") :=>: ((variable "q") :=>: (variable "q")) ;
val pru4 = t :=>: f ;
val pru5 = f :=>: t ;

val vp = variable "p" ;
val vq = variable "q" ;

val pru6 = vp :&&: vq :=>: vq :||: vp ; (* SÍ es una tautología *)
val pru7 = vq :||: vp :=>: vp :&&: vq ; (* NO es una tautología *)

(* Variables para pruebas sobre fnd *)

(* Casos de proposiciones solo con constantes *)
val pru_cons_fnd_1 = constante false; (* Esperado: constante false *)
val pru_cons_fnd_2 = constante true; (* Esperado: constante true *)
val pru_cons_fnd_3 = ~:(constante false); (* Esperado: constante true *)
val pru_cons_fnd_4 = ~:(constante true); (* Esperado: constante false *)
val pru_cons_fnd_5 = (constante true) :||: (constante true); (* Esperado: constante true *)
val pru_cons_fnd_6 = (constante true) :||: (constante false); (* Esperado: constante true *)
val pru_cons_fnd_7 = (constante false) :||: (constante true); (* Esperado: constante true *)
val pru_cons_fnd_8 = (constante false) :||: (constante false); (* Esperado: constante false *)
val pru_cons_fnd_9 = (constante true) :&&: (constante true); (* Esperado: constante true *)
val pru_cons_fnd_10 = (constante true) :&&: (constante false); (* Esperado: constante false *)
val pru_cons_fnd_11 = (constante false) :&&: (constante true); (* Esperado: constante false *)
val pru_cons_fnd_12 = (constante false) :&&: (constante false); (* Esperado: constante false *)
val pru_cons_fnd_13 = (constante true) :=>: (constante true); (* Esperado: constante true *)
val pru_cons_fnd_14 = (constante true) :=>: (constante false); (* Esperado: constante false *)
val pru_cons_fnd_15 = (constante false) :=>: (constante true); (* Esperado: constante true *)
val pru_cons_fnd_16 = (constante false) :=>: (constante false); (* Esperado: constante true *)
val pru_cons_fnd_17 = (constante true) :<=>: (constante true); (* Esperado: constante true *)
val pru_cons_fnd_18 = (constante true) :<=>: (constante false); (* Esperado: constante false *)
val pru_cons_fnd_19 = (constante false) :<=>: (constante true); (* Esperado: constante false *)
val pru_cons_fnd_20 = (constante false) :<=>: (constante false); (* Esperado: constante true *)

(* Casos de proposiciones que son contradicciones *)
val pru_contr_fnd_1 = ((variable "p") :||: (variable "q")) :<=>: (~:((variable "p") :||: (variable "q")));
val pru_contr_fnd_2 = (variable "p") :&&: (~:(variable "p"));
val pru_contr_fnd_3 = ((variable "p") :||: (variable "q")) :&&: ((~:(variable "p")) :&&: ((~:(variable "q"))));

(* Casos de proposiciones con al menos una variable y que no son contradicciones *)
val pru_taut_fnd_1 = (~:((variable "p") :=>: (variable "q"))) :<=>: ((variable "p") :&&: (~:(variable "q")));
val pru_taut_fnd_2 = ((variable "p") :||: (variable "q")) :=>: ((variable "q") :=>: ((variable "p") :||: (variable "q")));
val pru_taut_fnd_3 = ((variable "p") :||: (variable "q")) :||: ((~:(variable "p")) :&&: ((~:(variable "q"))));
val pru_contin_fnd_1 = (variable "r") :=>: ( ((~:(variable "p")) :||: (variable "q")) :&&: ((variable "p") :&&: (~:(variable "q"))));
val pru_contin_fnd_2 = (((variable "p") :=>: (variable "q")) :=>: (variable "r")) :<=>: (((variable "p") :&&: (~:(variable "r"))) :=>: (~:(variable "q")));
val pru_contin_fnd_3 = ((~:((~:(variable "p")) :&&: (variable "r"))) :||: (variable "q")) :<=>: (((~:(variable "p")) :||: (variable "r")) :&&: (variable "q"));

(* Variables para pruebas sobre simpl y otras*)

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

(* Instrucciones de pruebas *)

(* Pruebas para vars *)
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
val g2 = [true,false];
val g3 = [true,false,true];

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


(* Pruebas eval_prop *)
val amb1 = [("p", true), ("q", true)];
val amb2= [("p", true), ("q", false)];
val amb3 = [("p", false), ("q", true)];
val amb4 = [("p", false), ("q", false)];

evalProp amb1 compl2; (* Resultado esperado: false *)
evalProp amb2 compl2; (* Resultado esperado: false *)
evalProp amb3 compl2; (* Resultado esperado: false *)
evalProp amb4 compl2; (* Resultado esperado: false *)
evalProp amb1 compl4; (* Resultado esperado: false *)
evalProp amb2 compl4; (* Resultado esperado: false *)
evalProp amb3 compl4; (* Resultado esperado: false *)
evalProp amb4 compl4; (* Resultado esperado: false *)
evalProp amb1 compl5; (* Resultado esperado: true *)
evalProp amb2 compl5; (* Resultado esperado: true *)
evalProp amb3 compl5; (* Resultado esperado: true *)
evalProp amb4 compl5; (* Resultado esperado: false *)

(* Pruebas taut *)

taut pru_taut_fnd_1;
taut pru_taut_fnd_2;
taut pru_taut_fnd_3;
taut prop1;
taut prop10;
taut prop16;
taut megaNeg;
taut eqComp;
taut eqCompDoble;
taut impComp;
taut compl3;
taut compl4;

(* Pruebas bonita *)
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

bonita (fnd pru_cons_fnd_1);
bonita (fnd pru_cons_fnd_2);
bonita (fnd pru_cons_fnd_3);
bonita (fnd pru_cons_fnd_4);
bonita (fnd pru_cons_fnd_5);
bonita (fnd pru_cons_fnd_6);
bonita (fnd pru_cons_fnd_7);
bonita (fnd pru_cons_fnd_8);
bonita (fnd pru_cons_fnd_9);
bonita (fnd pru_cons_fnd_10);
bonita (fnd pru_cons_fnd_11);
bonita (fnd pru_cons_fnd_12);
bonita (fnd pru_cons_fnd_13);
bonita (fnd pru_cons_fnd_14);
bonita (fnd pru_cons_fnd_15);
bonita (fnd pru_cons_fnd_16);
bonita (fnd pru_cons_fnd_17);
bonita (fnd pru_cons_fnd_18);
bonita (fnd pru_cons_fnd_19);
bonita (fnd pru_cons_fnd_20);

bonita (fnd pru_taut_fnd_1);
bonita (fnd pru_taut_fnd_2);
bonita (fnd pru_taut_fnd_3);
bonita (fnd pru_contin_fnd_1);
bonita (fnd pru_contin_fnd_2);
bonita (fnd pru_contin_fnd_3);
bonita (fnd pru_contr_fnd_1);
bonita (fnd pru_contr_fnd_2);
bonita (fnd pru_contr_fnd_3);

bonita (fnd pru1);
bonita (fnd pru2);
bonita (fnd pru3);
bonita (fnd pru4);
bonita (fnd pru5);
bonita (fnd pru6);
bonita (fnd pru7);
bonita (fnd prop1);
bonita (fnd prop2);
bonita (fnd prop3);
bonita (fnd prop4);
bonita (fnd prop5);
bonita (fnd prop6);
bonita (fnd prop7);
bonita (fnd prop8);
bonita (fnd prop9);
bonita (fnd prop10);
bonita (fnd prop11);
bonita (fnd prop12);
bonita (fnd prop13);
bonita (fnd prop14);
bonita (fnd prop15);
bonita (fnd prop16);
bonita (fnd megaNeg);
bonita (fnd eqComp);
bonita (fnd eqCompDoble);
bonita (fnd impComp);
bonita (fnd compl1);
bonita (fnd compl2);
bonita (fnd compl3);
bonita (fnd compl4);
bonita (fnd compl5);
bonita (fnd compl6);
bonita (fnd compl7);
bonita (fnd compl8);

(*Pruebas simpl*)

bonita (simpl pru1);
bonita (simpl pru2);
bonita (simpl pru3);
bonita (simpl pru4);
bonita (simpl pru5);
bonita (simpl pru6);
bonita (simpl pru7);
bonita (simpl prop1);
bonita (simpl prop2);
bonita (simpl prop3);
bonita (simpl prop4);
bonita (simpl prop5);
bonita (simpl prop6);
bonita (simpl prop7);
bonita (simpl prop8);
bonita (simpl prop9);
bonita (simpl prop10);
bonita (simpl prop11);
bonita (simpl prop12);
bonita (simpl prop13);
bonita (simpl prop14);
bonita (simpl prop15);
bonita (simpl prop16);
bonita (simpl megaNeg);
bonita (simpl eqComp);
bonita (simpl eqCompDoble);
bonita (simpl impComp);
bonita (simpl compl1);
bonita (simpl compl2);
bonita (simpl compl3);
bonita (simpl compl4);
bonita (simpl compl5);
bonita (simpl compl6);
bonita (simpl compl7);
bonita (simpl compl8);