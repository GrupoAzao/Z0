; SquareWave.nasm

; Adiciona contadores
leaw $5,%A
movw %A,%D
leaw $0,%A
movw %D,(%A)


HORIZONTAIS:
; Adiciona as linhas horizontais
leaw $SCREEN,%A

movw %A,%D
movw $-1,(%A)
incw %A
movw $1,(%A)
incw %A
movw $-1,(%A)
movw %A,%D
movw $-1,(%A)
incw %A
movw $1,(%A)
incw %A
movw $-1,(%A)
movw %A,%D
movw $-1,(%A)
incw %A
movw $1,(%A)
incw %A
movw $-1,(%A)
movw %A,%D
movw $-1,(%A)
incw %A
movw $1,(%A)
incw %A

; linhas embaixo
leaw $SCREEN,%A
movw %A,%D
leaw $257,%A
addw %A,%D,%A
movw $-1,(%A)
incw %A
incw %A
movw $-1,(%A)
incw %A
incw %A
movw $-1,(%A)

; ---------- bloco q diminui
; movw %A,%D
; leaw $257,%A
; addw %A,%D,%A
; movw $-1,(%A)

; Adiciona as linhas verticais
leaw $SCREEN,%A
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)

leaw $SCREEN,%A
incw %A

movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)

leaw $SCREEN,%A
incw %A
incw %A

movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)


leaw $SCREEN,%A
incw %A
incw %A
incw %A

movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)

leaw $SCREEN,%A
incw %A
incw %A
incw %A
incw %A

movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)

leaw $SCREEN,%A
incw %A
incw %A
incw %A
incw %A
incw %A

movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)

leaw $SCREEN,%A
incw %A
incw %A
incw %A
incw %A
incw %A
incw %A

movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)

leaw $SCREEN,%A
incw %A
incw %A
incw %A
incw %A
incw %A
incw %A
incw %A

movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)
movw %A,%D
leaw $32,%A
addw %A,%D,%A
movw $1,(%A)






























; ; Define quantas vezes o jump down e up será realizado
; leaw $15,%A
; movw %A,%D
; leaw $2,%A
; movw %D,(%A)
;
; ; Define a coordenada da ram inicial do display na ram[0]
; leaw $SCREEN,%A
; movw %A,%D
; leaw $0,%A
; movw %D,(%A)
;
; ; Adiciona um bit invertido na ram[1]
; movw $-1,%D
; leaw $1,%A
; movw %D,(%A)
;
; ; Adiciona uma linha reta + 1 pixel no endereço apontado por ram[0]
; LINE:
; leaw $0,%A
; movw (%A),%D
; movw %D,%A
; movw $-1,(%A)
; addw %A,$1,%D
; movw %D,%A
; movw $1,(%A)
;
; ; Adiciona um pixel embaixo do atual
;
; DOWN:
; leaw $32,%A
; addw %A,%D,%A
; movw $1,(%A)
; movw %A,%D

; leaw $2, %A
; movw (%A),%D
; decw (%A)
; leaw $DOWN, %A
; jg

; leaw $0,%A
; movw %D,$SCREEN
; movw %A,%D
; leaw $SCREEN,%A
; movw %D,(%A)
;
; leaw $512,%A
; leaw %A,%D
;
; leaw $SCREEN,%A
;
; addw %A,$512,%A
