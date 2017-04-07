; Parallelogram.nasm

leaw $2000, %A 			; Carrega 2000 para A
movw %A, %D 			; Move A[2000] para D
leaw $SCREEN, %A
addw %A, %D, %D


leaw $R, %A
movw %D, (%A)


leaw $16, %A 			; Carrega 16 para A
movw %A, %D 			; Move A[16] para D
leaw $contador, %A
movw %D, (%A)


loop:
leaw $R, %A 			; Carrega R para A
movw (%A), %A 			; Move A[16] para A
movw $-1, (%A)

leaw $32, %A 			; Carrega 32 para A
movw %A, %D 			; Move A[32] para D

leaw $R, %A 			; Carrega R para A
movw (%A), %A 			; Move A[R] para A

addw %A, %D, %D    		; Soma A[R] e D, armazena no D
leaw $R, %A 			; Carrega R para A
movw %D, (%A) 			; Move D para A

leaw $contador, %A
decw (%A)
movw (%A), %D

leaw %loop, %A
jne

; Desenha um paralelograma na tela.