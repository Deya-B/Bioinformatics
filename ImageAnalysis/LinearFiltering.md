## Linear Filtering

Linear filtering (or linear spatial filtering) is a fundamental method in image processing where the output intensity of a pixel is determined by a **weighted sum** (a sum-of-products operation) of the pixel intensities in its immediate neighborhood, where the weights are defined by a small array called the **filter kernel** (or mask, template, or window).

``` splus
%% Cargar la imagen original
Irgb = imread('Imagenes_P2/MRI_pseudo_colored.jpg');
% Trabajando en blanco y negro
I = rgb2gray(Irgb);                 % o procesa cada canal por separado
Id = im2double(I);

% Kernel 7x7 con fila central [7 6 4 1 4 6 7] normalizada
row = [7 6 4 1 4 6 7];
C = sum(row);              % Suma de pesos = 35 > calc el mayor valor posible de y
w = zeros(7,7); 
w(4,:) = row / C;          % normalizado > divide cada peso entre 35

% Filtrado
If = imfilter(Id, w, 'replicate', 'same');  % corr = conv (máscara simétrica)

% Mostrar y guardar
figure;
subplot(1,2,1), imshow(I),  title('Original');
subplot(1,2,2), imshow(If), title('Filtrada (suavizado 1D)');
exportgraphics(gcf, 'results/ej4_0.png', 'Resolution',150);
```

<img src="/images2/ej4_0.png"/>