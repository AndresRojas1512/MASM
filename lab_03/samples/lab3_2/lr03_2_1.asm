STK SEGMENT para STACK 'STACK'			; сегмент стека
	db 100 dup(0)
STK ENDS

SD1 SEGMENT para common 'DATA'			; определение того же общего сегмента данных
	W dw 3444h							; слово со значением 3444h
SD1
END
