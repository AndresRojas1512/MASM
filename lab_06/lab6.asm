extern Install:near
public Old1CHandler
public Begin
text	segment	'code'
	assume	CS:text,DS:text
	org	100h
Begin:	jmp	Install			;Загрузка резидента в память
cnt	dw 18					;счетчик тиков
speed	db 0				;скорость автоповтора

;обработчик таймера
New1CHandler	proc		;новый обработчик прерывания int1Ch
	jmp short cont			;пропустить метку резидента
	dw 0deadh				;метка присутствия резидента в памяти
cont:
	cli						;запретить прерывания
	dec cs:cnt				;уменьшить счетчик тиков
	jnz m1 					;если он не 0, то закончить обработчик
	mov cs:cnt,18			;если 0, записать в него 18 (18 тиков=1 сек)
	push ax					;сохранить регистр
	mov al,0f3h				;команда F3h отвечает за параметры режима автоповтора нажатой клавиши  
	out 60h,al				;записать в порт клавиатуры код команды
	mov al,cs:speed			;взять скорость
	out 60h,al				;записать в порт клавиатуры
	inc cs:speed			;увеличить скорость
	and cs:speed,15			;оставить только 0-4 биты, остальные обнулить
	pop ax					;восстановить регистр
m1:	sti						;разрешить прерывания
;выход из прерывания
db 0eah               	 	;машинный код команды far JMP
Old1CHandler	dd ?		;резервируем место для адреса оригинального обработчика прерывания 1Ch
New1CHandler endp
text	ends
end   Begin


