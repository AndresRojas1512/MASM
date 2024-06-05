public task1
EXTERN printhex:near
DATA           segment    para public 'data' use16
EXTERN n:word
msg1	db 'Kratno 2^$'

DATA           ends

CODE	 SEGMENT	 PARA PUBLIC 'CODE' use16
 ASSUME		 CS:CODE,DS:DATA
.386
task1	proc
	mov ah,9		;функция вывода сообщения на экран
	lea dx,msg1		;выводимое сообщение
	int 21h			;выводим на экран
	bsf ax,n		;Ищем номер первой единицы справа, даст степень двойки которой кратно число
	aam				;преобразовать степень в неупакованное bcd число
	add ax,3030h	;преобразовать степень в  ASCII
	mov bx,ax		;запомнить степень в  ASCII
	mov ah,2		;ф-я вывода символа на экран
	mov dl,bh		;вывести старшую цифру степени
	int 21h
	mov dl,bl		;вывести младшую цифру степени
	int 21h

	mov dl,13		;вывести переаод строки
	int 21h
	mov dl,10		;и возврат каретки
	int 21h
	ret
task1 endp
CODE         ENDS
end
