
# Librerias a utilizar

import skfuzzy as fuzz
from skfuzzy import control as ctrl
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

def generarIntervalo(numero):

	result = []

	for aux in range (0,numero):
		result.append(aux)

	return result

def aproximar(nombre,cantidad):

	result = 0

	tamano = [0,30,60,90,120,150,200,250,300,350,400,450]
	intensidad = generarIntervalo(5)
	temperatura = generarIntervalo(30)
	comun = generarIntervalo(40)
	tiempo = generarIntervalo(7)
	agua = generarIntervalo(450)

	if (nombre == "tamano"):
		for aux in tamano:
			if (cantidad < aux):
				return aux

	if (nombre == "intensidad"):
		for aux in intensidad:
			if (cantidad < intensidad):
				return intensidad

	if (nombre == "temperatura"):
		for aux in temperatura:
			if (cantidad < aux):
				return aux

	if (nombre == "cafe" or nombre == "leche" or nombre == "chocolate"):
		for aux in comun:
			if (cantidad < aux):
				return aux

	if (nombre == "tiempo"):
		for aux in tiempo:
			if (cantidad < aux):
				return aux

	if (nombre == "agua"):
		for aux in agua:
			if(cantidad < aux):
				return aux

	return result

def cargarElementos ():

	latte = pd.read_csv(filepath_or_buffer="latte.csv")
	mokaccino = pd.read_csv(filepath_or_buffer="mokaccino.csv")
	capuccino = pd.read_csv(filepath_or_buffer="capuccino.csv")
	espresso = pd.read_csv(filepath_or_buffer="espresso.csv")

	return latte,mokaccino,capuccino,espresso

def declararAntecedentes():

	# Declarando los intervalos del tamaño del cafe

	tamano = ctrl.Antecedent(np.arange(0, 450, 1), "Tamaño")
	tamano["Pequeno"] = fuzz.zmf(tamano.universe,0,200) 
	tamano["Mediano"] = fuzz.gaussmf(tamano.universe,225,80)
	tamano["Grande"] = fuzz.smf(tamano.universe,250,450)

	# Declarando los intervalos de la intensidad del cafe

	intensidad = ctrl.Antecedent(np.arange(0, 5, 1), "Intensidad")
	intensidad["Suave"] = fuzz.zmf(intensidad.universe,0,5) 
	intensidad["Medio"] = fuzz.gaussmf(intensidad.universe,2,0.8)
	intensidad["Fuerte"] = fuzz.smf(intensidad.universe,0,5)

	# Declarando los intervalos de temperatura que contiene la temperatura
	
	temperatura = ctrl.Antecedent(np.arange(0, 30 ,1), "Temperatura")
	temperatura["Frio"] = fuzz.zmf(temperatura.universe,0,30) 
	temperatura["Calido"] = fuzz.gaussmf(temperatura.universe,15,5)
	temperatura["Caluroso"] = fuzz.smf(temperatura.universe,0,30)

	return tamano,intensidad,temperatura

def declararConsecuentes():

	leche = ctrl.Consequent(np.arange(0, 40, 1), "Leche")
	leche["Poca"] = fuzz.zmf(leche.universe,0,40)
	leche["Media"] = fuzz.gaussmf(leche.universe,20,7)
	leche["Mucha"] = fuzz.smf(leche.universe,0,40)

	chocolate = ctrl.Consequent(np.arange(0, 40, 1), "Chocolate")
	chocolate["Poca"] = fuzz.zmf(chocolate.universe,0,40)
	chocolate["Media"] = fuzz.gaussmf(chocolate.universe,20,7)
	chocolate["Mucha"] = fuzz.smf(chocolate.universe,0,40)

	agua = ctrl.Consequent(np.arange(0, 450, 1), "Agua")
	agua["Poca"] = fuzz.zmf(agua.universe,0,400)
	agua["Media"] = fuzz.gaussmf(agua.universe,200,85)
	agua["Mucha"] = fuzz.smf(agua.universe,0,400)

	cafe = ctrl.Consequent(np.arange(0, 40, 1), "Cafe")
	cafe["Poca"] = fuzz.zmf(cafe.universe,0,40)
	cafe["Media"] = fuzz.gaussmf(cafe.universe,20,7)
	cafe["Mucha"] = fuzz.smf(cafe.universe,0,40)

	tiempo = ctrl.Consequent(np.arange(0, 7, 1), "Tiempo")
	tiempo["Poca"] = fuzz.zmf(tiempo.universe,0,7)
	tiempo["Media"] = fuzz.gaussmf(tiempo.universe, 3,1.1)
	tiempo["Mucha"] = fuzz.smf(tiempo.universe,0,7)

	return leche,chocolate,agua,cafe,tiempo

