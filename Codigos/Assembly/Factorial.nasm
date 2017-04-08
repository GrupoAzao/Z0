leaw $0,%A
subw (%A),$1,%D
leaw $2,%A
movw %D,(%A)
leaw $3,%A
movw %D,(%A)
loop:
leaw $0,%A
movw (%A),%D
leaw $1,%A
addw (%A),%D,(%A)
leaw $2,%A
subw (%A),$1,%D
decw (%A)
leaw $loop,%A
jg
leaw $3,%A
decw (%A)
movw (%A),%D
leaw $2,%A
movw %D,(%A)
leaw $1,%A
movw (%A),%D
leaw $0,%A
movw %D,(%A)
leaw $1,%A
subw (%A),%D,(%A)
leaw $3,%A
movw (%A),%D
leaw $loop,%A
jg
leaw $0,%A
movw (%A),%D
leaw $1,%A
movw %D,(%A)
