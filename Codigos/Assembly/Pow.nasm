; Pow.nasm

; Eleva ao quadrado o valor da RAM[1] e armazena o resultado na RAM[0].
; Só funciona com números positivos

leaw $1, %A
movw (%A), %D

leaw $2, %A
movw %D, (%A)

leaw $3, %A
movw %D, (%A)

multiply:
leaw $2, %A
movw (%A), %D
leaw $0, %A
addw %D, (%A), (%A)
leaw $3, %A
decw (%A)
movw (%A), %D

leaw $multiply, %A
jg
