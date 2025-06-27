.data
    prompt_input:   .asciz "Ingresa el código de misión: "
    buffer:         .space 65

    mensaje_inval:  .asciz "Código inválido\n"
    encabezado:     .asciz "Código encriptado: ["
    cierre:         .asciz "]\n"
    mensaje_valido: .asciz "Código válido\n"
    coma_espacio:   .asciz ", "
    cero_x:         .asciz "0x"
    hex_digitos:    .asciz "0123456789ABCDEF"

.text
.globl main

main:
    # Mostrar mensaje para ingresar código
    li a7, 4
    la a0, prompt_input
    ecall

    # Leer string
    li a7, 8
    la a0, buffer
    li a1, 65
    ecall

    # Inicializar puntero y contadores
    la s0, buffer     # puntero al string
    li t0, 0          # contador mayúsculas
    li t1, 0          # contador dígitos

contar_loop:
    lb t2, 0(s0)
    beqz t2, validar

    li t3, 65         # 'A'
    li t4, 90         # 'Z'
    blt t2, t3, revisar_digito
    bgt t2, t4, revisar_digito
    addi t0, t0, 1
    j siguiente

revisar_digito:
    li t3, 48         # '0'
    li t4, 57         # '9'
    blt t2, t3, siguiente
    bgt t2, t4, siguiente
    addi t1, t1, 1

siguiente:
    addi s0, s0, 1
    j contar_loop

validar:
    andi t2, t0, 1         # t2 = mayúsculas % 2
    andi t3, t1, 1         # t3 = dígitos % 2
    bnez t2, invalido
    beqz t3, invalido

    # Si válido ? imprimir encabezado
    li a7, 4
    la a0, encabezado
    ecall

    # Preparar impresión del string encriptado
    la s0, buffer
    li s1, 0           # flag primer elemento
    li t4, 0x5A        # clave XOR

xor_loop:
    lb t2, 0(s0)
    li t3, 10          # '\n'
    beq t2, t3, cerrar
    beqz t2, cerrar

    xor t5, t2, t4     # XOR con 0x5A

    beqz s1, sin_coma
    li a7, 4
    la a0, coma_espacio
    ecall
sin_coma:
    addi s1, s1, 1

    # Imprimir 0x
    li a7, 4
    la a0, cero_x
    ecall

    # Imprimir nibble alto
    andi t6, t5, 0xF0
    srli t6, t6, 4
    la t0, hex_digitos
    add t6, t0, t6
    lb a0, 0(t6)
    li a7, 11
    ecall

    # Imprimir nibble bajo
    andi t6, t5, 0x0F
    la t0, hex_digitos
    add t6, t0, t6
    lb a0, 0(t6)
    li a7, 11
    ecall

    addi s0, s0, 1
    j xor_loop

cerrar:
    li a7, 4
    la a0, cierre
    ecall

    li a7, 4
    la a0, mensaje_valido
    ecall

    j fin

invalido:
    li a7, 4
    la a0, mensaje_inval
    ecall

fin:
    li a7, 10
    ecall
