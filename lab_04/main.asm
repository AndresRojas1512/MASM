.model small
.data
msg1	db 'Enter row count: $'
msg2	db 13,10,'Enter column count: $'
msg3	db 13,10,'Matrix: ',13,10,'$'
msg4	db 13,10,'Result: ',13,10,'$'
inpm	db 13,10,'Input matrix:$'
str0	db 0dh,0ah,'A($'					;формируемая для вывода строка
str1	db ')= $'
n	db ?
m	db ?
A	db 9*9 dup(?)
B	db 9*9 dup(?)
remove	db 9 dup(0)							;какие столбцы удалять
.stack 256
puts	macro	string						; вывод строки 
	lea	dx,string
	mov	ah,09h
	int	21h
endm
putch	macro	char						;вывод символа
	mov	dl,char
	mov	ah,2
	int	21h
endm

getch	macro								;Ожидание нажатия любой клавиши
	mov ah,0	
	int 16h
endm

.code
start:
	mov ax,@data							;Настраиваем сегментные регистры
	mov ds,ax
;ввод размеров
i1:	puts msg1
	call inputnum
	cmp al,0
	jz i1
	mov n,al
i2:	puts msg2
	call inputnum
	cmp al,0
	jz i2
	mov m,al
	puts inpm
	lea si,A								;начало матрицы
	mov bh,1								;строка
	mov bl,1								;столбец
inpmas:	puts str0							;выводим на экран
	mov al,bh								;строка
	add al,'0'								;преобразуем номер строки в текст  
	putch al								;и выводим на экран
	putch ','								;запятая
	
	mov al,bl								;столбец
	add al,'0'								;преобразуем номер столбца в текст
	putch al								;выводим на экран
	puts str1								;)=
	call inputnum							;ввод числа
	mov [si],al								;заносим значение в массив
	inc si									;следующий элемент
	inc bl									;номер следующего столбца
	cmp bl,m								;сравниваем с шириной матрицы
	jbe inpmas								;если меньше или рано, продолжить
	mov bl,1								;первый столбец
	inc bh									;следующая строка
	cmp bh,n								;сравниваем с высотой матрицы
	jbe inpmas								;если меньше или рано, продолжить
	puts msg3
	lea bx,A								;начало матрицы
	call outmatrix							;вывести матрицу
;поиск удаляемых столбцов
	mov si,0								;индекс начала столбца матрицы
	mov cl,m								;счетчик столбцов
lp2:	mov ch,n							;счетчик строк
	mov bx,si								;запомнить индекс начала столбца матрицы 
	mov dl,0								;число нечентых в столбце=0
lp1:	test byte ptr A[bx],1				;если очередной элемент столбца четный
	jz chet									;пропустить
	inc dl									;если нечентый, увеличить их кол-во
chet:	add bl,m							;перейти к следующему
	adc bh,0								;элементу столбца
	dec ch									;уменьшить счетчик
	jnz lp1									;пока не 0, продолжить цикл по столбцу
	cmp dl,n								;если не все элементы в столбце нечетные
	jnz m2									;то пропустить
	mov byte ptr remove[si],1				;если все нечентые, пометить столбец на удаление
m2:	inc si									;следующий столбец
	dec cl									;уменьшить счетчик столбцов
	jnz lp2									;пока не 0, продолжить цикл
;Удаление столбцов
	lea di,B								;адрес матрицы с удаленными столбцами
	mov cl,n								;счетчик строк
	mov bx,0								;индекс начала очередной строки матрицы
lp4:	mov si,0							;индекс столбца матрицы
	mov ch,m								;счетчик столбцов
	mov dl,0								;счетчик сколько осталось столбцов в матрице
lp3:	mov al,A[si][bx]					;взять очережной элемент матрицы
	cmp remove[si],0						;если этот столбец нужно удалить
	jnz m1									;то пропустить
	mov [di],al								;если не удаляется, то сохранить элдемент в новой матрице
	inc di									;перейти к следующему ее элементу
	inc dl									;увеличить счетчик сколько осталось столбцов в матрице
m1:	inc si									;следующий столбец исходной матрицы
	dec ch									;уменьшить счетчик столбцов
	jnz lp3									;пока не 0, продолжаем цикл по строке
	add bl,m								;перейти к следующей
	adc bh,0								;строке матрицы
	dec cl									;уменьшить счетчик строк
	jnz lp4									;пока не 0, продолжить цикл
	mov m,dl								;запомнить кол-во столбцов полученной матрицы
	
	puts msg4
	lea bx,B								;начало матрицы
	call outmatrix							;вывести матрицу
	getch
	mov ax,4c00h							;закончить программу
	int 21h
;ввод числа
inputnum	proc
	getch
	cmp al,'0'								;если не 0..9
	jb inputnum								;то повторить ввод
	cmp al,'9'
	ja inputnum
	putch al								;если цифра, вывести
	sub al,'0'								;преобразовать из ascii в цифру
	ret
inputnum endp
;ds:bx - адрес матрицы
outmatrix	proc
	mov al,n								;размер матрицы
	mul m									;количество элементов в матрице
	mov cx,ax								;количество элементов в матрице
	jcxz ex1								;пустую матрицу не выводить
mo6:	mov al,[bx]							;берем элемент матрицы
	add al,'0'								;преобразуем  в текст
	putch al								;выводим
	putch 9									;выводим символ табуляции
	inc bx									;переходим к следующему элементу матрицы
	dec cx									;уменьшаем количество оставшихся элементов
	jz ex1            				        ;если 0 - закончить
	mov ax,cx								;количество оставшихся элементов
	div m									;делим текущий элемент на длину строки матрицы
	test ah,ah        				        ;если не 0
	jnz mo6									;то продолжить
	putch 13								;возврат каретки
	putch 10								;перевод строки
	jmp mo6									;продолжаем вывод
ex1:	ret
outmatrix endp
end start