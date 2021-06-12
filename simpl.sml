//Crear una funcion que por orden vaya aplicando y que devuelva la mas corta?

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

//Usar como filtros

fun neutro(prop,prop1,prop2) =
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
;
                   
----------------------------------------------------------------

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

----------- Reglas ---------------

fun neutroC prop prop1 prop2 = 
       case prop1 of constante cons1 => 
       if cons1 then prop2 else 
              case prop2 of constante cons2 =>
              if cons2 then prop1 else prop
;

fun neutroD prop prop1 prop2 = 
       case prop1 of constante cons1 => 
       if cons1 = false then prop2 else 
              case prop2 of constante cons2 =>
              if cons2 = false then prop1 else prop
;

fun dominacionC prop prop1 prop2 = 
       case prop1 of constante cons1 => 
       if cons1 then constante(false) else 
              case prop2 of constante cons2 =>
              if cons2 then constante(false) else prop
;

fun dominacionD prop prop1 prop2 = 
       case prop1 of constante cons1 => 
       if cons1 = false then constante(true) else 
              case prop2 of constante cons2 =>
              if cons2 = false then constante(true) else prop
;


-------- Agrupaciones -------------
fn reglasDisyunciones prop1 prop2 => neutroD inversoD dominacionD prop1,prop2; 
fn reglasConjunciones prop1 prop2 => neutroC inversoC dominacionC prop1,prop2;
fn reglasImplicaciones prop1 prop2 => contrapositiva impdis prop1,prop2;
fn reglasNegaciones prop => demorgan prop;     

-------- Evaluador de forma -----------
--Voy a tener que probar en las internas si existe
fun evaluadorDeForma prop = 
       case prop of  variable var => prop
                     |constante cons => prop 
                     |negacion prop1 => reglasNegaciones prop
                     |disyuncion (prop1,prop2)=> reglasDisyunciones prop1,prop2
                     |conjuncion (prop1,prop2)=> reglasConjunciones prop1,prop2
                     |implicacion (prop1,prop2) => reglasImplicaciones prop1,prop2
;
 