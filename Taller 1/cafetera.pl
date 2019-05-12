% Taller numero 1 de logica: Cafeteras.
% 
% Nombres: Javier Arredondo - Cristian Espinoza.

% % Dominio: unidades atómicas
% especies de granos de cafe = arabica, robusta
% intensidad = suave, muy, medio, nada
% preparacion = espresso, americano, cortado, capuccino, latte, mokaccino
% 
tipo_preparacion(espresso).
tipo_preparacion(americano).
tipo_preparacion(cortado).
tipo_preparacion(cappuccino).
tipo_preparacion(latte).
tipo_preparacion(mokaccino).

% Cantidad de café en gramos
% 
cafe(_, 7).

% Cantidad de leche en gramos
% 
leche(espresso, 0).
leche(americano, 0).
leche(cortado, 3).
leche(cappuccino, 19).
leche(latte, 9).
leche(mokaccino, 9).

% Cantidad de chocolate en gramos
% 
chocolate(espresso, 0).
chocolate(americano, 0).
chocolate(cortado, 0).
chocolate(cappuccino, 0).
chocolate(latte, 0).
chocolate(mokaccino, 3).

% Cantidad de agua en ml
% 
agua(espresso, 30).
agua(americano, 60).
agua(cortado, 50).
agua(cappuccino, 150).
agua(latte, 90).
agua(mokaccino, 100).

% Tamano de la taza: razón de ingredientes a utilizar
% 
% Asumimos que la cantidad de ingredientes aumentara dependiendo de la taza que ocupemos, debido que
% se considero lo siguiente:
% Pequeña: Tenemos que la cantidad de ingredientes se considera en una unidad 
% Mediana: Tenemos que la cantidad de ingredientes se multiplica por dos para llevar 
% la preparación del cafe.
% Grande:Tenemos que la cantidad de ingredientes se multiplica por tres para llevar 
% la preparación del cafe.
% 
tamano_taza(pequeno, 1).
tamano_taza(mediana, 2).
tamano_taza(grande, 3).

% Intensidad del café asociado la sepa
% 
intensidad(robusta, muy).
intensidad(combinado, medio).
intensidad(arabica, suave).
intensidad(descafeinado, suave).

% Tiempo de preparación asociado a la estación del año
% 
% Consideramos los tiempos de preparación dados en la clase de donde se explico el enunciado.
% 
tiempo_preparacion(verano, 1).
tiempo_preparacion(primavera, 1.5).
tiempo_preparacion(otono, 1.5).
tiempo_preparacion(invierno, 2).

% Funcion que utilizamos para la pregunta 3, la cual nos indica si la maquina se encuentra disponible.
instalada(si).

% Funcion que se encarga de verificar si un numeor es mayor que otro, la cual tiene su utilización
% dentro de la funcion 3, debido que comparamos si la cantidad ingresada es mayor o igual al minimo
% que se necesita para poder utilizar la maquina disponible.
% 
mayor_que(X, Y):-
	X>=Y.

% Funcion que se encarga de entregar un valor segun la cantidad de agua que se tiene, se debe destacar que mientras mas agua contenga el numero que se 
% entregara sera menor, esto se penso de esta manera, debido que mientras mas agua contenga la tasa de cafe, es mas facil disolver los polvos que seran
% ingresados.

valorIntensidadAgua(X,Y):-
    ( X =< 50 -> Y is 6
    ; X =< 100 -> Y is 4
    ; Y is 2
    ).

% Funcion que se encarga de entregar un valor segun la cantidad de chocolate que se contiene en un cafe en particular, destacar que aca solo un cafe contiene
% chocolate, por lo tanto, todo los cafes tendra 0 exceptuando el cafe de tipo mokaccino, que se le da un valor de 2 por tener ese polvo adicional.
% Tener en consideración: Que consideramos que si el cafe contiene chococlate la intensidad del cafe no bajara, al contrario, al ser un sabor fuerte 
% consideramos que tomario mas concentracioón lo cual conlleva a aumentar en una cantidad menor su intensidad.

