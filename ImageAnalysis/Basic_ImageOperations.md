## Operaciones básicas
Para poder operar en MatLab con **una sola imagen** (ponderarla, escalarla, etc.) sin perder rango de
representación en el resultado esta siempre ha de cumplir:
1. ser de tipo `double`
2. ser *true-color*

Si lo que se desea es operar con **dos imágenes** (sumarlas, restarlas, etc.), a parte de lo anterior, ambas deben tener:\
\+ las mismas *dimensiones* (filas, columnas y número de bandas o valores por píxel)

### Conversiones útiles
- `ind2rgb(ima)` &rarr; Convertir imagen indexada en true-color
  > Esta función devuelve una imagen true-color que además es de tipo double y definida en el rango
[0,1]
- `im2double(ima)` &rarr; Convertir imagen (indexada o true-color) de tipo uint8 o uint16 a tipo double
  > Esta función devuelve una imagen double definida en el rango [0,1] y de la misma clase (indexada o true-color) que la original.
- `rgb2gray(ima)` &rarr; Convertir imagen true-color de tres componentes (RGB) en imagen truecolor
de una componente (nivel de gris)
  > se perderá la información de color
- Convertir imagen true-color de una componente `ima_gray` (nivel de gris) en una imagen true-color de tres `ima_rgb` &rarr; no hay una función específica. Se debe generar un array con las tres componentes de la siguiente manera:
  ```splus
  ima_rgb = zeros(ima_h, ima_w, 3);
  ima_rgb(:,:,1) = ima_gray;
  ima_rgb(:,:,2) = ima_gray;
  ima_rgb(:,:,3) = ima_gray;
  ```
  > No se añadirá color (las tres componentes serán iguales), pero tenemos la posibilidad de que una operación genere color, por ejemplo, modificando de distinto modo cada componente.

### Superposición de funciones a imágenes
1. Cargar y representar la imagen Xray.jpg
```splus
[ima, map] = imread('.\P1_Imagenes\Xray.jpg');
imshow(ima, map); title('Xray');
```
<img width="400" alt="" src="\images\ej4_2.png" />

2. Obtener con `size` la altura y anchura
```splus
[height, width, chanels] = size(ima) % size(ima) devuelve tres dimensiones (alto, ancho, canales).
```

3. Convertir en una imagen de tipo double
```splus
imaD = im2double(ima);
```
<img width="250" alt="" src="\images\imgD.png" />

4. generar la imagen discreta
  - con la variación del rango de la funcion discreta: $0 <= x/y < 1$
  - y de los vectores del retículo de modo que $v_1=(1/width),0$ y $v_2=(0,(1/height))$
```splus
% Definimos la FUNCION
% 1) Definir parámetros iniciales
n = (0:width-1)/width;    
m = (0:height-1)/height;

% 2) Crear una malla de puntos para evaluar la función
[x,y] = meshgrid(n,m);

% 3) Funcion
fn = 0.5+0.5*cos(2*pi*x+4*pi*y);

% 4) Visualizar
imshow(fn, [], 'InitialMagnification', 100);
title('Visualización de la función');
```

<img width="400" alt="" src="\images\ej4_fn.png" />


5. Convertir la imagen de la funcion discreta en una de tres componentes
```splus
ima_rgb = zeros(height, width, 3);
ima_rgb(:,:,1) = fn; % Asignar la función a la primera capa de color (Rojo)
ima_rgb(:,:,2) = fn; % Asignar la segunda capa de color (Verde)
ima_rgb(:,:,3) = fn; % Asignar la tercera capa de color (Azul)
```
