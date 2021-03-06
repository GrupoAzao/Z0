; SternDiatomicSeries.nasm

; Calcula a série Stern’s Diatomic, a quantidade de elementos gerados é RAM[0]*2+1
; Os resultados são armazenados na RAM[1], RAM[2], etc....
; A série deve gerar: 1,1,2,1,3,2,3,1,4,3,5,2,5,3,4,1,5,4,7,3,8,5,7,2,7,5, etc...

leaw $0,%A   ;vai conferir se existe valor na RAM[0]
movw (%A), %D
decw %D
decw %D
leaw $PULA, %A
jle

leaw $0,%A   ;vai ser a quantidade de elementos
movw (%A), %D
addw %D, (%A), (%A)
incw (%A)

; iniciando os primeiros valores:1,1,2
leaw $1,%A
incw (%A)
leaw $2,%A
incw (%A)
leaw $3,%A
incw (%A)
incw (%A)

leaw $4, %A
movw %A, %D
leaw $16000, %A   ;i=contador onde vai ser o proximo numero
movw %D, (%A)   ;inicia o contador com 4, ja que a lista esta no valor 3


LOOP:   ;vai definir se é par ou impar

;mod para ver se eh par
leaw $16000,%A
movw (%A),%D
leaw %16001,%A
movw %D,(%A)
repete:
leaw $2, %A 		; Carrega 2 para A
movw %A, %D 		; Move A[2] para D
leaw $16001, %A 		; Carrega 16001 para A
subw (%A), %D, (%A) ; Subtrai D de A[16001] e armazena no A[16001]
movw (%A),%D 		; Move A[16001] para D
leaw $repete, %A 	; Repete o loop se D for maior ou igual a zero
jg
leaw %LOOP_IMPAR,%A
jl

;valores pares
leaw $16000, %A
movw (%A), %D
leaw $16001,%A
movw %D, (%A)
leaw $0, %A
movw %A,%D
leaw $16002,%A
movw %D,(%A)

dividi:    ;dividi por 2
leaw $2, %A
movw %A, %D
leaw $16001, %A
subw (%A), %D, (%A)
movw (%A), %D
leaw $16002, %A
incw (%A)
leaw $dividi, %A
jg

;faz A[i]=A[i/2]
leaw $16002, %A
movw (%A),%D
movw (%A),%A
movw (%A),%D
leaw $16000,%A
movw (%A),%A
movw %D,(%A)

leaw $PULA, %A
jmp    ; faz o salto quando entra no par, assim, so faz o par

LOOP_IMPAR:   ;pega o valor de A[(i-1)/2]+A[(i+1)/2]  e coloca no A[16002]

;vai fazer o A[(i-1)/2] e colocar no A[16002]
leaw $16000, %A
movw (%A), %D
decw %D
leaw $16001,%A   ;i-1
movw %D, (%A)
leaw $0, %A
movw %A,%D
leaw $16002,%A
movw %D,(%A)
leaw $16003,%A
movw %D,(%A)

dividiimpar1:
leaw $2, %A
movw %A, %D
leaw $16001, %A
subw (%A), %D, (%A)
movw (%A), %D
leaw $16002, %A
incw (%A)
leaw $dividiimpar1, %A
jg

leaw $16002, %A
movw (%A),%D
movw %D, %A
movw (%A),%D
leaw $16002, %A
movw %D, (%A)

;vai fazer o A[(i+1)/2] e colocar no A[16003]
leaw $16000, %A
movw (%A), %D
incw %D
leaw $16001,%A
movw %D, (%A)


dividiimpar2:
leaw $2, %A
movw %A, %D
leaw $16001, %A
subw (%A), %D, (%A)
movw (%A), %D
leaw $16003, %A
incw (%A)
leaw $dividiimpar2, %A
jg

leaw $16003, %A
movw (%A),%D
movw %D, %A
movw (%A),%D
leaw $16003, %A
movw %D, (%A)

;faz a soma A[(i-1)/2]+A[(i+1)/2] e coloca no A[16002]
leaw $16003, %A
movw (%A),%D
leaw $16002, %A
addw (%A),%D,(%A)

;faz A[i]=A[(i-1)/2]+A[(i+1)/2]
movw (%A),%D
leaw $16000,%A
movw (%A),%A
movw %D,(%A)

PULA:
leaw $16000, %A
incw (%A)    ;aumenta um no contador

movw (%A), %D  ;inicio do loop para verificar se ainda precisa colocar numeros ou nao
leaw $0, %A
subw (%A),%D,%D ;faz a condicao do jump, quantidade da lista menos posicao atual
leaw $LOOP,%A
jge

END:
leaw $END, %A
jmp
