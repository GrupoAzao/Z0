; Arquivo: screen.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 16/04/2017

leaw $SCREEN,%A
movw $-1,(%A)