valorIntensidadChocolate(X,Y):-
    ( X == 0 -> Y is 0
    ; Y is 2
    ).

% Funcion que se encarga de entregar un valor segun la cantidad de leche que contiene el cafe, se debe considerar que el numero sera mayor mientras mas 
% cantidad de leche contenga, este valor se entrega en forma negativa, debido que le baja la intendisidad al cafe.

valorIntensidadLeche(X,Y):-
    ( X == 0 -> Y is 0
    ; X =< 3 -> Y is -1
    ; X =< 9 -> Y is -2
    ; Y is -3
    ).

%Funcion que se encarga de entregar un valor que identifica la intensidad del cafe segun la el tipo de cafe que se utiliza, debemos tener en cuenta
%que mientras mas intenso segun clasificacion este tendra mas cantidad de cafe, debido que eso lo hara ser mas intenso al momento de clasificarlo.

valorIntensidadCafe(PREPARACION,Y):-
    ( PREPARACION='robusta' -> Y is 21
    ; PREPARACION='combinado' -> Y is 14
    ; PREPARACION='arabica' -> Y is 7
    ; PREPARACION='descafeinado' -> Y is 2
    ; false
    ).

% Funcion que se encarga de entregar la clasificacion final del cafe, segun los calculos realizados a cada uno de los compomentes que contiene el cafe, 
% este se divide en tres randos los cuales son:
% [0 , 10] => Si la cantidad de puntos cae dentro de este intervalo tiene una categoria de SUAVE
% [10 , 20] => Si la cantidad de puntos cae dentro de este intervalo tiene una categoria de MEDIO
% [20 , INF] => Si la cantidad de puntos cae dentro de este intervalo tiene una categoria de ALTO
% Finalmente, este es el resultado que se le entrega al usuario al momento de ejecutar esta función.

clasificacion(X,Y):-
    ( X =< 10 -> Y = "Bajo"
    ; X =< 20 -> Y = "Medio"
    ; Y = "Alto"
    ).


% Reglas y hechos
% 
% Funcion 1:
% 
% Variables de entrada: Se considero las mismas variables de entrada que indica el enunciado.
%
% Variables de salida: 
% [21,0,450,0,"cafe muyfuerte",180]
% 21: Indica la cantidad de gramos de cafe que necesitamos
% 0: La cantidad de leche que se necesita
% 450: La cantidad de agua que se necesita
% 0: La cantidad de chocolate que se necesita
% cafe muy fuerte: La intensidad del cafe 
% 180: El tiempo de preparacion que tomara hacerlo.

prepararCafe(TAMANO, PREPARACION, CAFE, ESTACION, SALIDA):-
	tamano_taza(TAMANO, S), intensidad(CAFE, I), tiempo_preparacion(ESTACION, T), 
	cafe(PREPARACION, C), leche(PREPARACION, L), agua(PREPARACION, A), chocolate(PREPARACION, CH),
	CC is C * S, LL is L * S, AA is A * S, CHO is CH * S, TT is T * S * 60,
	append([CC, LL, AA, CHO], [I, TT], SALIDA).

% Funcion 2:
%
% Variables de entrada: Se consideran las mismas variables de entrada que indica el enunciado, debemos destacar que con la solución que se plantea existe 
% una variable que no es ocupada la cual es el CAFE, debido que se asume que el tipo de cafe que se utiliza no dependera de los recursos que se tiene 
% disponible para poder realizar una cantidad finitas de cafe,
% 
% Variables de salida: Se entrega la misma salida que el enunciado, donde se indica la cantidad de tasa de cafe que se pueden formar con la cantidad de 
% recursos ingresados y el tiempo promedio que se tardara en estar listo el pedido realizado. 

cantidadTazas(TAMANO, PREPARACION, CAFE, ESTACION, CANTCAFE, CANTLECHE, CANTAGUA, CANTCHO, SALIDA):-
	tamano_taza(TAMANO, S), leche(PREPARACION, L), cafe(PREPARACION, C), chocolate(PREPARACION, CH), agua(PREPARACION, A), tiempo_preparacion(ESTACION, T),
    ( PREPARACION='espresso' -> CC is CANTCAFE/(C * S), AA is CANTAGUA/(A * S), min_member(X, [CC, AA]), TT is  T * X * 60, RESULT is truncate(X),RESULT1 is truncate(TT), append([RESULT],[RESULT1], SALIDA) 
    ; PREPARACION='americano' -> CC is CANTCAFE/(C * S), AA is CANTAGUA/(A * S), min_member(X, [CC, AA]), TT is  T * X * 60, RESULT is truncate(X),RESULT1 is truncate(TT), append([RESULT],[RESULT1], SALIDA)
    ; PREPARACION='cortado' -> CC is CANTCAFE/(C * S), LL is CANTLECHE/(L * S), AA is CANTAGUA/(A * S), min_member(X, [CC, LL, AA]), TT is  T * X * 60, RESULT is truncate(X),RESULT1 is truncate(TT), append([RESULT],[RESULT1], SALIDA)
    ; PREPARACION='cappuccino' -> CC is CANTCAFE/(C * S), LL is CANTLECHE/(L * S), AA is CANTAGUA/(A * S), min_member(X, [CC, LL, AA]), TT is  T * X * 60, RESULT is truncate(X),RESULT1 is truncate(TT), append([RESULT],[RESULT1], SALIDA)
    ; PREPARACION='latte' -> CC is CANTCAFE/(C * S), LL is CANTLECHE/(L * S), AA is CANTAGUA/(A * S), min_member(X, [CC, LL, AA]), TT is  T * X * 60, RESULT is truncate(X),RESULT1 is truncate(TT), append([RESULT],[RESULT1], SALIDA)
    ; PREPARACION='mokaccino' -> CC is CANTCAFE/(C * S), LL is CANTLECHE/(L * S), AA is CANTAGUA/(A * S), CHO is CANTCHO/(CH * S), min_member(X, [CC, LL, AA, CHO]), TT is  T * X * 60,  RESULT is truncate(X),RESULT1 is truncate(TT), append([RESULT],[RESULT1], SALIDA)
    ; false
    ). 

% Funcion 3:
% 
% Variables de entrada: Tenemos que entran las mismas variables indicadas en el enunciado
% 
% Variables de salida: Nos entrega una salida booleana, la cual nos va a indicar si es posible
% utilizar la maquina, teniendo en cuenta 4 restricciones, als cuales son:
% Primera: Que la maquina este disponible
% Segundo: Que la cantidad de agua sea la necesaria.
% Tercero: Que la cantidad de cafe sea la necesaria.
% Leche: Que la cantidad de leche sea la necesaria.

sePuedeUsar(INSTALADA, CANTAGUA, CANTCAFE, CANTLECHE):- 
	instalada(INSTALADA), mayor_que(CANTAGUA, 150), mayor_que(CANTCAFE, 30), mayor_que(CANTLECHE, 30).


%Funcion 4:
%
% Variables de entrada: Tenemos que entran las mismas variables de entrada, donde con estas se procede a obtener los datos que seran utilizados dentro
% de la selección de la clasificacion de la intensidad del cafe, donde ocuparemos el agua, leche y chocolate.
% 
% Variables de salida: Entrega la saliad solicitada por el enunciado, la cual indicara si la intensidad del cafe es: ALTA,MEDIA,SUAVE, esto se entrega
% luego de haber realizado cada uno de los calculos necesarios para poder realizar la clasificación que se ocupo para obtener la intensidad del cafe.

intensidadCafe(TIPOCAFE, PREPARACION, SALIDA):-
	leche(PREPARACION, L), agua(PREPARACION, A), chocolate(PREPARACION, CH),
	valorIntensidadAgua(A,X_AGUA), valorIntensidadChocolate(CH,X_CH), valorIntensidadLeche(L,X_L), valorIntensidadCafe(TIPOCAFE,X_TC),
    RESULT = (X_AGUA + X_CH + X_L + X_TC), clasificacion(RESULT,SALIDA).
