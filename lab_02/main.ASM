StkSeg SEGMENT PARA STACK 'STACK'
    DB 200h DUP (?) ; stack segment of 512 bytes
StkSeg ENDS

DataS SEGMENT WORD 'DATA'
helloMessage DB 'Hello, world !', 13, 10, '$'
loopCount DB 3
DB '$'
DataS ENDS

Code SEGMENT WORD 'CODE'
    ASSUME CS:Code, DS:DataS
start:
    mov ax, DataS
    mov ds, ax
    xor cx, cx
    mov cl, [loopCount]
    mov dx, OFFSET helloMessage
    mov ah, 9
PrintMessage:
    int 21h
    loop PrintMessage
    mov ah, 4Ch ; end the program
    int 21h
Code ENDS
END start
