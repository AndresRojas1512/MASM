EXTRN X: byte 						; внешнее объявление переменной X (она определена в другом модуле)
PUBLIC exit							; процедура exit доступна из других модулей

SD2 SEGMENT para 'DATA'				; сегмент данных
	Y db 'Y'
SD2 ENDS

SC2 SEGMENT para public 'CODE'		; сегмент кода
	assume CS:SC2, DS:SD2
exit:								; мекта начала процедуры exit
	mov ax, seg X					; загрузка сегмента в котором определена переменна X
	mov es, ax						; установение регистра сегмента es
	mov bh, es:X					; загрузка значения переменной X в регистр bh через сегмент es

	mov ax, SD2						; загрузка адреса сегмента данных в AX
	mov ds, ax						; установление регистра сегмента ds

	xchg ah, Y						; обмен значениями между AH и Y
	xchg ah, ES:X					; обмен значениями между AH и значением по адресу X
	xchg ah, Y						; возврат исходного значения в Y

	mov ah, 2						; вывод
	mov dl, Y
	int 21h	
	
	mov ax, 4c00h					; завершение программы
	int 21h
SC2 ENDS
END