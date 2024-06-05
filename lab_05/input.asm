public input
DATA           segment    para public 'data' use16
EXTERN n:word
DATA           ends

CODE	 SEGMENT	 PARA PUBLIC 'CODE' use16
 ASSUME		 CS:CODE,DS:DATA
.386
;ввод числа
;возвращает:
;n - число

input	proc
	push bx
	push cx
	push dx
	xor bx,bx			;Сначала число = 0
	mov cx,6			;максимальное кол-во вводимых символов
inlp:	mov ah,8		;ф-я ввода символа без эха на экран
	int 21h				;ожидаем нажатия клавиши
	mov dl,al			;сохранить введенный символ
	cmp al,13			;если Enter
	jz m5				;то заканчиваем ввод
	cmp al,'0'			;если код клавиши меньше символа 0
	jb inlp				;повторить ввод
	cmp al,'7'			;если не между 0-7
	ja inlp				;повторить ввод
	sub al,'0'			;преобразовать символ в число
	mov ah,0
	shl bx,3			;сдвинуть все число влева на 4 бита
	add bx,ax			;прибавить введенную цифру
	mov ah,2			;функция 2 - вывод символа на экран
	int 21h				;выводим на экран правильную цифру
	loop inlp			;продолжить ввод
m5:	mov n,bx			;сохранить введенное число
	pop dx
	pop cx
	pop bx
	ret					;конец ввода
input endp
CODE         ENDS
end
