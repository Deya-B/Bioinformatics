## Lectura de imágenes a partir de un archivo
Utilizar la función `imread()`.

```splus
[ima,map]=imread(‘MRI_pseudo_colored.jpg’)
```

### Imagenes indexadas
- `ima` es una matriz o array de dos dimensiones de tipo uint8 o uint16, 
- `map` es su tabla de colores

### Imagenes *true-color*
- Imagen en la que el valor de cada píxel indica directamente su color.
- En estas imágenes `map` está vacío
- Puede estar formada por dos o tres bandas o matrices de tipo `uint8` (es decir, un array **2D** o **3D**):
  - array de **dos dimensiones** = a cada elemento de la imagen le corresponde un valor. El valor de los píxeles es directamente un nivel de luminancia o nivel de gris que va de 0 (negro) a 255 (blanco); por lo que no incluye información de color.
  - array de **tres dimensiones** = a cada elemento de la imagen le corresponden tres valores enteros que indican directamente las componentes roja, verde y azul de cada píxel, cada una de ellas variable entre 0 (componente inexistente) y 255 (máxima saturación en esa componente).
- **Imágenes binarias**: son un tipo *especial* que solamente presenta dos valores:
  - están formadas por una sola banda (es decir, un array de **1D**) de tipo `uint8` (con valores 0 o 255), o `logical` (con valores 0 o 1).

```splus
% Leer las imágenes1 MRI_pseudo_colored.jpg, CT_abdomen.jpg, Skin.tif y Xray_th.tif

[ima1, map1]=imread('.\P1_Imagenes\MRI_pseudo_colored.jpg');
[ima2, map2]=imread('.\P1_Imagenes\CT_abdomen.jpg');
[ima3, map3] = imread('.\P1_Imagenes\Skin.tif');
[ima4, map4] = imread('.\P1_Imagenes\Xray_th.tif');

ax = subplot (2,2,1), imshow(ima1, map1); title('MRI pseudo colored');
ax = subplot (2,2,2), imshow(ima2, map2); title('CT abdomen');
ax = subplot (2,2,3), imshow(ima3, map3); title('Skin');
ax = subplot (2,2,4), imshow(ima4, map4); title('Xray th');
```

<img alt="" src="\images\Ej3.png" />

|          |     Clase (indexada / true-color)    |     Notas    |     Color / Grises / Binaria    |     Notas    |
|---|---|---|---|---|
|     MRI_pseudo     _colored.jpg    |     Size 879x1024x3      Class uint8    |     True-color    |     Map 0x0     Double    |     3D-Color    |
|     CT_abdomen.jpg    |     Size 732x833     Class uint8    |     True-color    |     Map 0x0     Double    |     2D-Grises    |
|     Skin.tif    |     Size 560x560     Class uint8    |     Indexada    |     Map 256x3     Double    |     2D-Color    |
|     Xray_th.tif    |     Size 367x472     Class logical    |     True-color    |     Map 0x0     Double    |     Binaria lógica (0/1)    |

### Conversion entre VLT y true-color 

```splus
%% cambio de clase > VLT a true-color y viceversa
[ima1c, map1c] = rgb2ind(ima1, 256);
    % true-color -> indexada color (dos entradas, 2 salidas > crear map para indexada)
[ima2c, map2c] = gray2ind(im2gray(ima2), 256);
ima3c = ind2rgb(ima3, map3);
    % indexada -> true-color (dos entradas, 1 salida > true color no tiene map)
[ima4c, map4c] = gray2ind(ima4, 256);

ax = subplot (2,2,1), imshow(ima1c, map1c); title('MRI pseudo colored');
ax = subplot (2,2,2), imshow(ima2c, map2c); title('CT abdomen');
ax = subplot (2,2,3), imshow(ima3c);        title('Skin');
ax = subplot (2,2,4), imshow(ima4c,map4c);  title('Xray th');

```
Visualmente el resultado es el mismo. Pero en el Workspace ahora los valores de las variables `ima` y `map` han cambiado.\
Cuando antes `map` estaba vacio ahora muestra $256x3$.

### Conversion a escala grises

```splus
%% convertir a escala de grises
ima1_gray = rgb2gray(ima1);         % true-color -> gris (1 salida)
ima3_gray = rgb2gray(ima3c);        % true-color -> gris (1 salida)
% opt 2: 
% ima3_gray = ind2gray(ima3, map3);     % indexada (2 entradas) -> gris (1 salida)

ax = subplot (2,2,1), imshow(ima1_gray, []); title('MRI pseudo colored');
ax = subplot (2,2,2), imshow(ima2, []);      title('CT abdomen');
ax = subplot (2,2,3), imshow(ima3_gray, []); title('Skin');
ax = subplot (2,2,4), imshow(ima4,map4);     title('Xray th');
```

<img alt="" src="\images\Ej3grises.png" />

```splus

```


```splus

```

```splus

```


```splus

```
