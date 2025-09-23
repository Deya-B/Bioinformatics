### Rangos de niveles

```splus 
% 1) Definir parámetros iniciales
N = 256;
t = (0:N-1)/N;     % 0 <= t < 1

% 2) Crear una malla de puntos para evaluar la función
[x,y] = meshgrid(t,t);

% 3) Evaluar la función
fn = 32*cos(2*pi*x)+16*sin(4*pi*y);

% 4) Calcular rango de niveles
min_fn = min(fn(:));
max_fn = max(fn(:));

% 5) Visualizar con distintos rangos de niveles
subplot(2,3,1), imshow(fn, [min_fn max_fn]), title('Rango optimo = [min\_fn,max\_fn]');
subplot(2,3,2), imshow(fn, [-24 24]), title('Rango [-24,24]');
subplot(2,3,3), imshow(fn, [-12 12]), title('Rango [-12,12]');
subplot(2,3,4), imshow(fn, [-6 6]), title('Rango [-6,6]');
subplot(2,3,5), imshow(fn, [-3 3]), title('Rango [-3,3]');
subplot(2,3,6), imshow(fn, [-1 1]), title('Rango [-1,1]');
```
<img alt="" src="\images\Ejercicio1-2.png" />

#### Observaciones:
> Los pixeles pueden tomar cualquier valor real, y esto lo ajustamos con `imshow(fn, [min_fn max_fn])`.\
> Cuando obtenemos el rango mínimo y máximo de la función e imagen concreta, obtenemos el rango ajustado a la imagen, que equivale al valor óptimo, aprovechando todos los pixeles.\
> En este experimento el rango de valores que pueden tomar los pixeles es cada vez reducido a la mitad, haciéndose más pequeño. Los valores que antes existían (por ejemplo, en r0 = -48),  en el nuevo r0 = -24 se han perdido 24 niveles de grises que se representan como negros. Y por el lado de los valores superiores rL, ocurre lo mismo, representándose como blancos los 24 niveles por encima de rL  = 24.\
> El efecto que tiene esto es una reducción de la definición de la imagen, cuando en la primera imagen se intuyen dos pelotas oscuras rodeadas de un halo grisáceo. Esto va evolucionando hasta fusionarse y formar una honda que cada vez tiene los bordes más definidos cambiando por completo lo que sería la representación real.

### VLT de Video Lookup Table - Imágenes indexadas
La imagen será de tipo `uint8` (un byte por píxel, es decir, un rango de [0, 255] posibles niveles o colores) o bien de tipo `uint16` (dos bytes por píxel, es decir, un rango de [0,65535] posibles colores).\
Esta requerirá menos recursos para almacenarse y representarse que una imagen de tipo `double`, como las que hemos hecho hasta ahora.

#### Conversión de tipos:
*Funciones:* `im2uint8`, `im2uint16` para imágenes de tipo `double`, sin embargo es solo para dentro del rango $0 <= fn <= 1$.

##### Para obtener el rango adecuado hay que hacerlo manualmente: 
- Desplazamos, escalamos y redondeamos los valores de tipo double de la imagen original.

```splus 
%% Conversion de una imágen f de tipo double a una imagen ima de tipo unit 8
fn2 = 32*cos(2*pi*x + 3*pi*y)+16*sin(4*pi*y);
```
```splus 
%% Si convertimos directamente:
figure; imshow(im2gray(fn2)) 
```
<img width="200" height="200" alt="" src="\images\ex3.png" />

```splus 
%% Si lo hacemos manualmente: 
% Desplazamos, escalamos y redondeamos los valores de tipo double de la imagen original.
min_fn2 = min(fn2(:));
max_fn2 = max(fn2(:));

% 1) Cuantificamos en el nuevo rango
step_f = (max_fn2-min_fn2)/256;           % Intervalo que corresponde a cada nivel
ima = uint8(round(((fn2-min_fn2)/step_f))); % Desplazo y escalo

% 2) Indicar VLT (colormap)
figure; imshow(ima, gray(256))          % VLT de 256 niveles de gris
```
<img width="200" height="200" alt="" src="\images\imauint8.png" />

##### Distintos mapas de colores
```splus 
%% 3) Generar 6 imágenes con seis mapas de 256 colores distintos
ax = subplot (2,3,1), imshow(ima, []); colormap(ax, gray(256)); title('Gray(256)');
ax = subplot (2,3,2), imshow(ima, []); colormap(ax, winter(256)); title('Winter');
ax = subplot (2,3,3), imshow(ima, []); colormap(ax, hot(256)); title('Hot');
ax = subplot (2,3,4), imshow(ima, []); colormap(ax, hsv(256)); title('hsv');
ax = subplot (2,3,5), imshow(ima, []); colormap(ax, sky(256)); title('Sky')
ax = subplot (2,3,6), imshow(ima, []); colormap(ax, cool(256)); title('Cool')
```

<img alt="" src="\images\Figure_2-2.png" />

Otra manera de representarlos es en tiles:
```splus 
%% Tiles: 6 colormaps, each with 256 levels
tiledlayout(3,2);

ax = nexttile; % Create a new tile for the next image
imshow(ima, []); colormap(ax, gray(256)); title('Gray(256)');
ax = nexttile; imshow(ima, []); colormap(ax, turbo(256)); title('turbo');
ax = nexttile; imshow(ima, []); colormap(ax, abyss(256)); title('abyss');
ax = nexttile; imshow(ima, []); colormap(ax, nebula(256)); title('nebula');
ax = nexttile; imshow(ima, []); colormap(ax, flag(256)); title('flag');
ax = nexttile; imshow(ima, []); colormap(ax, white(256)); title('white');
```

<img alt="" src="\images\Figure_2-2B.png" />

#### Observaciones:



