class Corsa {
	const color
	
	method cantPasajeros() = 4

	method velocidadMaxima() = 150

	method peso() = 1300
	
	method color() = color
}

class Kwid {
	var tieneTanque = false
	
	method cantPasajeros() = if (tieneTanque) 3 else 4
	
	method velocidadMaxima() = if (tieneTanque) 120 else 110
	
	method peso() = 1200 + self.pesoPorTanque() 
	
	method pesoPorTanque() = if (tieneTanque) 150 else 0
	
	method color() = "azul"
}

object trafic {
	//TODO	
}

class Especial {
	const property cantPasajeros
	var property velocidadMaxima
	var property peso
	var property color
}

class Dependencia {
	const flota = []
	const cantEmpleados
	
	//TODO
}