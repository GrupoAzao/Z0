; Arquivo: loop.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 16/04/2017

leaw $0,%A
movw %A,%D
LOOP:
incw %D
leaw $LOOP,%A
jmp
nop