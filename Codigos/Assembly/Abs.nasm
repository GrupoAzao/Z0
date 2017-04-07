; Abs.nasm
; Copia o valor de RAM[1] para RAM[0] deixando o valor sempre positivo.
; se valor positivo =
; se neg = -valor
leaw $1, %A
movw (%A), %D
leaw $POSITIVO, %A
jge
nop
leaw $NEGATIVO, %A
jmp
nop
POSITIVO:
leaw $0, %A
movw %D, (%A)
leaw $FIM, %A
jmp
nop
NEGATIVO:
negw %D
leaw $0, %A
movw %D, (%A)
leaw $FIM, %A
FIM:
