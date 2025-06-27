# LAB-4-INF245

Este repositorio contiene implementaciones en assembly para los laboratorios de INF245.

## Sub1

`sub1.asm` implementa una suma de bloque deslizante sobre una secuencia de temperaturas y detecta tendencias crecientes sostenidas.
El programa calcula la suma de cada ventana de tamaño `k` y luego recorre dichas sumas para identificar tres o más incrementos consecutivos.
### Ejecución

Utiliza el archivo `rars1_6.jar` proporcionado para ensamblar y ejecutar:

```bash
java -jar rars1_6.jar sub1.asm < input.txt
```

Entradas:
1. Entero `n` (número de temperaturas, `5 <= n <= 100`)
2. Entero `k` (tamaño del bloque, `k < n`)
3. `n` enteros que representan las temperaturas

El programa imprime las sumas de cada bloque y reporta el primer índice donde tres o más sumas consecutivas son crecientes.

## Sub2

`sub2.asm` verifica si una cadena ASCII cumple que la cantidad de letras
mayúsculas es par y la de dígitos es impar. De ser válida, encripta el código
aplicando XOR con `0x5A` a cada carácter y lo imprime en hexadecimal.

### Ejecución

Utiliza el archivo `rars1_6.jar` proporcionado para ensamblar y ejecutar:

```bash
java -jar rars1_6.jar sub2.asm < input.txt
```

Entrada:
- Una cadena ASCII de máximo 64 caracteres

El programa valida la cadena si cumple con los requisitos de digitos numericos impar y letras mayusculas par, si lo es, lo encripta por `0x5A`.

Salida:
- Rechazo o aceptación de la validación. Si es válido entrega el código encriptado.

## Supuestos

- Para `sub2.asm` la cadena termina en nueva línea y no supera los 64 caracteres.

## Contacto

* **Sebastián Richiardi**, Rol: 202030555-2, Paralelo: 201  
* **Gabriel Alejandro Toro Varela**, Rol: 202204557-4, Paralelo: 201
