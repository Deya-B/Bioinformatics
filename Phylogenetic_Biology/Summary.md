# Table of Contents
[Programa teórico](#teoria)
1. [Introducción a la filogenética](#)
2. [Alineamiento de secuencias](#alineamiento)
3. [Modelos de evolución molecular](#modelos)
4. [Métodos filogenéticos de inferencia](#metodos)
5. [Máxima parsimonia](#mp)
6. [Métodos de distancias](#distancias)
7. [Máxima verosimilitud](#mv)
8. [Inferencia Bayesiana](#bayesian)
9. [Reloj molecular relajado](#reloj)

# Programa teórico <a name="teoria"></a>
## Introducción a la filogenética <a name="intro"></a>

### Estudios filogenéticos:
La filogenética puede ser estudiada de diversas maneras.

- Registros fósiles: 
    + *PROS*: contienen información sobre la morfología de los antepasados de las especies actuales y la cronología de sus divergencias. Esto permite datar las filogenias.
    - *CONTRAS*: utilizar registros fósiles para determinar relaciones filogenéticas puede producir **sesgos** porque:
        - pueden estar disponibles sólo para determinadas especies
        - los datos existentes de fósiles pueden estar fragmentados
        - la recolección de datos está limitada por la abundancia, hábitat, rango geográfico y otros factores
        - las descripciones de los rasgos morfológicos son a menudo ambiguas (múltiples factores genéticos).

- Datos moleculares: en la forma de secuencias de ADN o de proteínas. Debido a que los genes son el medio para registrar las mutaciones acumuladas, éstos pueden servir como "fósiles moleculares".
    + *PROS*: son más numerosos que los registros fósiles y más fáciles de obtener. Además, no hay ningún sesgo de muestreo, como el que hay en los registros fósiles reales. Por tanto, es posible construir árboles filogenéticos más precisos y robustos utilizando datos moleculares.

### Arboles filogenéticos: 
Representaciones gráficas (patrones) de las relaciones ancestro-descendientes (relaciones históricas de parentescos) entre elementos, que pueden ser especies, secuencias de genes, etc. Entender este patrón es esencial para realizar estudios comparativos de cualquier tipo, porque existen dependencias  estadísticas entre los elementos que comparten ancestros comunes.

#### Los árboles filogenéticos estan compuestos por:
![treeparts](images/treeparts.png)

- **Nodos externos** o **terminales**. 
    - Se denominan **grupos hermanos** a los nodos terminales que parten de un mismo nodo interno, es decir, dos taxones que compartan un ancestro común no compartido por ningún otro taxón.
    - El **grupo externo (outgroup)** es aquel que se encuentra más alejado y parte de una rama distinta desde la raíz. Normalmente, este outgroup se elige arbitrariamente para poder colocar la raíz donde se estima correcto.
    - Todas las especies que se desarrollan desde una rama de la raíz se denomina **grupo interno** o **ingroup**.
- **Nodos internos**: 
son hipótesis evolutivas de posibles ancestros comunes de los cuales normalemente faltan datos para confirmar o descartar la teoría.
- **Ramas** (branches) que unen los nodos. En las
distintas ramas se pueden representar la transformación de caracteres que aparecen a nivel genético y que se transmiten por herencia.
- **Raiz**. Los árboles filogenéticos se pueden representar sin enraizar o enraizado. 
    - **Sin raíz**: Un árbol filogenético que no asume conocimiento de un ancestro común, solo posiciones de los taxones para mostrar sus relaciones relativas (no hay dirección de un camino evolutivo).
    - **Con raíz**: Para describir la dirección de la evolución se necesita un árbol filogenético donde todas las secuencias bajo estudio tienen un ancestro o nodo raíz común *(más informativo)*.

#### Representación de los arboles:
Hay varias formas de representar los árboles filogenéticos.
Los distintos elementos no tienen un orden concreto; da igual si en un árbol los nodos terminales están en distinto orden mientras que las ramas sigan el mismo camino.
![treerep](images/treerep.png)

#### Tipos de arboles:


#### Politomías:


## Alineamiento de secuencias <a name="alineamiento"></a>
## Modelos de evolución molecular <a name="modelos"></a>
## Métodos filogenéticos  de inferencia <a name="metodos"></a>
## Máxima parsimonia (MP) <a name="mp"></a>
## Métodos de distancias <a name="distancias"></a>
## Máxima verosimilitud (ML) <a name="ml"></a>
## Inferencia Bayesiana <a name="bayesian"></a>
## Reloj molecular relajado <a name="reloj"></a>

