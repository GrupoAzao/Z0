; Arquivo: testComp.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 16/04/2017

movw %A,%D
addw %A,%D,%D
movw %D,%A
movw %D,(%A)
incw %D
nop
movw (%A),%D
addw (%A),%D,%D
subw %D,(%A),%A
rsubw %D,(%A),%A
decw %A
decw %D
notw %A
notw %D
negw %A
negw %D
andw (%A),%D,%D
andw %D,%A,%A
orw (%A),%D,%D
orw %D,%A,%A