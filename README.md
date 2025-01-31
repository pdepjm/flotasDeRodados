# Flotas de rodados

En este ejercicio vamos a construir un modelo que pueda servir para la administración de las flotas de rodados que utilizan las distintas dependencias de la Municipalidad de Coronel Vallejos. 

## Etapa 1 - Rodados y dependencias

De cada **rodado** nos van a interesar: _capacidad_ (o sea, cuántos pasajeros puede transportar), _velocidad máxima_, _color_ y _peso_.

A continuación se describen los rodados que maneja la muncipalidad.

- Varios **Chevrolet Corsa**. <br>
  La capacidad de estos autos es de 4 pasajeros, su velocidad máxima 150 km/h, y pesan 1300 kg. <br>
  La municipalidad no estableció un color fijo para sus Corsa; por lo tanto, debe informarse el color de cada uno. <br>

- Varios **Renault Kwid** que funcionan _a gas_. 
  Cada uno de ellos puede tener puesto, o no, un tanque adicional. 
  - La capacidad de un Kwid es de 4 pasajeros si no tiene puesto el tanque adicional, o 3 pasajeros si sí lo tiene puesto.
  - La velocidad máxima es 120 km/h con, o 110 km/h sin, tanque adicional.
  - El peso es 1200 kg, más 150 kg adicionales si tiene tanque adicional. 
  - Todos los autos de este tipo con que cuenta la municipalidad son azules. <br>

- **Una Trafic** (sí, una sola), que es reconfigurable, porque se le puede cambiar el interior y el motor.
  - La municipalidad cuenta con dos _interiores_, uno **cómodo** (capacidad 5 pasajeros, peso 700 kg) y otro **popular** (capacidad 12 pasajeros, peso 1000 kg). La municipalidad tiene un solo interior de cada tipo.
  - También ha comprado dos _motores_ para su Trafic, uno **pulenta** (que pesa 800 kg y permite una velocidad máxima de 130 km/h) y otro **batatón** (que pesa 500 kg y permite una velocidad máxima de 80 km/h). La municipalidad tiene un solo motor de cada tipo.
  - Varias características de la Trafic dependen de qué interior y qué motor le hayan puesto:
    - La _capacidad_ de la Trafic es la del interior.
    - La _velocidad máxima_ es la que permite el motor.
    - El peso es 4000 kg más el peso del interior más el del motor.
  - Finalmente, digamos que la Trafic es de _color blanco_, independientemente del interior y el motor que tenga puestos. 
  
- Varios **autos especiales** que son todos distintos entre sí. De cada uno de ellos se debe especificar capacidad, velocidad máxima, peso y color.

<br>

Como dijimos, cada **dependencia** de la municipalidad maneja una _flota de rodados_. Un rodado puede estar compartido entre varias dependencias (ver test más abajo). 
De cada dependencia importa también _cuántos empleados tiene_.
 
Debe ser posible enviarle los siguientes mensajes a cada objeto que representa a una dependencia.
- `agregarAFlota(rodado)` y `quitarDeFlota(rodado)`.
- `pesoTotalFlota()`, la suma del peso de cada rodado afectado a la flota.
- `estaBienEquipada()`, es verdadero si la flota tiene al menos 3 rodados, y además, _todos_ los rodados de la flota pueden ir al menos a 100 km/h.
- `capacidadTotalEnColor(color)`, la cantidad total de personas que puede transportar la flota afectada a la dependencia, considerando solamente los rodados del color indicado.
- `colorDelRodadoMasRapido()`, eso.
- `capacidadFaltante()`, que es el resultado de restar, de la cantidad de empleados, la capacidad sumada de los vehículos de la flota. 
- `esGrande()`, la condición es que la dependencia tenga al menos 40 empleados y 5 rodados.


### Test con dos dependencias

Armar un test en el que hay que se definen dos dependencias: deportes (45 empleados) y cultura (31 empleados).
	
En este test debe definirse un rodado al que llamaremos _cachito_; o sea, definir `var cachito = ...`.
Este rodado debe ser un Corsa de color rojo.
	
La flota de deportes incluye a: `cachito`, un Corsa azul, un Corsa verde, un Kwid con el tanque adicional puesto; y un auto especial con estas características: capacidad 5 pasajeros, velocidad máxima 160 km/h, peso 1200 kg, color beige.
	
Por su parte, cultura cuenta con: `cachito`; dos Kwid con el tanque adicional puesto; un Kwid más, este sin el tanque adicional;  y la Trafic, configurada con el interior popular y el motor batatón.
	
Notar que `cachito` forma parte de la flota de _ambas_ dependencias.

