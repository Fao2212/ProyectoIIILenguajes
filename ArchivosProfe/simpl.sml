
(*------------- Reglas ---------------*)

fun evaluadorDeForma prop = prop;

fun dominacionC (prop, prop1, prop2) = 
    case prop of 
        constante _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   variable _  => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   _           => 
        let 
            val p = case prop1 of 
                        constante cons1 => 
                            if not cons1 then constante(false) else prop      
                        | _ => 
                            let 
                                val q = case prop2 of 
                                            constante cons2 => 
                                                if not cons2 then  constante(false) else  prop
                                            | _ =>  prop (* No pudo simplificar por dominación *)
                            in q end
        in 
            p
        end  
;

fun dominacionD (prop, prop1, prop2) = 
    case prop of
        constante _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   variable  _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   _           => 
        let 
            val p = case prop1 of 
                        constante cons1 => 
                            if cons1 then constante(true) else  prop      
                        | _ => 
                            let
                                val q = case prop2 of 
                                            constante cons2 => 
                                                if cons2 then constante(true) else prop
                                            | _ =>  prop (* No pudo simplificar por dominación *)
                            in q end
        in 
            p
        end  
;

fun neutroC (prop, prop1, prop2) = 
    case prop of
        constante _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   variable _  => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   _           =>
        let
            val p = case prop1 of
                        constante cons1 => 
                            if cons1 then prop2 else prop
                        | _ =>
                            let 
                                val q = case prop2 of 
                                    constante cons2 =>
                                            if cons2 then prop1 else prop
                                    | _ =>  prop (* No pudo simplificar por neutro *)
                            in q end
        in 
            p 
        end   
;

fun neutroD (prop, prop1, prop2) = 
    case prop of 
        constante _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   variable  _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   _           => 
        let 
            val p = case prop1 of
                        constante cons1 => 
                            if not cons1 then prop2 else prop
                        | _ =>
                            let 
                                val q = case prop2 of 
                                        constante cons2 =>
                                                if not cons2 then prop1 else prop
                                        | _ =>  prop (* No pudo simplificar por neutro *)
                            in q end
        in 
            p
        end  
;

fun inversoC (prop, prop1, prop2) =
    case prop of 
        constante _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   variable  _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   _           =>
        let
            val p = case prop1 of 
                       negacion neg1 => if neg1 = prop2 then 
                                            constante(false) 
                                        else prop (* No pudo simplificar por inversos *)
                    |   _            => 
                            let 
                                val q = case prop2 of 
                                        negacion neg2 => if neg2 = prop1 then  
                                                            constante(false) 
                                                         else prop
                                        | _ =>  prop (* No pudo simplificar por inversos *)
                            in q end
        in 
            p 
        end     
;

fun inversoD (prop, prop1, prop2) =
    case prop of 
        constante _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   variable  _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   _           =>
        let
            val p = case prop1 of 
                       negacion neg1 => if neg1 = prop2 then 
                                            constante(true) 
                                        else prop
                    |   _            => 
                            let 
                                val q = case prop2 of 
                                        negacion neg2 => if neg2 = prop1 then  
                                                            constante(true) 
                                                         else prop
                                        | _ =>  prop
                            in q end
        in 
            p 
        end         
;

(* fun dobleNegacion prop = 
    case prop of negacion var1 => var1
    | _ => negacion(prop)
;  *)

fun dobleNegacion prop = 
    case prop of 
        negacion neg1 => 
            let 
                val p = case neg1 of
                            negacion neg2 => neg2
                        |   _ => negacion(neg1)
            in p end
    | _ => prop
; 

(* 
   Si se usa la versión de más específico a más general solo se puede usar al final de la simplificacicón.
   En cambio, si se usa la versión de más general a más específico se puede usar en todo el proceso
   de simplificación
*)
fun negacionConstante prop = 
    case prop of 
        negacion neg => 
        let 
            val p = case neg of
                        constante cons => if cons then constante false else constante true
                    |   _ => prop
        in p end 
    |   _ => prop
;

fun demorganC (prop, prop1, prop2)= 
    case prop of 
        constante _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   variable  _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   _           =>
        let
            val p = case prop1 of
                        negacion p1 =>
                            let
                                val q = case prop2 of
                                            negacion p2 => negacion(disyuncion(p1, p2))
                                        | _ => prop
                            in q end
                    |   _ => prop
        in 
            p
        end  
;

fun demorganD (prop, prop1, prop2) = 
    case prop of
        constante _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   variable  _ => prop (* Ya esta simplificado al máximo, no simplificar más *)
    |   _           =>
        let
            val p = case prop1 of 
                        negacion p1 =>
                            let 
                                val q = case prop2 of 
                                            negacion p2 => negacion(conjuncion(p1, p2))
                                        |   _           => prop
                            in q end
                        | _ => prop
        in 
            p
        end  
;

fun idempotencia (prop, prop1, prop2) = 
    case prop of
        constante _ => prop
    |   variable  _ => prop
    |   _           => 
        let
            val p = if prop1 = prop2 then prop1 else prop
        in p end
