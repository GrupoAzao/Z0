; Fibonacci.nasm

; Le a quantidade de valores da RAM[0] e grava a sequencia de números 
; de Fibonacci nas posições seguintes RAM[1], RAM[2], etc....
; Por exemplo: se RAM[0]=6
; RAM[1]=0, RAM[2]=1, RAM[3]=1, RAM[4]=2, RAM[5]=3, RAM[6]=5
; Maiores informações em: https://oeis.org/A000045

leaw $0,%A
movw (%A),%D ; D = R[0]
leaw $FIM, %A
je ; se R[0] = 0, acaba
nop

decw %D
leaw $1,%A
movw $0, (%A); faz R[1] = 0
leaw $FIM, %A
je ; se R[0] = 1 acaba
nop

decw %D
leaw $2,%A
movw $1,(%A); faz R[2] = 1
leaw $FIM, %A
je ; se R[0] = 2 acaba
nop



LOOP:

decw %D
leaw $SCREEN, %A
movw %D, (%A); guarda o numero q estamos em SCREEN

leaw $0,%A
subw (%A),%D,%A; faz A apontar pro proximo espaco na RAM

decw %A
movw (%A),%D
incw %A
movw %D, (%A)

decw %A
decw %A
movw (%A),%D
incw %A
incw %A
addw (%A),%D,(%A)

leaw $SCREEN, %A
movw (%A), %D; guarda o numero q estamos em D

leaw $LOOP, %A
jne ; continua enquanto D =/= 0
nop

FIM: