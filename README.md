# LAB-4-INF245

Este repositorio contiene implementaciones en assembly para los laboratorios de INF245.

## Sub1

`sub1.asm` implementa una suma de bloque deslizante sobre una secuencia de temperaturas y detecta tendencias crecientes sostenidas.

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

`sub2.asm` es un programa de encriptacion para cierto tipo de strings segun su paridad.

### Ejecución

Utiliza el archivo `rars1_6.jar` proporcionado para ensamblar y ejecutar:

```bash
java -jar rars1_6.jar sub2.asm < input.txt
```

Entrada:
- Una cadena ASCII de maximo 64 char

El programa valida la cadena si cumple con los requisitos de digitos numericos impar y letras mayusculas par, si lo es, lo encripta por 0x5A.

Salida:
- Rechazo o aceptacion de la validacion, si es valido entrega el codigo encriptado.

## Contacto

* **Sebastián Richiardi**, Rol: 202030555-2, Paralelo: 201  
* **Gabriel Alejandro Toro Varela**, Rol: 202204557-4, Paralelo: 201
