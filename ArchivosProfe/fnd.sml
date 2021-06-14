(* Imprimir la tabla de verdad de una proposición con variables. Autor: Prof. Ingacio Zelaya Trejos*)
fun tabla_verdad prop =
    let
      (* variables de trabajo *)
      val variables = vars prop
      val n = length variables
      val lista_combinaciones_booleanas = gen_bools n
      (* imprimir una fila de la tabla de verdad *)
      fun imprimir_fila vars_bools es_verdadero =
        print ( impr_as_vals vars_bools ^ " === " ^ (if es_verdadero then "true" else "false") ^ "\n" ) 
      (* generar evaluaciones de la proposición*)
      fun recorrer []                  = print "\n"  (* toque final a la impresión; previamente mostramos hileras con el resultado *)
    |   recorrer (fila :: mas_filas) = 
            let
              (* establecer una asociación entre variables y una combinación de valores booleanos (fila) *)
                    val asociacion = as_vals variables fila
                    (* esta asociación constituye un ambiente, o contexto, para evaluar la proposición prop *)
               val resultado_fila = evalProp asociacion prop
                in
                  imprimir_fila  asociacion  resultado_fila (* efecto: imprimir fila y su evaluación *)
                  ;
                  recorrer mas_filas (* continuar el trabajo *)
              end
    in
        recorrer lista_combinaciones_booleanas
    end
;

fun crear_variable_positiva (var, bool) = if bool then variable var else ~:(variable var);

fun fnd prop =
    let
        (* variables de trabajo *)
        val variables = vars prop
        val n = length variables
        val lista_combinaciones_booleanas = gen_bools n
    
        fun tomar_variables_atomicas vars_bools =
            map crear_variable_positiva vars_bools

        fun unir_por_conjuncion [] = constante true
        |   unir_por_conjuncion (head::tail) = if tail = [] then head else head :&&: unir_por_conjuncion tail

        fun unir_por_disyuncion prop1 prop2 = prop1 :||: prop2

        fun recorrer []                  = prop (* caso de cero variables *)
        |   recorrer (fila :: mas_filas) = 
            let
                val asociacion = as_vals variables fila
                val resultado_fila = evalProp asociacion prop
            in
                if n = 1 then (* caso de una variable *)
                    prop
                else if resultado_fila andalso mas_filas = [] then
                    unir_por_conjuncion (tomar_variables_atomicas asociacion)
                else if resultado_fila then (* caso de 2 o mas variables *)
                    unir_por_disyuncion (unir_por_conjuncion (tomar_variables_atomicas asociacion)) (recorrer mas_filas)
                else
                    recorrer mas_filas
            end
    in
        recorrer lista_combinaciones_booleanas
    end
;

(* 
p = v, q = v => v
p = v, q = f => f
p = f, q = v => v
p = f, q = f => v

(p ^ q) v (-p ^ q) v (-p ^ -q)
*)