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

fun fnd prop =
    let
        val variables = vars prop
        val n = length variables
        val lista_combinaciones_booleanas = gen_bools n

        fun crear_variable_verdadera (var, bool) = 
            if bool then variable var else ~:(variable var);

        fun tomar_variables_atomicas vars_bools =
            [ map crear_variable_verdadera vars_bools ]

        fun tomar_filas_verdaderas []                  = [] (* caso de cero variables *)
        |   tomar_filas_verdaderas (fila :: mas_filas) = 
            let
                val asociacion = as_vals variables fila
                val resultado_fila = evalProp asociacion prop
            in
                if resultado_fila then
                    (tomar_variables_atomicas asociacion) @ (tomar_filas_verdaderas mas_filas)
                else
                    tomar_filas_verdaderas mas_filas
            end

        val filas_verdaderas = tomar_filas_verdaderas lista_combinaciones_booleanas

        fun unir_por_conjuncion [] = constante true
        |   unir_por_conjuncion (head::tail) = if tail = [] then head else head :&&: unir_por_conjuncion tail
        
        fun recorrer_filas_verdaderas []                  = simpl prop (* caso de cero variables *)
        |   recorrer_filas_verdaderas (fila :: mas_filas) = 
            if mas_filas = [] then (* caso de una fila restante *)
                unir_por_conjuncion fila
            else 
                (unir_por_conjuncion fila) :||: (recorrer_filas_verdaderas mas_filas)
    in            
        recorrer_filas_verdaderas filas_verdaderas
    end
;