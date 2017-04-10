; RightTriangle.nasm
; Desenha um triângulo retângulo na tela.

; Primeira linha
movw $-1, %A
movw %A, %D
leaw %SCREEN, %A
movw %D, (%A)
; Segunda linha
movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $32767, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $16383, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)


movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $8191, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $4095, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $2047, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $1023, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $511, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $255, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $127, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $63, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $31, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $15, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $7, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $3, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)

movw %A, %D
leaw $32,%A
addw %A, %D, %A
movw %A, %D
leaw $0, %A
movw %D, (%A)
leaw $1, %A
movw %A,%D
leaw $1,%A
movw %D,(%A)
leaw $0, %A
movw (%A), %A
movw %D,(%A)