;

fun implicacionDisyuncion (prop, prop1, prop2) =
    case prop of
        constante _ => prop
    |   variable _  => prop
    |   _           => 
        let 
            val p = case prop1 of
                        negacion p1 => (p1):||:prop2
                    |   _ => (~:prop1):||:prop2
        in p end
;

fun reglasDisyunciones (prop, prop1, prop2) = demorganD (
                                                         inversoD ( 
                                                                   idempotencia ( 
                                                                                 neutroD (
                                                                                          dominacionD (prop, 
                                                                                                      prop1, prop2), 
                                                                                          prop1, prop2
                                                                                         ),
                                                                                 prop1, prop2
                                                                                ), 
                                                                   prop1, prop2
                                                                  ),
                                                         prop1, prop2);

fun reglasConjunciones (prop, prop1, prop2) = demorganC (
                                                         inversoC ( 
                                                                    idempotencia (
                                                                                  neutroC (
                                                                                           dominacionC (prop, 
                                                                                                        prop1, prop2),
                                                                                           prop1,prop2
                                                                                         ),
                                                                                  prop1, prop2
                                                                                 ),
                                                                    prop1,prop2
                                                                  ),
                                                         prop1, prop2);
                                                         
fun reglasNegaciones prop = dobleNegacion prop;     

fun reglasImplicaciones (prop, prop1, prop2) = implicacionDisyuncion (prop, prop1, prop2);

(* Versión 1: de simplificación más general a más específica *)
fun simpl prop =
let
    fun evaluadorDeForma prop = 
        case prop of 
                     negacion prop1 => reglasNegaciones prop
        |            disyuncion (prop1, prop2) => reglasDisyunciones (prop, prop1, prop2)
        |            conjuncion (prop1, prop2) => reglasConjunciones (prop, prop1, prop2)
        |            implicacion (prop1, prop2) => reglasImplicaciones (prop, prop1, prop2)
        |            _ => prop
    
    val resultado = evaluadorDeForma prop
    
in 
    (* No pudo simplificar, intente simplificar sus partes internas *)
    if prop = resultado then 
        let
            val p = case prop of 
                    negacion prop1 => 
                        let val p = (simpl prop1)
                        in (~: p) end
                |   disyuncion (prop1, prop2) => 
                        let val p = (simpl prop1) and q = (simpl prop2)
                        in (p :||: q) end
                |   conjuncion (prop1, prop2) => 
                        let val p = (simpl prop1) and q = (simpl prop2)
                        in (p :&&: q) end 
                |   implicacion (prop1, prop2) => 
                        let val p = (simpl prop1) and q = (simpl prop2) 
                        in (p :=>: q) end (* En teoría no ocupa evaluador de forma *)
                |   equivalencia (prop1, prop2) =>
                        let val p = (simpl prop1) and q = (simpl prop2) 
                        in (p :<=>: q) end (* En teoría no ocupa evaluador de forma *)
                |   _ => prop
        in
           evaluadorDeForma p
        end
    else (*Simplificó, pero esta totalmente simplificado ????*)
        simpl (simpl resultado)
end
;

(* Versión 2: de simplificación más específica a más general *)
fun simpl prop =
let
    fun evaluadorDeForma prop = 
        case prop of
                negacion _                 => reglasNegaciones prop
        |       disyuncion (prop1, prop2)  => reglasDisyunciones (prop, prop1, prop2)
        |       conjuncion (prop1, prop2)  => reglasConjunciones (prop, prop1, prop2)
        |       implicacion (prop1, prop2) => reglasImplicaciones (prop, prop1, prop2)
        |       _                          => prop
    
in 

    let
        val p = case prop of 
                negacion prop1 => 
                    let val p = evaluadorDeForma (simpl prop1)
                    in evaluadorDeForma (~:p) end
            |   disyuncion (prop1, prop2) => 
                    let val p = evaluadorDeForma (simpl prop1) and q = evaluadorDeForma (simpl prop2)
                    in evaluadorDeForma (p :||: q) end
            |   conjuncion (prop1, prop2) => 
                    let val p = evaluadorDeForma (simpl prop1) and q = evaluadorDeForma (simpl prop2)
                    in evaluadorDeForma (p :&&: q) end 
            |   implicacion (prop1, prop2) => 
                    let val p = evaluadorDeForma (simpl prop1) and q = evaluadorDeForma (simpl prop2) 
                    in evaluadorDeForma (evaluadorDeForma (p :=>: q)) end
            |   equivalencia (prop1, prop2) =>
                    let val p = evaluadorDeForma (simpl prop1) and q = evaluadorDeForma (simpl prop2) 
                    in (p :<=>: q) end (* En teoría no ocupa evaluador de forma *)
            |   _ => evaluadorDeForma prop
    in
        evaluadorDeForma p
    end
end
;

(*  ~ (p&false) => ~ ( ~ r& ~ q) *) 

(* ~ false *)