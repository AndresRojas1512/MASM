EXTRN output_X: near					; внешняя ссылка на процедуру output_X

STK SEGMENT PARA STACK 'STACK'			; сегмент стека
	db 100 dup(0)
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'			; сегмент данных
	X db 'R'
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'			; сегмент кода
	assume CS:CSEG, DS:DSEG, SS:STK
main:
	mov ax, DSEG
	mov ds, ax

	call output_X						; вызов процедуры output_X

	mov ax, 4c00h						; завершение программы
	int 21h
CSEG ENDS

PUBLIC X

END main