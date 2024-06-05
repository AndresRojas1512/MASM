SD1 SEGMENT para public 'DATA'		; сегмент данных SD1
	S1 db 'Y'						; объавление байта S1 и инициализация значением 'Y'
	db 65535 - 2 dup (0)			; заполнение остальной части сегмента нулями
SD1 ENDS

SD2 SEGMENT para public 'DATA'		; определение сегмента данных SD2
	S2 db 'E'						; объявление байта S2 и инициализация значением 'E'
	db 65535 - 2 dup (0)			; заполнение остальной части сегмента нулями
SD2 ENDS

SD3 SEGMENT para public 'DATA'		; определение сегмента данных SD3
	S3 db 'S'						; объявление байта S2 и инициализация значением 'E'
	db 65535 - 2 dup (0)			; заполнение остальной части сегмента нулями
SD3 ENDS

CSEG SEGMENT para public 'CODE'		; определение сегмента кода
	assume CS:CSEG, DS:SD1
output:								; метка начала процедуры вывода
	mov ah, 2						; функция 2 для вывода символа
	int 21h							; прерывание для вывода
	mov dl, 13						; перевод каретки в начало
	int 21h							; врерывание для перевода
	mov dl, 10						; перевод строки
	int 21h							; прерывание для перевода
	ret
main:
	mov ax, SD1						; загрузка адрес сегмента в AX
	mov ds, ax						; устовка DS для указания на сегмент SD1
	mov dl, S1						; загрузка значения Y в DL
	call output						; вывод
assume DS:SD2
	mov ax, SD2
	mov ds, ax
	mov dl, S2
	call output
assume DS:SD3
	mov ax, SD3
	mov ds, ax
	mov dl, S3
	call output
	
	mov ax, 4c00h					; завершение программы
	int 21h
CSEG ENDS
END main