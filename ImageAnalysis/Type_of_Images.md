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

