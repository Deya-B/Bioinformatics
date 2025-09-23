### Generación y representación de imágenes a partir de expresiones analíticas

```splus 
% 1) Definir parámetros iniciales
n=0:0.05:4-0.05; 
m=0:0.05:4-0.05; %rangos de variacion de las variables

% 2) Crear una malla de puntos para evaluar la función
[N, M] = meshgrid(n, m); %generar matrices N,M

% 3) Evaluar la función en la malla de puntos
f = cos(2*pi*N)+sin(6*pi*M);

% 4) Visualizar la función evaluada en la malla de puntos
imshow(f,[-2,2], 'InitialMagnification', 100);
    % imshow(f,[min(min(f)) max(max(f))], 'InitialMagnification',100);
    % 'InitialMagnification' fijado al valor 100 fuerza a que la imagen se 
    % presente a tamaño real (cada píxel de la imagen corresponde con un punto del monitor)
```
<img width="200" height="200" alt="" src="\images\ex1.png" />

```splus
% 5) Representar varias imágenes:
subplot(1,2,1), imshow(f,[-2 2]); colorbar
subplot(1,2,2), imshow(f,[-1 1]); colorbar
```
<img width="600" height="230" alt="" src="\images\ex2.png" />

#### Observaciones:
> El motivo las dos imágenes se ve distinto porque el rango de variación de la escala de grises es más amplio en la imagen de la izquierda que en la de la derecha, generando una imagen con más difusa pero más informativa.

### Representación de varias funciones para degradados
```splus
% Reticulo octogonal:
n = 0:(1/256):1-1/256;
m = 0:(1/256):1-1/256;
% Matriz:
[x, y] = meshgrid(n, m);
```

Lo anterior es equivalente a:
```splus
N = 256;
t = (0:N-1)/N;         % 0 <= t < 1
[x,y] = meshgrid(t,t);
```

```splus
%% 1.1.1 Funciones:
f1 = (4*x)/5;
f2 = y/2;
f3 = ((2*x)/5)+(y/4);

subplot(1,3,1), imshow(f1,[0 0.80]), title f1
subplot(1,3,2), imshow(f2,[0 0.50]), title f2
subplot(1,3,3), imshow(f3,[0 0.68]), title f3
% Auto-escalar MEJOR (fn,[]), que usa min(fn(:)) y max(fn(:)) 
                     % en lugar de fijar (fn,[k l])
```
<img alt="" src="\images\Figure_1-1.png" />

#### Observaciones: 
> Como tenemos funciones lineales observamos un degradado.\
> En el caso de la f1, solo depende de x, por lo que observamos un aumento de luminosidad de izquierda a derecha.\
> Para f2, el cambio es en el eje y, el brillo crece de arriba abajo.\
> En el caso de f3, hay cambios en ambos ejes. Como x cambia más rápido que y el degradado va en ángulo.

### Representación de fanjas verticales con diferentes frecuencias
```splus
%% 1.1.2 Funciones:
f2_1 = cos(2*pi*x);
f2_2 = cos(4*pi*x);
f2_3 = cos(8*pi*x);
f2_4 = cos(16*pi*x);

% Visualizar las funciones f2 con diferentes frecuencias
subplot(2,2,1), imshow(f2_1,[]), title('f2_1: cos(2\pi x)')
subplot(2,2,2), imshow(f2_2,[]), title('f2_2: cos(4\pi x)')
subplot(2,2,3), imshow(f2_3,[]), title('f2_3: cos(8\pi x)')
subplot(2,2,4), imshow(f2_4,[]), title('f2_4: cos(16\pi x)')
```
<img alt="" src="\images\Figure_1-2.png" />

#### Observaciones: 
> En todas estas funciones, lo que cambia es la x, con lo que podemos observar que obtenemos franjas paralelas al eje de la y. Al ser un cos, estas varían de +1 (claro) a -1 (oscuro) de forma suave y simétrica. En cada periodo hay media banda clara y media oscura. Cuando doblamos el multiplicador, las líneas se duplican el número y son más finas.

### Representación de ciclos a distintos ejes
```splus
%% 1.1.3 Funciones:
f3_1 = cos(2*pi*x)+sin(8*pi*y);
f3_2 = cos(2*pi*x)+sin(16*pi*y);

% Visualizar las funciones f3 con diferentes frecuencias
subplot(1,2,1), imshow(f3_1,[]), title('f3_1: cos(2\pi x) + sin(8\pi y)')
subplot(1,2,2), imshow(f3_2,[]), title('f3_2: cos(2\pi x) + sin(16\pi y)')
```
<img alt="" src="\images\Figure_1-3.png" />

#### Observaciones: 
> En este caso, por un lado tenemos lo que ocurre al eje $x$ y por otro lo que ocurre al eje $y$, porque la función es una suma separable.\
> Al eje $x$ le aplicamos un coseno (cos) con un ciclo, es decir una franja vertical ancha como la que hemos visto en la primera función anterior.\
> Al eje $y$ le aplicamos un seno (sin) a una frecuencia de 8 y 16, creando franjas horizontales variables de claro (+1) y oscuro (-1).\
> Donde estas se cruzan, obtenemos una variación en esa zona de lo que sería la franja original, con tonos intermedios suavizados y causando un engrosamiento o estrechamiento de la franja.

### Representación de fanjas oblicuas con diferentes frecuencias
```splus
%% 1.1.4 Funciones:
f4_1 = cos((4*pi*x)+(4*pi*y));
f4_2 = cos((4*pi*x)+(8*pi*y));
% Visualizar las funciones f4 con diferentes frecuencias
subplot(1,2,1), imshow(f4_1,[]), title('f4_1: cos((4\pi x)+(4\pi y))')
subplot(1,2,2), imshow(f4_2,[]), title('f4_2: cos((4\pi x)+(8\pi y))')
```
<img alt="" src="\images\Figure_1-4.png" />

#### Observaciones: 
> En este caso tenemos una variación de franjas como en las funciones más arriba (2), porque, aunque hay variaciones en el eje de la x y la y, estas ocurren dentro del mismo paréntesis que contiene el coseno. Por lo que obtenemos franjas diagonales uniformes. En la función 1 las líneas aumentan por igual en ambos ejes, con lo que obtenemos un ángulo de 45 grados. Mientras que en la 2 obtenemos un incremento superior en el eje de las y’s, y como las franjas son perpendiculares a la función, tienen una posición hacia el horizontal. 