def cafeExpresso (espressoCsv,tamano,temperatura,intensidad,agua,cafe,tiempo):

	# Declarando las reglas que contiene el cafe Expresso

	preparacionEspresso = declararReglasExpresso(espressoCsv,tamano,temperatura,intensidad,agua,cafe,tiempo)
	
	# Pedir parametros por pantalla

	size = input("Tamaño del cafe: " )
	temperature = input("Temperatura ambiente: " )
	intenity = input("Intensidad del café: " )

	preparacionEspresso.input["Tamaño"] = int(size)
	preparacionEspresso.input["Temperatura"] = int(temperature)
	preparacionEspresso.input["Intensidad"] = int(intenity)
	preparacionEspresso.compute()

	agua.view(sim = preparacionEspresso)
	cafe.view(sim = preparacionEspresso)
	tiempo.view(sim = preparacionEspresso)

	numero = int(preparacionEspresso.output["Agua"])
	numeroAux = aproximar("agua",numero)
	print(numeroAux)

	print("Agua (ml): " + str(aproximar("agua", int(preparacionEspresso.output["Agua"])) ) )
	print("Café (gr): " + str(aproximar("cafe", int(preparacionEspresso.output["Cafe"])) ) )
	print("Tiempo (min): " + str(aproximar("tiempo", int(preparacionEspresso.output["Tiempo"])) ) )


def declararReglasExpresso(espressoCsv,tamano,temperatura,intensidad,agua,cafe,tiempo):
	
	reglasEspresso = []

	for index, row in espressoCsv.iterrows():

	    antecedente = tamano[row["tamano"]] & temperatura[row["temperatura"]] & intensidad[row["intensidad"]]
	    consecuente = (agua[row["agua"]], cafe[row["cafe"]], tiempo[row["tiempo"]])
	    regla  = ctrl.Rule(antecedente, consecuente)
	    reglasEspresso.append(regla)

	espressoCtrl = ctrl.ControlSystem(reglasEspresso)
	espressoCtrl.view()
	preparacionEspresso = ctrl.ControlSystemSimulation(espressoCtrl)
	return preparacionEspresso

def cafeCapuccino (capuccinoCsv,tamano,temperatura,intensidad,agua,cafe,tiempo,leche):

	# Declarando las reglas que contiene el cafe Expresso

	preparacionCapuccino = declararReglasCapuccino(capuccinoCsv,tamano,temperatura,intensidad,agua,cafe,tiempo,leche)
	
	# Pedir parametros por pantalla

	size = input("Tamaño del cafe: " )
	temperature = input("Temperatura ambiente: " )
	intenity = input("Intensidad del café: " )

	preparacionCapuccino.input["Tamaño"] = int(size)
	preparacionCapuccino.input["Temperatura"] = int(temperature)
	preparacionCapuccino.input["Intensidad"] = int(intenity)
	preparacionCapuccino.compute()

	agua.view(sim = preparacionCapuccino)
	cafe.view(sim = preparacionCapuccino)
	leche.view(sim = preparacionCapuccino)
	tiempo.view(sim = preparacionCapuccino)

	print("Agua (ml): " + str(aproximar("agua", int(preparacionCapuccino.output["Agua"])) ) )
	print("Café (gr): " + str(aproximar("cafe", int(preparacionCapuccino.output["Cafe"])) ) )
	print("Tiempo (min): " + str(aproximar("tiempo", int(preparacionCapuccino.output["Tiempo"])) ) )
	print("Leche (gr): " + str(aproximar("tiempo", int(preparacionCapuccino.output["Leche"])) ) )


