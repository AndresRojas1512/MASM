PUBLIC output_X
EXTRN X: byte

CSEG SEGMENT PARA PUBLIC 'CODE'
    assume CS:CSEG
output_X proc near
    mov dl, ' '
    mov ah, 02h
    int 21h
    
    mov al, X
    add al, 5
    
    add al, '0'
    
    mov dl, al
    mov ah, 02h
    int 21h
    
    ret
output_X endp
CSEG ENDS
END
