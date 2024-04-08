StkSeg SEGMENT PARA STACK 'STACK'
    DB 200h DUP (?)
StkSeg ENDS

DataS SEGMENT WORD 'DATA'
LoopCount DB '3'
HelloMessage DB 'Hello, world !', 13, 10
;LoopCount DB '3'
DB '$'
DataS ENDS

Code SEGMENT WORD 'CODE'
    ASSUME CS:Code, DS:DataS
start:
    mov AX, DataS
    mov DS, AX
    xor cx, cx
    ;dec cx
    ;mov cx, 0100h
    mov cl, [LoopCount]
    mov DX, OFFSET HelloMessage
    mov AH, 9
PrintMessage:
    int 21h
    loop PrintMessage
    mov AH, 4Ch
    int 21h
Code ENDS
END start
