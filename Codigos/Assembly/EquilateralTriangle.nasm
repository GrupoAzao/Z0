leaw $SCREEN,%A
movw %A,%D
leaw $480,%A
addw %A,%D,%D
movw %D,%A
movw $-1,(%A)


;Desenhando as linhas dos outros dois lados pixels do topo

;Linha 1
leaw $256,%A
mov %A,%D
leaw $16384,%A
movw %D,(%A)

;Linha 2
leaw $384,%A
mov %A,%D
leaw $16416,%A
movw %D,(%A)

;Linha 3
leaw $384,%A
mov %A,%D
leaw $16448,%A
movw %D,(%A)

;Linha 4
leaw $576,%A
mov %A,%D
leaw $16480,%A
movw %D,(%A)

;Linha 5
leaw $576,%A
mov %A,%D
leaw $16512,%A
movw %D,(%A)

;Linha 6
leaw $1056,%A
mov %A,%D
leaw $16544,%A
movw %D,(%A)

;Linha 7
leaw $1056,%A
mov %A,%D
leaw $16576,%A
movw %D,(%A)

;Linha 8
leaw $2064,%A
mov %A,%D
leaw $16608,%A
movw %D,(%A)

;Linha 9
leaw $2064,%A
mov %A,%D
leaw $16640,%A
movw %D,(%A)

;Linha 10
leaw $4104,%A
mov %A,%D
leaw $16672,%A
movw %D,(%A)

;Linha 11
leaw $4104,%A
mov %A,%D
leaw $16704,%A
movw %D,(%A)

;Linha 12
leaw $8196,%A
mov %A,%D
leaw $16736,%A
movw %D,(%A)

;Linha 13
leaw $8196,%A
mov %A,%D
leaw $16768,%A
movw %D,(%A)

;Linha 14
leaw $16386,%A
mov %A,%D
leaw $16800,%A
movw %D,(%A)

;Linha 15
leaw $16386,%A
mov %A,%D
leaw $16832,%A
movw %D,(%A)