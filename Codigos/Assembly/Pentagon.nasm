; Pentagon.nasm

; Desenha um pentâgono na tela.

leaw $384,%A
movw %A,%D
leaw $16384,%A
movw %D,(%A)

;Linha 2
leaw $960,%A
movw %A,%D
leaw $16416,%A
movw %D,(%A)

;Linha 3
leaw $2016,%A
movw %A,%D
leaw $16448,%A
movw %D,(%A)

;Linha 4
leaw $8184,%A
movw %A,%D
leaw $16480,%A
movw %D,(%A)

;Linha 5
leaw $16380,%A
movw %A,%D
leaw $16512,%A
movw %D,(%A)

;Linha 6
leaw $32766,%A
movw %A,%D
leaw $16544,%A
movw %D,(%A)











;Linha 7
leaw $0,%A
not %A
movw %A,%D
leaw $16576,%A
movw %D,(%A)

;Linha 8
leaw $0,%A
not %A
movw %A,%D
leaw $16608,%A
movw %D,(%A)
















;Linha 9
leaw $32766,%A
movw %A,%D
leaw $16640,%A
movw %D,(%A)

;Linha 10
leaw $32766,%A
movw %A,%D
leaw $16672,%A
movw %D,(%A)

;Linha 11
leaw $32766,%A
movw %A,%D
leaw $16704,%A
movw %D,(%A)

;Linha 12
leaw $16380,%A
movw %A,%D
leaw $16736,%A
movw %D,(%A)

;Linha 13
leaw $16380,%A
movw %A,%D
leaw $16768,%A
movw %D,(%A)

;Linha 14
leaw $16380,%A
movw %A,%D
leaw $16800,%A
movw %D,(%A)

;Linha 15
leaw $8184,%A
movw %A,%D
leaw $16832,%A
movw %D,(%A)

;Linha 16
leaw $8184,%A
movw %A,%D
leaw $16864,%A
movw %D,(%A)
