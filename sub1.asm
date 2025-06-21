.data
prompt_n:        .asciz "n: "
prompt_k:        .asciz "k: "
prompt_temp:     .asciz "temp: "
newline:         .asciz "\n"
prefix:          .asciz "Bloques crecientes: "
arrow:           .asciz " -> "
detected:        .asciz "\nTendencia detectada desde indice "
not_detected:    .asciz "\nSin tendencias detectadas\n"
    .align 2
arr:             .space 400      # up to 100 integers
sums:            .space 400      # up to 100 window sums

.text
.globl main
main:
    # leer n
    li a7, 4
    la a0, prompt_n
    ecall
    li a7, 5
    ecall
    mv s0, a0         # n

    # leer k
    li a7, 4
    la a0, prompt_k
    ecall
    li a7, 5
    ecall
    mv s1, a0         # k

    # leer temperaturas
    li t0, 0          # i
    la t1, arr
read_loop:
    bge t0, s0, end_read
    li a7, 4
    la a0, prompt_temp
    ecall
    li a7, 5
    ecall
    sw a0, 0(t1)
    addi t1, t1, 4
    addi t0, t0, 1
    j read_loop
end_read:

    # num_windows = n - k + 1
    sub t2, s0, s1
    addi t2, t2, 1
    mv s2, t2         # guardar num_windows

    li t0, 0          # i
    la t5, sums       # puntero a sums
    la t4, arr        # base del arreglo
compute_outer:
    bge t0, s2, end_compute
    mv t3, zero       # sum = 0
    li t1, 0          # j
compute_inner:
    bge t1, s1, end_inner
    add t6, t0, t1
    slli t6, t6, 2
    add t6, t6, t4
    lw t2, 0(t6)
    add t3, t3, t2
    addi t1, t1, 1
    j compute_inner
end_inner:
    sw t3, 0(t5)
    addi t5, t5, 4
    addi t0, t0, 1
    j compute_outer
end_compute:

    # imprimir "Bloques crecientes: "
    li a7, 4
    la a0, prefix
    ecall

    # imprimir sums con flechas
    la t5, sums
    li t0, 0
print_loop:
    bge t0, s2, end_print
    lw a0, 0(t5)
    li a7, 1
    ecall
    addi t5, t5, 4
    addi t0, t0, 1
    bge t0, s2, end_print
    li a7, 4
    la a0, arrow
    ecall
    j print_loop
end_print:
    li a7, 4
    la a0, newline
    ecall

    # detectar tendencia creciente en al menos 3 bloques
    li t0, 0          # indice
    li t1, -1         # start index
    la t5, sums
trend_loop:
    addi t6, s2, -2
    bge t0, t6, check_result
    lw t2, 0(t5)      # sums[i]
    lw t3, 4(t5)      # sums[i+1]
    lw t4, 8(t5)      # sums[i+2]
    bge t2, t3, next_trend
    bge t3, t4, next_trend
    mv t1, t0
    j check_result
next_trend:
    addi t5, t5, 4
    addi t0, t0, 1
    j trend_loop

check_result:
    blt t1, zero, no_trend
    li a7, 4
    la a0, detected
    ecall
    mv a0, t1
    li a7, 1
    ecall
    li a7, 4
    la a0, newline
    ecall
    j finish
no_trend:
    li a7, 4
    la a0, not_detected
    ecall
finish:
    li a7, 10
    ecall