# Segmentación básica

## Umbralización

Umbralización de imágenes es un caso particular del recorte, cuyo objetivo principal es la segregación, separación o segmentación de los dos niveles o clases de una imagen bimodal a las que solemos referirnos como frente y fondo.

**Objetivo**: umbralizar una imagen en escala de grises que, en principio, no es bimodal, pero en la cual puede apreciarse una clase diferenciada.

``` splus
% Cargar y representar MRI_gray.jpg con su histograma
img = imread('Imagenes_P3\MRI_gray.jpg');
E_img  = calcularEnergia(img);
imshow(img); title(sprintf('Imagen original E=%.5g', E_img));
exportgraphics(gcf, 'results/ej1.png', 'Resolution',150);

% Histograma
histFig = figure; imhist(img); axis('tight');
exportgraphics(histFig, 'results/img_1_hist.png');
```

<img src="\images3\img_1.png""/>
<img src="\images3\img_1_hist.png""/>

### Umbralización global de imágenes bimodales
