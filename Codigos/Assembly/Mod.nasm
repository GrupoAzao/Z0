; Mod.nasm

; Divide o número posicionado na A[1] pelo número posicionado no A[2] e armazena o resto na A[0].

repete:

leaw $2, %A 		; Carrega 2 para A
movw (%A), %D 		; Move A[2] para D
leaw $1, %A 		; Carrega 1 para A
subw (%A), %D, %A   ; Subtrai D de A[1]
leaw $repete, %A 	; Repete o loop se D for menor ou igual a zero
jge

; Soma + [A(2)]

leaw $2, %A
movw (%A), %D
leaw $1, %A
addw (%A), %D, %D
leaw $0, %A
movw %D, (%A)

