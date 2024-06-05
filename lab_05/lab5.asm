EXTERN input:near
EXTERN printbin:near
EXTERN printhex:near
EXTERN task1:near

public n
DATA           segment    para public 'data' use16
n	dw 0					;введенное число
funcs	dw input            ;массив указателей на подпрограммы, выполняющие
	dw printbin				;действия, соответствующие пунктам меню
	dw printhex
	dw task1
menumsg	db '1 - Input oct number',13,10
	db '2 - Show entered number in unsigned bin',13,10
	db '3 - Show entered number as short signed hex',13,10
	db '4 - Task 1',13,10
	db '0 - Exit',13,10,'$'
DATA           ends

SSEG segment stack
db 100h dup (?)
SSEG ends
CODE	 SEGMENT	 PARA PUBLIC 'CODE' use16
 ASSUME		 CS:CODE,DS:DATA,SS:SSEG
.386
start:
	mov ax,data				;Настраиваем сегментные регистры
	mov ds,ax
menu:	mov ah,9			;функция вывода сообщения на экран
	lea dx,menumsg			;выводимое сообщение
	int 21h					;выводим на экран
menu1:	mov ah,8			;ф-я ввода символа без эха на экран
	int 21h					;ожидаем нажатия клавиши
	mov bl,al				;сохранить введенный символ
	cmp al,'0'				;если код клавиши меньше символа 0
	jb menu1				;повторить ввод
	cmp al,'4'				;если не между 0-4
	ja menu1				;повторить ввод
	mov ah,2				;функция 2 - вывод символа на экран
	mov dl,bl
	int 21h					;выводим на экран правильную цифру
	mov dl,13				;вывести перевод строки
	int 21h
	mov dl,10				;и возврат каретки
	int 21h
	cmp bl,'0'				;если выбран выход
	jz ex					;то выйти
	sub bl,'1'				;получить в bx
	mov bh,0				;индекс номера пункта меню
	shl bx,1				;получить смещение в массиве
	call funcs[bx]			;вызов нужной подпрограммы
	
	mov ah,2				;функция 2 - вывод символа на экран
	mov dl,13				;вывести перевод строки
	int 21h
	mov dl,10				;и возврат каретки
	int 21h
	jmp menu				;вернуться в меню
ex:	mov ax,4c00h			;закончить программу
	int 21h

CODE         ENDS
end start
