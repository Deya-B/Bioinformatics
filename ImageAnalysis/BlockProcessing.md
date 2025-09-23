# Procesamiento a nivel de bloque 
Consiste en dividir la imagen en bloques y aplicar una función a cada bloque de manera individual. Para ello podemos utilizar la función `blkproc()`.

```splus
[ima_procesada]= blkproc(ima,[m n],fun)
```
> $m$ y $n$ indican las dimensiones del bloque a procesar
> `fun` es un enlace a una función que:
> - acepta como entrada una matriz $x$ (de dimensiones $m$ y $n$)
> - devuelve una matriz, vector o escalar y, donde: $y = fun(x)$
>
> Los enlaces a funciones se definen mediante el uso del comando `@`, por ejemplo:
>
> ```splus
> func = @(x) mean(mean(x));
> ```

Ilustramos el uso de esta función a continuación:

```splus
% 1) Leer la imagen Skin_gray.jpg
[ima, map] = imread('.\P1_Imagenes\Skin_gray.jpg');
imshow(ima, map); title('Skin gray');
```

```splus
% 2) Usar la funcion blkproc() para calcular el valor medio de bloques 
% de tamaño 8x8

blockSize = 8;
m = blockSize; 
n = blockSize; 
fun = @(block) uint8( round(mean(block.data(:))) );
ima_procesada = blockproc(ima, [m n], fun);
imshow(ima_procesada, []); title('Skin gray');

% Descargar la imagen procesada
imwrite(ima_procesada, 'C:\Users\deyan\GitHub\Bioinformatics\ImageAnalysis\images\Skin_gray_processed.jpg');
```

<img alt="" src="\images\Skin_gray_processed.jpg" />

Blockproc devuelve un bloque del tamaño que salga de la función. Como la fun devuelve un escalar (mean(...)), la salida es una imagen reducida de tamaño (alto/8)×(ancho/8).
