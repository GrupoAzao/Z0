; Mod.nasm

; Divide o número posicionado na A[1] pelo número posicionado no A[2] e armazena o resto na A[0].

repete:

leaw $2, %A 		; Carrega 2 para A
movw (%A), %D 		; Move A[2] para D
leaw $1, %A 		; Carrega 1 para A
subw (%A), %D, (%A) ; Subtrai D de A[1] e armazena no A[1]
movw (%A),%D 		; Move A[1] para D
leaw $repete, %A 	; Repete o loop se D for maior ou igual a zero
jge

; Soma + [A(2)]

leaw $2, %A 		; Carrega 2 para A
movw (%A), %D 		; Move A[2] para D
leaw $1, %A 		; Carrega 1 para A
addw (%A), %D, %D 	; Soma A[1] e D, armazena no D
leaw $0, %A 		; Carrega 0 para A
movw %D, (%A) 		; Move D para A[0]

END:
leaw $END,%A
jmp