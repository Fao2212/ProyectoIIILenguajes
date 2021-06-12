(*//Crear una funcion que por orden vaya aplicando y que devuelva la mas corta?

//Recibo una proposicion
//Se tiene que simplificar
//Cambia la forma de 

//Empiezo por recordar como funciona la simplificacion. Necesito los valores?
//Cuando recuerdo las reglas voy haciendo una de las reglas una por una

Neutro P o FALSO / FALSO o P
       P y VERDADERO  / VERDADERO ^ P  = P

INVERSO P o NO(P) / NO(P) o P = VERDADERO
       P y NO(P) / NO(P) y P = FALSO

DOMINACION P y FALSO / FALSO y P = FALSO
            P o VERDADERO / VERDADERO o P = VERDADERO

//Recibe una proposicion y devuelve una proposicion con los valores 

//Tengo que evaluar?

//Usar como filtros*)

(*fun neutro(prop,prop1,prop2) =
    let 
    val prop1Value = evalProp(prop1)
    val prop2Value = evalProp(prop2)
    in
        case prop1Value of false => prop2|
                           true =>
                           case prop2Value of false => prop1|
                                    true => prop
    end
;

fun neutro(prop,prop1,prop2) =
    let 
    val prop1Value = prop1
    val prop2Value = prop2
    in
        if prop1Value then if prop2Value then prop else prop1 else prop2
    end
;


fun test a = 
       let
       val p = a
       val c = 0
       in
              if p>c then if c > 0 then "buajj" else "bombo" else "lmao"
       end
;*)
                   
(*----------------------------------------------------------------

Reconsiderarando
Necesito un evaluador de forma
Cuando identifico la forma entonces evaluo los parametros.
Los valores que me importan dependen de la regla
Las reglas son evaluadores de las partes de las proposiciones

//Agrupando reglas
Disyunciones
       -Neutro       
       -Inverso
       -Domincaion
Conjunciones
       -Neutro
       -Inverso
       -Dominacion
Implicaciones
       -Contrapositiva
       -Imp/Dis
Negaciones
       -DeMorgan

--Para el evaluador de forma solo vamos a necesitar 4 casos
       --Para el evaluador de casos cada uno tendra sus reglas asociadas
              --Las reglas se evaluaran a la prop aplicandose o retornando el valor original

----------- Reglas ---------------*)
(* P ^ P *)
fun neutroC (prop,prop1,prop2) = 
       case prop1 of
              constante cons1 => 
                     if cons1 then prop2 else prop
              | variable var =>
                     let in
                            case prop2 of 
                                   constante cons2 =>
                                          if cons2 then prop1 else prop
                                   | _ => prop
                     end
              | _ => prop
;

fun neutroD (prop,prop1,prop2) = 
       case prop1 of
              constante cons1 => 
                     if not cons1 then prop2 else prop
              | variable var =>
                     let in 
                            case prop2 of 
                                   constante cons2 =>
                                          if not cons2 then prop1 else prop
                                   | _ => prop
                     end
              | _ => prop
;

fun dominacionC(prop,prop1,prop2) = 
       case prop1 of 
           constante cons1 => 
              if not cons1 then constante(false) 
              else prop      
         | variable var => 
              case prop2 of 
                constante cons2 => 
                     if not cons2 then constante(false) 
                     else prop
         | _   => prop
;

fun dominacionD (prop,prop1,prop2) = 
       case prop1 of 
           constante cons1 => 
              if cons1 then constante(true) 
              else prop      
         | variable var => 
              case prop2 of 
                constante cons2 => 
                     if cons2 then constante(true) 
                     else prop
         | _  => prop
;

(*Tengo dos prop
--Solo se aplica si una es variable y otra negacion
--Y si la negacion es igual a la prop1 entonces se retorna constante(false/true)*)
(* -P ^  *)
fun inversoC (prop,prop1,prop2) =
       case prop1 of 
              variable var1 => 
                     let in 
                            case prop2 of 
                                   negacion neg1 =>
                                   if neg1 = prop1 then  
                                          constante(false) 
                                   else prop
                            | _ => prop
                     end
       |      negacion neg2  => 
                     let in 
                            case prop2 of 
                                   variable _ =>
                                   if neg2 = prop2 then 
                                          constante(false) 
                                   else prop
                            | _ => prop
                     end
       | _ => prop
;

fun inversoD (prop,prop1,prop2) =
       case prop1 of 
              variable var1 => 
                     let in 
                            case prop2 of 
                                   negacion neg1 =>
                                   if neg1 = prop1 then  
                                          constante(true) 
                                   else prop
                            | _ => prop
                     end
       |      negacion neg2  => 
                     let in 
                            case prop2 of 
                                   variable _ =>
                                   if neg2 = prop2 then 
                                          constante(true) 
                                   else prop
                            | _ => prop
                     end
       | _ => prop
;

(*Una sola prop
-- Ya se sabe que prop es una negación porque viene desde reglasNegacion
--si es una negacion entonces 
--devuelva lo de adentro
*)
fun dobleNegacion prop = (*Completar*)
       case prop of negacion var => var
       | _ => prop
; 

(*Si la prop que recibimos son 2 Proporsiciones
  Donde la primera y la segunda tienen que ser negaciones
  Y se devuelva la operacion contrararia(valordenegacion1,valordenegacion2)*)
fun demorganC (prop,prop1,prop2)= 
       case prop1 of
              negacion p1 =>
                     let in
                            case prop2 of
                                   negacion p2 => negacion(disyuncion(p1,p2))
                            | _ => prop
                     end
       | _ => prop
;

fun demorganD (prop,prop1,prop2) = 
       case prop1 of 
              negacion p1 =>
                     let in
                            case prop2 of 
                                   negacion p2 => negacion(conjuncion(p1,p2))
                            | _ => prop
                     end
       | _ => prop
;


(*-------- Agrupaciones -------------*)

(* fun aplicarReglas (f:Proposicion -> Proposicion -> Proposicion -> Proposicion) = fn (prop:Proposicion) => fn (prop1: Proposicion) => fn (prop2:Proposicion) => f prop prop1 prop2; *)
fun reglasDisyunciones (prop, prop1, prop2) = demorganD (
                                                        neutroD (
                                                               inversoD (
                                                                         dominacionD (
                                                                                      prop, 
                                                                                      prop1, 
                                                                                      prop2
                                                                                     ), 
                                                                      prop1, 
                                                                      prop2
                                                                      ),
                                                               prop1, 
                                                               prop2
                                                               ), 
                                                        prop1, 
                                                        prop2
                                                        ); 
fun reglasConjunciones (prop, prop1, prop2) = demorganC (
                                                        neutroC (
                                                               inversoC (
                                                                      dominacionC(prop,prop1,prop2),prop1,prop2),prop1,prop2),prop1,prop2);
fun reglasNegaciones prop = dobleNegacion prop;     

(*-------- Evaluador de forma -----------
--Voy a tener que probar en las internas si existe
--Falta la recursion*)

fun evaluadorDeForma prop = 
       case prop of  variable var => prop
                     |constante cons => prop 
                     |negacion prop1 => evaluadorDeForma (reglasNegaciones prop1)
                     |disyuncion (prop1,prop2)=> evaluadorDeForma (reglasDisyunciones (prop, prop1, prop2))
                     |conjuncion (prop1,prop2)=> evaluadorDeForma (reglasConjunciones (prop, prop1, prop2))
                     |implicacion (prop1,prop2) => 
                            let val p = (evaluadorDeForma prop1) and q = (evaluadorDeForma prop2) 
                            in p :=>: q end
                     |equivalencia (prop1,prop2) =>
                            let val p = (evaluadorDeForma prop1) and q = (evaluadorDeForma prop2) 
                            in p :<=>: q end
;
