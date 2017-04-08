leaw $SCREEN,%A
movw %A,%D
leaw $480,%A
addw %A,%D,%D
movw %D,%A
movw $-1,(%A)
;Um triangulo 16 por 16 feio pacas
;divido em 15 blocos de comando

leaw $256,%A
mov %A,%D
leaw $16384,%A
movw %D,(%A)

leaw $384,%A
mov %A,%D
leaw $16416,%A
movw %D,(%A)

leaw $384,%A
mov %A,%D
leaw $16448,%A
movw %D,(%A)

leaw $576,%A
mov %A,%D
leaw $16480,%A
movw %D,(%A)

leaw $576,%A
mov %A,%D
leaw $16512,%A
movw %D,(%A)

leaw $1056,%A
mov %A,%D
leaw $16544,%A
movw %D,(%A)

leaw $1056,%A
mov %A,%D
leaw $16576,%A
movw %D,(%A)

leaw $2064,%A
mov %A,%D
leaw $16608,%A
movw %D,(%A)

leaw $2064,%A
mov %A,%D
leaw $16640,%A
movw %D,(%A)

leaw $4104,%A
mov %A,%D
leaw $16672,%A
movw %D,(%A)

leaw $4104,%A
mov %A,%D
leaw $16704,%A
movw %D,(%A)

leaw $8196,%A
mov %A,%D
leaw $16736,%A
movw %D,(%A)

leaw $8196,%A
mov %A,%D
leaw $16768,%A
movw %D,(%A)

leaw $16386,%A
mov %A,%D
leaw $16800,%A
movw %D,(%A)

leaw $16386,%A
mov %A,%D
leaw $16832,%A
movw %D,(%A)
