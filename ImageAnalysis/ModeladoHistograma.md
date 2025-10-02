## Modelado de histograma

### Vamos a modificar la VLT y representar sus histogramas

1.  Operaciones puntual de modificación de la VLT (Video Lookup Table) (imagen de entrada es indexada).

``` splus
%% Cargar imagenes Skin_gray_bw_560.tif y Skin_gray_bw_1120.tif
[ima560, map560] = imread('Imagenes_P2\Skin_gray_bw_560.tif');
[ima1120, map1120] = imread('Imagenes_P2\Skin_gray_bw_1120.tif');

L1 = size(map560, 1); 
L2 = size(map1120, 1);

%% Modificación del vector de valores de la imagen
r1 = [0:L1-1];
r2 = [0:L2-1];
C = [8,32,64,128];

for c = C
    s1 = min(r1 + c, L1-1);    
    ima_proc1 = uint8(s1(double(ima560 + 1)));

    % Mostrar y guardar imagen transformada
    f1 = figure;  ax1 = axes('Parent',f1);
    imshow(ima_proc1, map560, 'Parent', ax1);
    title(ax1, sprintf('Skin560 | c=%d', c));
    imwrite(ima_proc1, map560, sprintf('results/img_2a_%d.png', c));
    close(f1);

    % Mostrar y guardar histograma
    f2 = figure; ax2 = axes('Parent',f2);
    imhist(ima_proc1, map560); axis(ax2,'tight');
    title(ax2, sprintf('Hist Skin560 | c=%d', c));
    exportgraphics(f2, sprintf('results/img_2a_%d_hist.png', c), 'Resolution',150);
    close(f2);
end

for c = C
    s2 = min(r2 + c, L2-1);
    ima_proc2 = uint8(s2(double(ima1120) + 1));

    % imagen
    f3 = figure; ax3 = axes('Parent',f3);
    imshow(ima_proc2, map1120, 'Parent', ax3);
    title(ax3, sprintf('Skin1120 | c=%d', c));
    imwrite(ima_proc2, map1120, sprintf('results/img_2b_%d.png', c));
    close(f3);

    % histograma
    f4 = figure; ax4 = axes('Parent',f4);
    imhist(ima_proc2, map1120); axis(ax4,'tight');
    title(ax4, sprintf('Hist Skin1120 | c=%d', c));
    exportgraphics(f4, sprintf('results/img_2b_%d_hist.png', c), 'Resolution',150);
    close(f4);
end
```

**Results figure 560:**

|  |  |  |  |
|------------------|------------------|------------------|------------------|
| ![](images2/img_2a_8.png) | ![](images2/img_2a_32.png) | ![](images2/img_2a_64.png) | ![](images2/img_2a_128.png) |
| ![](images2/img_2a_8_hist.png) | ![](images2/img_2a_32_hist.png) | ![](images2/img_2a_64_hist.png) | ![](images2/img_2a_128_hist.png) |

**Results figure 1120:**

|  |  |  |  |
|------------------|------------------|------------------|------------------|
| ![](images2/img_2b_8.png) | ![](images2/img_2b_32.png) | ![](images2/img_2b_64.png) | ![](images2/img_2b_128.png) |
| ![](images2/img_2b_8_hist.png) | ![](images2/img_2b_32_hist.png) | ![](images2/img_2b_64_hist.png) | ![](images2/img_2b_128_hist.png) |

Podemos observar dos cosas:

1.  Las imágenes con dimensiones 560x560 tienen un histograma más discontinuo (con huecos) que las imágenes con 1120x1120. Esto ocurre porque contienen menos cantidad de pixeles.
2.  También vemos un desplazamiento del histograma hacia la derecha según aumentamos la c de la transformación. Esto ocurre porque la c indica el punto donde comienza la saturación. Inicialmente es el 8, y esto va aumentando a 32, 64 y 128, creando cada vez una imagen más saturada hasta que todo el histograma se encuentra en los valores de gris claro y blanco (255).

Con respecto al uso o no de `axis tight` para visualizar el histograma, se puede decir que usandolo se puede observar bien cuanto se elevan todos los valores, como vemos en la imagen superior de las imagenes a continuación:

![](images2/axistight.png)