Para cada dependencia, hacer asserts sobre: el peso total de la flota, si está o no bien equipada, la capacidad total en color azul, el color del rodado más rápido, si es grande o no, y la capacidad faltante. 

Va una ayudita: la capacidad faltante de deportes es de 25 personas (la flota puede llevar: 12 personas en los 3 Corsa, más 3 del Kwid y 5 del auto especial; total 20), mientras que la de cultura es de 5 personas (puede llevar en total 26: 6 de los Kwid con tanque adicional, más 4 de la Kwid sin tanque, más 4 de cachito, más 12 de la Trafic dado que tiene el interior popular).	
<br>

**Megaimportante**

Hacer el diagrama de objetos correspondiente a este test.


## Etapa 2: modelo de pedidos

Agregar al modelo los **pedidos** de translados que se generan en la municipalidad.  
Cada pedido especifica: la _distancia_ a recorrer (expresada en kilómetros), el _tiempo máximo_ en que se puede hacer el viaje (expresado en horas), la _cantidad de pasajeros_ a transportar, y también un conjunto de _colores incompatibles_, o sea, que los pasajeros rechazan hacer el viaje en autos de esos colores.  
La _velocidad requerida_ de un pedido es el resultado de dividir la cantidad de kilómetros por el tiempo máximo.
P.ej. si para un pedido de un viaje de 480 kilómetros se indica como tiempo máximo 6 horas, entonces la velocidad requerida de este pedido es de 80 kms/hora (480 / 6 = 80).   
	
Los pedidos deben poder _validar si un auto lo puede satisfacer_, enviándole un mensaje al pedido con el auto como parámetro. _Este mensaje debería falla_ si el vehículo no puede satisfacer el pedido, expresando por qué no puede, sino _no debería hacer nada_.

Para que un auto pueda satisfacer un pedido se tienen que dar tres condiciones: 
- que la velocidad máxima del auto sea al menos 10 km/h mayor a la velocidad requerida del pedido; 
- que la capacidad del auto dé para la cantidad de pasajeros del viaje; y 
- que el auto no sea de un color incompatible para el viaje.

P.ej. consideremos al auto al que llamamos `cachito` en el test de la etapa 1 (recordemos: capacidad 4 pasajeros, velocidad máxima 150 km/h, color rojo).
- este auto puede satisfacer un pedido de 960 kms con tiempo máximo de 8 horas (lo que da una velocidad requerida de 120 km/h), para 4 pasajeros donde los colores incompatibles son azul y negro.
- si agregamos el rojo a los colores incompatibles, entonces `cachito` no pasa la validación porque tiene un color incompatible.
- si cambiamos la cantidad de pasajeros a 6, entonces `cachito` no pasa la validación porque el pedido necesita transportar a ms pasajeros que los que entran en el auto.
- y si cambiamos el tiempo máximo a 6 horas, entonces `cachito` no pasa la validación porque el pedido tendría una velocidad requerida de 160 km/h.

Armar los tests que comprueben esta especificación.

<br>

Además, los objetos que representan pedidos deben entender estos mensajes: `acelerar` disminuye en uno el tiempo máximo (p.ej. lo hace pasar de 8 horas a 7), y `relajar` que lo aumenta en uno (p.ej. lo hace pasar de 8 horas a 9).

## Etapa 3: registro de los pedidos de cada dependencia

Agregar a cada dependencia un registro de los pedidos que hace. Se pueden agregar y quitar pedidos.

Agregar lo que haga falta al modelo para que se pueda conocer, para una dependencia:
- el total de pasajeros en los pedidos que tiene registrados
- dado un color, si es cierto que _todos_ los pedidos registrados lo tienen como color incompatible.

También debe ser posible, enviando un mensaje al objeto que representa a una dependencia, _relajar_ todos los pedidos que tenga registrados.


## Extra - un pequeño desafío

Agregar un método más a las dependencias, que devuelva el conjunto de colores que son incompatibles para, al menos, un pedido. Los curiosos pueden investigar el método `fold`; ver el apunte sobre colecciones que está en el sitio. Algo se explica en el apunte número 12 de la serie de apuntes que está en [wollok.org](https://wollok.org).


## Notas bibliográficas

Coronel Vallejos no existe, es el pueblo ficticio donde transcurre _La traición de Rita Hayworth_, una novela de Manuel Puig.


## Un comentario para la implementación

En este ejercicio no damos ningún código inicial, les toca todo a ustedes. Van solamente algunos comentarios.

La mayor parte de los objetos que representan rodados van a ser instancias de alguna clase. No todos de la misma clase: las características de un Corsa son distintas que las de un Twid.

La excepción es la Trafic: dado que hay una sola, **no es necesario** crear una clase `Trafic`, puede ser tranquilamente un objeto bien conocido.