def declararReglasCapuccino(capuccinoCsv,tamano,temperatura,intensidad,agua,cafe,tiempo,leche):
	
	reglasCapuccino = []

	for index, row in capuccinoCsv.iterrows():
	    #print(row)
	    antecedente = tamano[row["tamano"]] & temperatura[row["temperatura"]] & intensidad[row["intensidad"]]
	    consecuente = (agua[row["agua"]], cafe[row["cafe"]], tiempo[row["tiempo"]], leche[row["leche"]] )
	    regla  = ctrl.Rule(antecedente, consecuente)
	    reglasCapuccino.append(regla)
	capuccinoCtrl = ctrl.ControlSystem(reglasCapuccino)
	capuccinoCtrl.view()
	preparacionCapuccino = ctrl.ControlSystemSimulation(capuccinoCtrl)

	return preparacionCapuccino

def cafeLatte (latteCsv,tamano,temperatura,intensidad,agua,cafe,tiempo,leche):

	# Declarando las reglas que contiene el cafe Expresso

	preparacionLatte = declararReglasLatte(latteCsv,tamano,temperatura,intensidad,agua,cafe,tiempo,leche)
	
	# Pedir parametros por pantalla

	size = input("Tamaño del cafe: " )
	temperature = input("Temperatura ambiente: " )
	intenity = input("Intensidad del café: " )

	preparacionLatte.input["Tamaño"] = int(size)
	preparacionLatte.input["Temperatura"] = int(temperature)
	preparacionLatte.input["Intensidad"] = int(intenity)
	preparacionLatte.compute()

	agua.view(sim = preparacionLatte)
	cafe.view(sim = preparacionLatte)
	leche.view(sim = preparacionLatte)
	tiempo.view(sim = preparacionLatte)

	print("Agua (ml): " + str(aproximar("agua", int(preparacionLatte.output["Agua"])) ) )
	print("Café (gr): " + str(aproximar("cafe", int(preparacionLatte.output["Cafe"])) ) )
	print("Tiempo (min): " + str(aproximar("tiempo", int(preparacionLatte.output["Tiempo"])) ) )
	print("Leche (gr): " + str(aproximar("leche", int(preparacionLatte.output["Leche"])) ) )


def declararReglasLatte(latteCsv,tamano,temperatura,intensidad,agua,cafe,tiempo,leche):
	
	reglasLatte = []
	for index, row in latteCsv.iterrows():
	    #print(row)
	    antecedente = tamano[row["tamano"]] & temperatura[row["temperatura"]] & intensidad[row["intensidad"]]
	    consecuente = (agua[row["agua"]], cafe[row["cafe"]], tiempo[row["tiempo"]], leche[row["leche"]])
	    regla  = ctrl.Rule(antecedente, consecuente)
	    reglasLatte.append(regla)
	latteCtrl = ctrl.ControlSystem(reglasLatte)
	latteCtrl.view()
	preparacionLatte = ctrl.ControlSystemSimulation(latteCtrl)

	return preparacionLatte

