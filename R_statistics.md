# Statistics with R
## 1. Types of data
Los datos pueden medirse en diferentes escalas. De "menos información a más información" podemos organizar las escalas de esta manera:

1. **Escala nominal o categórica**: Utilizamos una escala que simplemente diferencia las distintas clases. Por ejemplo, podemos clasificar algunos objetos por aquí, 
``ordenador, pizarra, lápiz,`` y podemos asignarles números (1 al ordenador, 2 a la pizarra, etc.), pero los números no tienen significado *per se*. 
Datos biológicos en una escala nominal: los elementos del genoma - O numera los aminoácidos del 1 (alanina) al 20 (valina).
Por supuesto, se puede contar cuántos son del tipo 1 (cuántos son alaninas), etc., pero no tendría sentido hacer promedios y decir «su composición media de AA es de 13,5».
    - **Binario**: los datos están en una escala nominal con sólo dos clases: muerto o vivo (y podemos dar un 0 o un 1 a cualquiera de ellas), ``hombre o mujer,`` etc.

2. **Escala ordinal**: Los datos pueden ordenarse en el sentido de que se puede decir que algo es mayor o menor que otra cosa.
Por ejemplo, ordenar preferencia por la comida: ``chocolate > jamón serrano > grillos tostados > hígado``.
Podrías asignar el valor 1 al chocolate (tu alimento preferido) y un 4 al hígado (el menos preferido),
pero las diferencias o proporciones entre esos números no tienen ningún significado.

3. **Escala de intervalos o de proporciones** Se pueden tomar diferencias y proporciones, y sí que tienen significado.
   Si un sujeto tiene un valor de 6 para la expresión del gen PTEN, otro un valor de 3, y otro un valor de 1, entonces
   el primero tiene seis veces más ARN de PTEN que el último, y dos veces más que el segundo.

## 2. Looking at Data plots:
We first need to import the data:
```
dp53 <- read.table("P53.txt", header = TRUE, stringsAsFactors = TRUE)
```
Notice the ```stringsAsFactors = TRUE:``` we want the strings to be turned into factors, so we ask for it.
### 2.1 Plots to do: 
Make sure you do the following plots:
* Histogram for each gene, using condition (“cond”) as the conditioning or grouping variable (“Plot by:”).
* Boxplot, using condition (“cond”) as the conditioning or grouping variable (“Plot by:”).
* Plot of means (and make sure you get nicer axes labels).
* Stripchart, and make sure you use “jitter”, not “stack”: can you tell for which one of the variables this matters a lot?
* Density plots (“Density estimates”)
