public Install
extern Old1CHandler:dword
extern Begin:near
extern New1CHandler:dword
.286
text	segment	'code'
	assume	CS:text,DS:text
Install	proc						; загрузка резидента
	mov ax, 351Ch					;ф-я получения адреса обработчика прерывания 1c
	int 21h							;получить адрес обработчика
	mov dx,word ptr es:[bx+2]		;взять сигнатуру
	cmp dx,	0deadh					;если загружен
	jz unload						;то выгрузитьs
	cli
	mov word ptr Old1CHandler,BX	;сохранить вектор прерывания таймера
	mov word ptr Old1CHandler+2,ES
	mov ax,251Ch					; SetVector
	mov dx,offset  New1CHandler
	int 21h							;установить новый обработчик таймера
	sti
	; сообщение об успехе
	lea dx,Success					;адрес строки
	mov ah,09h						;функция вывода строки на экран
	int 21h							;выводим на экран

	mov ax,3100h					; KeepProc
;указываем системе сколько памяти в параграфах занимает наш резидент
	mov dx,offset Install
	sub dx,Begin
	add dx,10Fh
	shr dx,4
;	mov dx,(Install-Begin+10Fh)/16; указываем системе сколько памяти в параграфах занимает наш резидент
	int 21h							; закончить, но остаться в памяти
unload:
;выгрузка
	cli								; запретить прерывания
	mov ax,251ch					; функция установки вектора 21h
	lds dx,[es:Old1CHandler] 		;в ds:dx адрес старого обработчика (Из копии в памяти!!!)
	int 21h							;возврашаем старый обработчик
	sti								;разрешить прерывания
	push es
	mov es,[es:2ch]					;сегмент окружения из PSP
	mov ah,49h						;функция освобождения блока памяти
	int 21h							;освободить сегмент окружения
	pop es							;es указывет на начало программы в памяти
	mov ah,49h						;функция освобождения блока памяти
	int 21h							;выгрузить программу
	push cs
	pop ds							;ds=cs
	lea dx,Unloaded					;адрес строки
	mov ah,09h						;функция вывода строки на экран
	int 21h							;выводим на экран
	mov ah,4ch						; стандартный выход из программы
	int 21h
Install endp
Success		db	10,13,'Program loaded',10,13,'$'
Unloaded	db	10,13,'Program unloaded',10,13,'$'
text	ends
end   Begin


