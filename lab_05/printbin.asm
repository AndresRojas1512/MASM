public printbin
DATA           segment    para public 'data' use16
EXTERN n:word
DATA           ends

CODE	 SEGMENT	 PARA PUBLIC 'CODE' use16
 ASSUME		 CS:CODE,DS:DATA
.386
;Процедура вывода числовых данных в двоичной системе счисления (размерность слово).
printbin proc
	mov bx,n				;сохраняем ax в bx
	mov ah,2				;функция 2 - вывод символа на экран
	mov cx,16				;количество выводимых символов, равно разрядности числа
lp2:	mov dl,'0'			;символ ноль
	rcl bx,1				;вращаем bx на 1 разряд влево через признак переноса
	adc dl,0				;добавляем значение переноса к dl
	int 21h					;выводим символ
	loop lp2				;выводим все символы
	ret						;выход из подпрограммы
printbin endp
CODE         ENDS
end
