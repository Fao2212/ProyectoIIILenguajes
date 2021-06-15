(*//Estrategia
//Se comienza pensando que es necesario considerar solamente la proposicion, se intenta generalizar la funcion
//Se piensa en crear una tabla de presedencia, se hacen varios intentos sin resultado
//Se toma como base ejemplos del profesor donde se utilizan "tecnicas" de sml
//Se nota que se puede usar algo parecido a la funcion imprimir del profesor.
//Se toma y se hacen cambios utilizando la tabla de presedencia
//Se crean las funciones una por uno por separado y luego se crea una funcion bonita que contiene a las hechas previamente
//Se hace que bonita inicie en 0 para que sea mas facilmente utilizada por los usuario. Se hacen varias pruebas.*)


fun bonita prop =
    let val primeraPresedencia = 0
    fun getPresedencia prop =
    case prop of
              constante c=> 0 |
              variable v=> 0 |
              negacion n=> 30 |
              conjuncion c=> 15 |
              disyuncion d=> 6 |
              implicacion i=> 3 |
              equivalencia e => 0 
    fun imprimirB (prop,presedenciaAnterior) =
        case prop of
            constante false             => "false"
        |   constante true              => "true"
        |   variable nombre             => nombre
        |   negacion prop1              =>
                let val presedencia = getPresedencia prop
                in case presedencia < presedenciaAnterior of true => "~(" ^ imprimirB  (prop1,presedencia) ^ ")"|
                                                            false => "~" ^ imprimirB  (prop1,presedencia) ^ ""
                end   
        |   conjuncion (prop1, prop2)   => 
                let val presedencia = getPresedencia prop
                in case presedencia < presedenciaAnterior of true => "(" ^ imprimirB (prop1,presedencia) ^ " /\\ " ^ imprimirB (prop2,presedencia) ^ ")":string| 
                                                             false => "" ^ imprimirB (prop1,presedencia) ^ " /\\ " ^ imprimirB (prop2,presedencia) ^ "":string
                end
        |   disyuncion (prop1, prop2)   => 
                let val presedencia = getPresedencia prop
                in case presedencia < presedenciaAnterior of true => "(" ^ imprimirB (prop1, presedencia) ^ " \\/ " ^ imprimirB (prop2,presedencia) ^ ")":string
                |
                                                            false => "" ^ imprimirB (prop1,presedencia) ^ " \\/ " ^ imprimirB (prop2,presedencia) ^ "":string
                end
        |   implicacion (prop1, prop2)  => 
                let val presedencia = getPresedencia prop
                in case presedencia < presedenciaAnterior of true => "(" ^ imprimirB (prop1,presedencia) ^ " => " ^ imprimirB (prop2,presedencia) ^ ")"|
                                                            false => "" ^ imprimirB (prop1,presedencia) ^ " => " ^ imprimirB (prop2,presedencia) ^ ""
                end
        |   equivalencia (prop1, prop2) =>
                let val presedencia = getPresedencia prop
                in case presedencia < presedenciaAnterior of true => "(" ^ imprimirB(prop1,presedencia) ^ " <=> " ^ imprimirB (prop2,presedencia) ^ ")"|
                                                            false => "" ^ imprimirB(prop1,presedencia) ^ " <=> " ^ imprimirB (prop2,presedencia) ^ ""
                end
    in print (imprimirB(prop,primeraPresedencia))
    end
;

(*//Pruebas para bonita*)

val pru1 = negacion(conjuncion(variable "x",variable "y"));
val pru2 = conjuncion(negacion(variable "x"),variable "y");
val pru3 = disyuncion(conjuncion(constante true,negacion(constante false)),disyuncion(constante false,constante true));
val pru4 = conjuncion(disyuncion(constante true,negacion(constante false)),disyuncion(constante false,constante true));