def cafeMokaccino (mokaccinoCsv,tamano,temperatura,intensidad,agua,cafe,tiempo,leche,chocolate):

	# Declarando las reglas que contiene el cafe Expresso

	print(mokaccinoCsv)

	preparacionMokaccino = declararReglasMokaccino(mokaccinoCsv,tamano,temperatura,intensidad,agua,cafe,tiempo,leche,chocolate)
	
	# Pedir parametros por pantalla

	size = input("Tamaño del cafe: " )
	temperature = input("Temperatura ambiente: " )
	intenity = input("Intensidad del café: " )

	preparacionMokaccino.input["Tamaño"] = int(size)
	preparacionMokaccino.input["Temperatura"] = int(temperature)
	preparacionMokaccino.input["Intensidad"] = int(intenity)
	preparacionMokaccino.compute()

	agua.view(sim = preparacionMokaccino)
	cafe.view(sim = preparacionMokaccino)
	leche.view(sim = preparacionMokaccino)
	tiempo.view(sim = preparacionMokaccino)
	chocolate.view(sim = preparacionMokaccino)

	print("Agua (ml): " + str(aproximar("agua", int(preparacionMokaccino.output["Agua"])) ) )
	print("Café (gr): " + str(aproximar("cafe", int(preparacionMokaccino.output["Cafe"])) ) )
	print("Tiempo (min): " + str(aproximar("tiempo", int(preparacionMokaccino.output["Tiempo"])) ) )
	print("Leche (gr): " + str(aproximar("leche", int(preparacionMokaccino.output["Leche"])) ) )
	print("Chocolate (gr): " + str(aproximar("chocolate", int(preparacionMokaccino.output["Chocolate"])) ) )


def declararReglasMokaccino(mokaccinoCsv,tamano,temperatura,intensidad,agua,cafe,tiempo,leche,chocolate):
		
	reglasMokaccino = []
	for index, row in mokaccinoCsv.iterrows():
	    #print(row)
	    antecedente = tamano[row["tamano"]] & temperatura[row["temperatura"]] & intensidad[row["intensidad"]]
	    consecuente = (agua[row["agua"]], cafe[row["cafe"]], tiempo[row["tiempo"]], leche[row["leche"]], chocolate[row["chocolate"]] )
	    regla  = ctrl.Rule(antecedente, consecuente)
	    reglasMokaccino.append(regla)
	mokaccinoCtrl = ctrl.ControlSystem(reglasMokaccino)
	mokaccinoCtrl.view()
	preparacionMokaccino = ctrl.ControlSystemSimulation(mokaccinoCtrl)
	return preparacionMokaccino


# Menu Principal

def menu():

	# Se realiza la lectura de las reglas declaradas en el enunciado
	latte,mokaccino,capuccino,espresso = cargarElementos()
	# Se realizan las declaracion de los antecedentes y sus respectivos intervalos
	tamano,intensidad,temperatura = declararAntecedentes()
	# Se realiza la declaracion de los consecuentes a utilizar dentro del programa y sus intervalos.
	leche,chocolate,agua,cafe,tiempo = declararConsecuentes()

	opcion = 0
	opcion1 = 0

	while opcion != '2':

		print("\n")
		print("	1. Preparar Cafe")
		print("	2. Salir")
		print("\n")

		opcion = input(" Ingrese la opcion a realizar: ")

		if (opcion == '1'):

			opcion1 = 0
			while opcion1 != '5':

				print("	1.	Prepara Cafe Expresso")
				print("	2.	Prepara Cafe Cappucino")
				print("	3.	Prepara Cafe Latte")
				print("	4.	Prepara Cafe Mokaccino")
				print("	5.	Volver al menu principal")

				opcion1 = input(" Ingrese la opcion a realizar: ")

				if (opcion1 == '1'):
					print("Preparando caffe Expresso")
					cafeExpresso(espresso,tamano,temperatura,intensidad,agua,cafe,tiempo)

				if (opcion1 == '2'):
					print("Preparando caffe Cappucino")
					cafeCapuccino(capuccino,tamano,temperatura,intensidad,agua,cafe,tiempo,leche)

				if (opcion1 == '3'):
					print("Preparando caffe Latte")
					cafeLatte(latte,tamano,temperatura,intensidad,agua,cafe,tiempo,leche)

				if (opcion1 == '4'):
					print("Preparando caffe Mokaccino")
					cafeMokaccino(mokaccino,tamano,temperatura,intensidad,agua,cafe,tiempo,leche,mokaccino)

				if (opcion1 == '5'):
					opcion1 = '5'
						
		if (opcion == '2'):

			os.system ("clear")
			print("\n")
			print("Gracias por preferirnos")
			print("\n")

# Haciendo el llamado a la ejecución del programa.
menu()