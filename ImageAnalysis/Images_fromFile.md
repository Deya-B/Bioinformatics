### Lectura de imágenes a partir de un archivo
Utilizar la función `imread()`.

```splus
[ima,map]=imread(‘MRI_pseudo_colored.jpg’)
```

#### Imagenes indexadas
- `ima` es una matriz o array de dos dimensiones de tipo uint8 o uint16, 
- `map` es su tabla de colores

#### Imagenes *true-color*
- Imagen en la que el valor de cada píxel indica directamente su color.
- En estas imágenes `map` está vacío
- Puede estar formada por dos o tres bandas o matrices de tipo `uint8` (es decir, un array **2D** o **3D**):
  - array de **dos dimensiones** = a cada elemento de la imagen le corresponde un valor. El valor de los píxeles es directamente un nivel de luminancia o nivel de gris que va de 0 (negro) a 255 (blanco); por lo que no incluye información de color.
  - array de **tres dimensiones** = a cada elemento de la imagen le corresponden tres valores enteros que indican directamente las componentes roja, verde y azul de cada píxel, cada una de ellas variable entre 0 (componente inexistente) y 255 (máxima saturación en esa componente).
- **Imágenes binarias**: son un tipo especial que solamente presenta dos valores
  - están formadas por una sola banda (es decir, un array de **1D**) de tipo `uint8` (con valores 0 o 255), o `logical` (con valores 0 o 1).
