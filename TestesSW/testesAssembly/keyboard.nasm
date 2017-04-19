; Arquivo: keyboard.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 16/04/2017

LOOP:
leaw $KBD,%A
movw (%A),%D
leaw $LOOP,%A
je
END:
leaw $END,%A
jmp