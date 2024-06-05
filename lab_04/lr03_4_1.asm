PUBLIC X							; переменная X будет доступной для других модулей
EXTRN exit: far						; процедура exit определена в другом модуле

SSTK SEGMENT para STACK 'STACK'		; сегмент стека
	db 100 dup(0)
SSTK ENDS

SD1 SEGMENT para public 'DATA'		; сегмент данных
	X db 'X'
SD1 ENDS

SC1 SEGMENT para public 'CODE'		; сегмент кода
	assume CS:SC1, DS:SD1
main:	
	jmp exit
SC1 ENDS
END main