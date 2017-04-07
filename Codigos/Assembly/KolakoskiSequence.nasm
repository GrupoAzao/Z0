; KolakoskiSequence.nasm

; Le a quantidade de valores da RAM[0] e grava a sequencia de números
; da Sequencia de Kolakoski nas posições seguintes RAM[1], RAM[2], etc....
; Por exemplo: se RAM[0]=6
; RAM[1]=1, RAM[2]=2, RAM[3]=1, RAM[4]=1, RAM[5]=2, RAM[6]=1
; Maiores informações em: https://oeis.org/A000002


; criacao de variavel
leaw $1, %A
movw $1,(%A)

leaw $2, %A
movw $1,(%A)
incw (%A)

leaw $3, %A
movw $1,(%A)
incw (%A)


;i=3------contador unitario(vai ler a casas)
leaw $100,%A
movw $1,(%A)
incw (%A)
incw (%A)

;k=2
leaw $101,%A
movw $1,(%A)
incw (%A)

;j=4-------contador da ultima casa(vai colocar os numeros na ultima casa)
leaw $102,%A
movw $1, (%A)
incw (%A)
incw (%A)
incw (%A)


LOOP:

;fazer k=1 ou k=2
leaw $101,%A
subw (%A),$1,%D
leaw $PASSA2,%A
je
leaw $101,%A
decw (%A)
leaw $PASSA3
jmp
PASSA2:
;vira 2
leaw $101,%A
incw (%A)
PASSA3:

leaw $101,%A    ;k
movw (%A),%D    ;copia valor de k
leaw $102,%A    ;j
movw (%A),%A    ; copio valor de j
movw %D,(%A)    ; grava RAM[j]

leaw $100,%A
movw (%A),%A
subw (%A),$1,%D
decw %D
leaw $PASSA,%A
jne


leaw $102,%A
incw (%A)  ;acrescenta mais 1 quando valor k[i]==2

leaw $101,%A    ;k
movw (%A),%D    ;copia valor de k
leaw $102,%A    ;j                       ;SE k[i]=2 tem colocar outro k
movw (%A),%A    ; copio valor de j
movw %D,(%A)    ; grava RAM[j]

PASSA:
leaw $100,%A
incw (%A) ;acrescenta 1 sempre ao i

leaw $102,%A
incw (%A) ;acrescenta 1 sempre ao j

leaw $100,%A    ;i
movw (%A),%D    ; copio valor de i
leaw $0,%A      ; aponta RAM[0]
movw (%A),%A    ; RAM[0]
subw %D,%A,%D   ; D = i - n
leaw $LOOP,%A
jl

END:
leaw $END,%A
jmp
