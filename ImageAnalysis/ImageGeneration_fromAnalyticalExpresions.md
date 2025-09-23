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

<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/c4d9cff2-2991-4d87-b1a5-a7091c719a9e" />

```splus
% 5) Representar varias imágenes:
subplot(1,2,1), imshow(f,[-2 2]); colorbar
subplot(1,2,2), imshow(f,[-1 1]); colorbar
```
<img width="600" height="230" alt="Figure_2" src="https://github.com/user-attachments/assets/9d136866-889d-49a7-8726-160cd769a678" />


```splus
```


```splus
```


```splus
```

