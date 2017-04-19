; Hourglass.nasm

; Desenha uma ampulheta (dois triangulo invertidos um em cima do outro) na tela.

; Hexagon.nasm

; Desenha um hexagon na tela.
;como ampulheta eh dois triangulos, deve ter 6 lados, entao hexagono passa no teste

leaw $960, %A
movw %A, %D
leaw $SCREEN, %A
movw %D, (%A) ; pinta a 1a linha
movw %A, %D; guarda o byte da tela em D
leaw $32, %A
addw %A, %D, %D; poe a linha de baixo em D
leaw $0, %A;
movw %D, (%A); poe a linha de baixo em R[0]
leaw $2016, %A; A = 1100000000000000
movw %A, %D; D = A 
leaw $0, %A
movw (%A), %A ; faz A = proxima linha
movw %D, (%A) ; pinta o a proxima linha

movw %A, %D; guarda o byte da tela em D
leaw $32, %A
addw %A, %D, %D; poe a linha de baixo em D
leaw $0, %A;
movw %D, (%A); poe a linha de baixo em R[0]
leaw $4080, %A; A = 1100000000000000
movw %A, %D; D = A 
leaw $0, %A
movw (%A), %A ; faz A = proxima linha
movw %D, (%A) ; pinta o a proxima linha

movw %A, %D; guarda o byte da tela em D
leaw $32, %A
addw %A, %D, %D; poe a linha de baixo em D
leaw $0, %A;
movw %D, (%A); poe a linha de baixo em R[0]
leaw $8184, %A; A = 1100000000000000
movw %A, %D; D = A 
leaw $0, %A
movw (%A), %A ; faz A = proxima linha
movw %D, (%A) ; pinta o a proxima linha

movw %A, %D; guarda o byte da tela em D
leaw $32, %A
addw %A, %D, %D; poe a linha de baixo em D
leaw $0, %A;
movw %D, (%A); poe a linha de baixo em R[0]
leaw $8184, %A; A = 1100000000000000
movw %A, %D; D = A 
leaw $0, %A
movw (%A), %A ; faz A = proxima linha
movw %D, (%A) ; pinta o a proxima linha

movw %A, %D; guarda o byte da tela em D
leaw $32, %A
addw %A, %D, %D; poe a linha de baixo em D
leaw $0, %A;
movw %D, (%A); poe a linha de baixo em R[0]
leaw $8184, %A; A = 1100000000000000
movw %A, %D; D = A 
leaw $0, %A
movw (%A), %A ; faz A = proxima linha
movw %D, (%A) ; pinta o a proxima linha

movw %A, %D; guarda o byte da tela em D
leaw $32, %A
addw %A, %D, %D; poe a linha de baixo em D
leaw $0, %A;
movw %D, (%A); poe a linha de baixo em R[0]
leaw $4080, %A; A = 1100000000000000
movw %A, %D; D = A 
leaw $0, %A
movw (%A), %A ; faz A = proxima linha
movw %D, (%A) ; pinta o a proxima linha

movw %A, %D; guarda o byte da tela em D
leaw $32, %A
addw %A, %D, %D; poe a linha de baixo em D
leaw $0, %A;
movw %D, (%A); poe a linha de baixo em R[0]
leaw $2016, %A; A = 1100000000000000
movw %A, %D; D = A 
leaw $0, %A
movw (%A), %A ; faz A = proxima linha
movw %D, (%A) ; pinta o a proxima linha

movw %A, %D; guarda o byte da tela em D
leaw $32, %A
addw %A, %D, %D; poe a linha de baixo em D
leaw $0, %A;
movw %D, (%A); poe a linha de baixo em R[0]
leaw $960, %A; A = 1100000000000000
movw %A, %D; D = A 
leaw $0, %A
movw (%A), %A ; faz A = proxima linha
movw %D, (%A) ; pinta o a proxima linha