Sin embargo, como vemos en la imagen inferior se pierde algo de detalle en los valores de la zona intermedia ya que se reescalan. En mi opinión, en la imagen inferior se ve mejor la diferencia entre esos valores medios de grises, que en la otra que se han acortado.

### Estirando el histograma

Paso 1: Creamos la funcion `stretchimage.m`, para estirar un histograma:

``` {.MatLab .splus}
% Definimos la función
function [ima_stretch, s] = stretchimage(ima, nM, nm)
% STRETCHIMAGE  Estira el rango [m,M] -> [nm,nM] y satura fuera de ese intervalo.
% Devuelve ima_stretch (misma clase que ima si era uint8) y s (function handle).
%
% Uso: [Iout, s] = stretchimage(Iin, 255, 0)

    % convertir a double para cálculo (pero recordar la clase original)
    original_class = class(ima);
    ima_d = double(ima);

    m = min(ima_d(:));
    M = max(ima_d(:));

    if M == m
        % imagen constante -> salida constante nm
        s = @(px) nm * ones(size(px));
        ima_stretch_d = nm * ones(size(ima_d));
    else
        slope = (nM - nm) / (M - m);
        % function handle: operación elemento-a-elemento + saturación (clamp)
        s = @(px) min( max( ((double(px) - m) .* slope) + nm, nm ), nM );
        ima_stretch_d = s(ima_d);
    end

    % devolver en la misma clase que entró (si era uint8)
    if strcmp(original_class, 'uint8')
        ima_stretch = uint8(round(ima_stretch_d));
    else
        ima_stretch = ima_stretch_d;
    end
end
```

Paso 2: Cargamos la imagen y vemos su histograma:

``` splus
%% Cargar imagen Skin_gray_bc_560.tif, y visualizar con histograma
[ima, map] = imread('Imagenes_P2\Skin_gray_bc_560.tif');
L = size(map, 1);

figure; imshow(ima, map); title('Skin gray bc');
imwrite(ima, map, 'results/ej3_1.png');

figure; imhist(ima, map); axis tight
title('Hist Skin gray bc');
exportgraphics(gcf, 'results/ej3_1_hist.png', 'Resolution',150);
```

|                        |                             |
|------------------------|-----------------------------|
| ![](images2/ej3_1.png) | ![](images2/ej3_1_hist.png) |

Paso 3: estiramos el histograma con *nm* = 0 y *nM* = 255:

``` splus
%% Estirado a 0–255 con la función stretchimage
[ima_stretch, s] = stretchimage(ima, 255, 0);

imshow(ima_stretch, map); title('Stretch 0–255');
exportgraphics(gcf, 'results/ej3_1_stretch.png', 'Resolution',150);

figure; imhist(ima_stretch, map); axis tight
exportgraphics(gcf, 'results/ej3_1_stretch_hist.png', 'Resolution',150);
```

|                                |                                     |
|--------------------------------|-------------------------------------|
| ![](images2/ej3_1_stretch.png) | ![](images2/ej3_1_stretch_hist.png) |

Paso 4: Observamos la funcion de transformación

Para **plotear la transformación** (T(r)) de `stretchimage` (ya tenemos el handle `s`), tenemos que evaluarla en (r=0..255) y dibujar (r) vs (T(r)). Por último, añadimos la recta identidad y marcamos (m) y (M).

``` splus
% Curva de transformación T(r)
r = 0:255;              % niveles de entrada
T = s(r);               % niveles de salida (usa tu handle s)

f = figure;
plot(r, T, '-', 'LineWidth', 1.5); hold on
plot(r, r, '--');                      % referencia y = x
xlabel('r (entrada)'); ylabel('s = T(r) (salida)');
title('Transformación de estirado 0–255');
xlim([0 255]); ylim([0 255]); axis square; grid on

% Marcas en m y M (de tu imagen)
m = double(min(ima(:)));
M = double(max(ima(:)));
xline(m, ':'); xline(M, ':');
legend('T(r)','y = x','m','M','Location','southeast');

exportgraphics(f, 'results/ej3_1_func.png', 'Resolution',150);
close(f);
```

<img src="images2/ej3_1_func.png" width="350" height="350"/>

**Observaciones:**\
Las imágenes tienen cambios evidentes:

-   La imagen original tiene muy bajo contraste, los tonos de grises son similares y se observan poco las diferencias en las partes de la imagen. Por otro lado la imagen en la que hemos estirado el histograma muestra un contraste más alto, la lesion central ahora es mucho más evidente, ya que se observa más oscura, podemos ver los foliculos capilares de la piel y ciertas zonas con pigmentación más oscura y más clara que antes no eran evidentes.
-   En los histogramas, por otro lado, podemos ver que el de la imagen orgiginal consiste en un pico con la base muy estrecha, centrado en los grises medios (abarca desde el 85 al 165 de niveles de grises aproximadamente) y con las barras muy juntas. Mientras que el de la imagen que hemos alterado estirando el histograma, consiste en un pico con la base mucho más ancha, que comprende todos los niveles de grises desde 0 a 255 y sus barras están más separadas.

### Ecualizando el histograma

Paso 1: Creamos la funcion `equalizeimage.m`, para ecualizar un histograma:

``` splus
% Función: EcualizeImage
% Definimos la función
function [ima_eq,s] = equalizeimage(ima,nM,nm)
% EQUALIZEIMAGE - Ecualización de histograma
%   [ima_eq,s] = equalizeimage(ima,nM,nm)
%
% Entradas:
%   ima : imagen de entrada (uint8)
%   nM  : valor máximo del rango destino (ej. 255)
%   nm  : valor mínimo del rango destino (ej. 0)
%
% Salidas:
%   ima_eq : imagen ecualizada
%   s      : función de transformación (lookup table)

    % Asegurar tipo double para los cálculos
    ima_d = double(ima(:));
    L = nM - nm + 1;              % número de niveles (ej. 256)
    np = numel(ima_d);            % número total de píxeles

    % Histograma (np_k)
    h = imhist(uint8(ima), L);    % conteo de cada nivel

    % Probabilidad de cada nivel
    p_r = h / np;

    % Función de transformación (CDF reescalada)
    cdf = cumsum(p_r); 
    s = round(nm + (nM - nm) * cdf);

    % Aplicar la transformación: usar s como LUT
    ima_eq = s(ima_d + 1);        % +1 porque MATLAB indexa desde 1
    ima_eq = uint8(reshape(ima_eq, size(ima))); % devolver como imagen
end
```

Paso 2: ecualizamos el histograma con *nm* = 0 y *nM* = 255:

``` splus
%% Ecualización con la función equalize image
[ima_eq, s] = equalizeimage(ima, 255, 0);

imshow(ima_eq, map); title('Equalize 0–255');
exportgraphics(gcf, 'results/ej3_1_eq.png', 'Resolution',150);

figure; imhist(ima_eq, map); axis tight
exportgraphics(gcf, 'results/ej3_1_eq_hist.png', 'Resolution',150);
```

|                           |                                |
|---------------------------|--------------------------------|
| ![](images2/ej3_1_eq.png) | ![](images2/ej3_1_eq_hist.png) |

Paso 3: Observamos la función de transformación

``` splus
% Curva de transformación T(r)
r = 0:255;         
T = s(r + 1);           

f = figure;
plot(r, T, '-', 'LineWidth', 1.5); hold on
plot(r, r, '--');                      % referencia y = x
xlabel('r (entrada)'); ylabel('s = T(r) (salida)');
title('Transformación de equalización 0–255');
xlim([0 255]); ylim([0 255]); axis square; grid on

% Marcas en m y M (de tu imagen)
m = double(min(ima(:)));
M = double(max(ima(:)));
xline(m, ':'); xline(M, ':');
legend('T(r)','y = x','m','M','Location','southeast');

exportgraphics(f, 'results/ej3_1b_func.png', 'Resolution',150);
close(f);
```

<img src="images2/ej3_1b_func.png" width="350" height="350"/>

**Observaciones:**\
Ahora la imagen tiene un contraste muy alto entre claros y oscuros, causando un emborronamiento y que no se vean bien los detalles importantes de la misma. El histograma de la misma presenta muy pocos valores en los grises medios y la mayoría de los valores de grises están desplazados a los muy oscuros y muy claros.

Por otro lado, las principales diferencias entre las funciones son la forma sigmoidal de esta segunda y la brusquedad de su pendiente, lo cual ocasiona que haya un desplazamiento de los valores centrales de grises a los valores muy oscuros y muy claros.