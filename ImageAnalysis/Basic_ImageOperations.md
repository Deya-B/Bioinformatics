## Operaciones básicas

### Superposición de funciones a imágenes
Definimos la funcion $(fn)$:
```splus
% 1) Definir parámetros iniciales
N = 256;
t = (0:N-1)/N;     % 0 <= t < 1

% 2) Crear una malla de puntos para evaluar la función
[x,y] = meshgrid(t,t);

% 3) Funcion
fn = 0.5+0.5*cos(2*pi*x+4*pi*y);

% 4) Visualizar
imshow(fn, [], 'InitialMagnification', 100);
title('Visualización de la función');
```

<img width="600" height="230" alt="" src="\images\Ej4_1.png" />
