; Diamond.nasm

; Desenha um Losango na tela.


leaw $2000, %A
movw %A, %D
leaw $SCREEN, %A
addw %A, %D, %D
leaw $R, %A
movw %D, (%A)
leaw $16, %A
movw %A, %D
leaw $contador, %A
movw %D, (%A)
loop:
leaw $R, %A
movw (%A), %A
movw $-1, (%A)
leaw $32, %A
movw %A,%D
leaw $R, %A
movw (%A), %A
addw %A, %D, %D
leaw $R, %A
movw %D, (%A)
leaw $contador, %A
decw (%A)
movw (%A), %D
leaw %loop, %A
jne
