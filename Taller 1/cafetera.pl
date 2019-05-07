% Dominio: unidades atómicas
% especies de granos de cafe = arabica, robusta
% intensidad = suave, muy, medio, nada
% preparacion = espresso, americano, cortado, capuccino, latte, mokaccino
tipo_preparacion(espresso).
tipo_preparacion(americano).
tipo_preparacion(cortado).
tipo_preparacion(cappuccino).
tipo_preparacion(late).
tipo_preparacion(mokaccino).

% Cantidad de café en gramos
cafe(_, 7).

% Cantidad de leche en gramos
leche(espresso, 0).
leche(americano, 0).
leche(cortado, 0).
leche(cappuccino, 0).
leche(latte, 0).
leche(mokaccino, 0).

% Cantidad de chocolate en gramos
chocolate(espresso, 0).
chocolate(americano, 0).
chocolate(cortado, 0).
chocolate(cappuccino, 0).
chocolate(latte, 0).
chocolate(mokaccino, 3).

% Cantidad de agua en ml
agua(espresso, 30).
agua(americano, 60).
agua(cortado, 50).
agua(cappuccino, 150).
agua(latte, 90).
agua(mokaccino, 100).


% Tamano de la taza: razón de ingredientes a utilizar
tamano_taza(pequeno, 1).
tamano_taza(mediana, 2).
tamano_taza(grande, 3).

% Intensidad del café asociado la sepa
intensidad(robusta, muy).
intensidad(combinado, medio).
intensidad(arabica, suave).
intensidad(descafeinado, suave).

% Nivel de intensidad, relacionado con el agua y leche.
nivel_intensidad(suave, 0.3).
nivel_intensidad(medio, 0.6).
nivel_intensidad(muy, 1).

% Tiempo de preparación asociado a la estación del año
tiempo_preparacion(verano, 1).
tiempo_preparacion(primavera, 1.5).
tiempo_preparacion(otono, 1.5).
tiempo_preparacion(invierno, 2).

instalada(si).

mayor_que(X, Y):-
	X>=Y.

intensidad_preparacion(NIP, SALIDA):-
	NIP >= 0, NIP < 0.3, nivel_intensidad(X, 0.3), append([X],[],SALIDA);
	NIP >= 0.3, NIP < 0.6, nivel_intensidad(X, 0.6), append([X],[],SALIDA);
	NIP >= 0.6, nivel_intensidad(X, 1), append([X], [], SALIDA).
	 

% Reglas y hechos
prepararCafe(TAMANO, PREPARACION, CAFE, ESTACION, SALIDA):-
	tamano_taza(TAMANO, S), intensidad(CAFE, I), tiempo_preparacion(ESTACION, T), 
	cafe(PREPARACION, C), leche(PREPARACION, L), agua(PREPARACION, A), chocolate(PREPARACION, CH),
	CC is C * S, LL is L * S, AA is A * S, CHO is CH * S, TT is T * S * 60,
	append([CC, LL, AA, CHO], [I, TT], SALIDA).

cantidadTazas(TAMANO, PREPARACION, CAFE, ESTACION, CANTCAFE, CANTLECHE, CANTAGUA, CANTCHO, SALIDA):-
	tamano_taza(TAMANO, S), leche(PREPARACION, L), cafe(PREPARACION, C), chocolate(PREPARACION, CH), agua(PREPARACION, A), tiempo_preparacion(ESTACION, T), intensidad(CAFE, I),
	CC is CANTCAFE/(C * S), LL is CANTLECHE/(L * S), AA is CANTAGUA/(A * S), CHO is CANTCHO/(CH * S), min_member(X, [CC, LL, AA, CHO]), TT is  T * X * 60,
	append([X], [TT], SALIDA).

sePuedeUsar(INSTALADA, CANTAGUA, CANTCAFE, CANTLECHE):- 
	instalada(INSTALADA), mayor_que(CANTAGUA, 150), mayor_que(CANTCAFE, 30), mayor_que(CANTLECHE, 30).

intensidadCafe(CAFE, PREPARACION, SALIDA):-
	intensidad(CAFE, I), nivel_intensidad(I, NI), leche(PREPARACION, L), agua(PREPARACION, A), cafe(PREPARACION, C), chocolate(PREPARACION, CH),
	NIP is (C/(A + C + CH + L)) * NI, append([NIP], [], SALIDA). 
