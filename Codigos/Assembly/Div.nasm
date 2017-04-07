; Div.nasm

; Divide R0 por R1 e armazena o resultado em R2.
; (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
; divisao para numeros inteiros positivos

leaw $0, %A
movw (%A), %D
loop:
leaw $1, %A
subw  %D, (%A), %D
leaw $2, %A
incw (%A)
leaw $loop, %A
jge
leaw $2, %A
decw (%A)
