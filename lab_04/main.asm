.model small
.data
msg1	db 'Enter row count: $'
msg2	db 13,10,'Enter column count: $'
msg3	db 13,10,'Matrix: ',13,10,'$'
msg4	db 13,10,'Result: ',13,10,'$'
inpm	db 13,10,'Input matrix:$'
str0	db 0dh,0ah,'A($'	;����������� ��� ������ ������
str1	db ')= $'
n	db ?
m	db ?
A	db 9*9 dup(?)
B	db 9*9 dup(?)
remove	db 9 dup(0)		;����� ������� �������
.stack 256
puts	macro	string		;����� ������
	lea	dx,string
	mov	ah,09h
	int	21h
endm
putch	macro	char		;����� �������
	mov	dl,char
	mov	ah,2
	int	21h
endm

getch	macro		;�������� ������� ����� �������
	mov ah,0	
	int 16h
endm

.code
start:
	mov ax,@data	;����������� ���������� ��������
	mov ds,ax
;���� ��������
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
	lea si,A		;������ �������
	mov bh,1		;������
	mov bl,1		;�������
inpmas:	puts str0		;������� �� �����
	mov al,bh		;������
	add al,'0'		;����������� ����� ������ � ����� 
	putch al		;� ������� �� �����
	putch ','		;�������
	
	mov al,bl		;�������
	add al,'0'		;����������� ����� ������� � �����
	putch al		;������� �� �����
	puts str1		;)=
	call inputnum		;���� �����
	mov [si],al		;������� �������� � ������
	inc si			;��������� �������
	inc bl			;����� ���������� �������
	cmp bl,m		;���������� � ������� �������
	jbe inpmas		;���� ������ ��� ����, ����������
	mov bl,1		;������ �������
	inc bh			;��������� ������
	cmp bh,n		;���������� � ������� �������
	jbe inpmas		;���� ������ ��� ����, ����������
	puts msg3
	lea bx,A		;������ �������
	call outmatrix		;������� �������
;����� ��������� ��������
	mov si,0		;������ ������ ������� �������
	mov cl,m		;������� ��������
lp2:	mov ch,n		;������� �����
	mov bx,si		;��������� ������ ������ ������� ������� 
	mov dl,0		;����� �������� � �������=0
lp1:	test byte ptr A[bx],1	;���� ��������� ������� ������� ������
	jz chet			;����������
	inc dl			;���� ��������, ��������� �� ���-��
chet:	add bl,m		;������� � ����������
	adc bh,0		;�������� �������
	dec ch			;��������� �������
	jnz lp1			;���� �� 0, ���������� ���� �� �������
	cmp dl,n		;���� �� ��� �������� � ������� ��������
	jnz m2			;�� ����������
	mov byte ptr remove[si],1	;���� ��� ��������, �������� ������� �� ��������
m2:	inc si			;��������� �������
	dec cl			;��������� ������� ��������
	jnz lp2			;���� �� 0, ���������� ����
;�������� ��������
	lea di,B		;����� ������� � ���������� ���������
	mov cl,n		;������� �����
	mov bx,0		;������ ������ ��������� ������ �������
lp4:	mov si,0		;������ ������� �������
	mov ch,m		;������� ��������
	mov dl,0		;������� ������� �������� �������� � �������
lp3:	mov al,A[si][bx]	;����� ��������� ������� �������
	cmp remove[si],0	;���� ���� ������� ����� �������
	jnz m1			;�� ����������
	mov [di],al		;���� �� ���������, �� ��������� �������� � ����� �������
	inc di			;������� � ���������� �� ��������
	inc dl			;��������� ������� ������� �������� �������� � �������
m1:	inc si			;��������� ������� �������� �������
	dec ch			;��������� ������� ��������
	jnz lp3			;���� �� 0, ���������� ���� �� ������
	add bl,m		;������� � ���������
	adc bh,0		;������ �������
	dec cl			;��������� ������� �����
	jnz lp4			;���� �� 0, ���������� ����
	mov m,dl		;��������� ���-�� �������� ���������� �������
	
	puts msg4
	lea bx,B		;������ �������
	call outmatrix		;������� �������
	getch
	mov ax,4c00h	;��������� ���������
	int 21h
;���� �����
inputnum	proc
	getch
	cmp al,'0'		;���� �� 0..9
	jb inputnum		;�� ��������� ����
	cmp al,'9'
	ja inputnum
	putch al		;���� �����, �������
	sub al,'0'		;������������� �� ascii � �����
	ret
inputnum endp
;ds:bx - ����� �������
outmatrix	proc
	mov al,n		;������ �������
	mul m			;���������� ��������� � �������
	mov cx,ax		;���������� ��������� � �������
	jcxz ex1		;������ ������� �� ��������
mo6:	mov al,[bx]		;����� ������� �������
	add al,'0'		;�����������  � �����
	putch al		;�������
	putch 9			;������� ������ ���������
	inc bx			;��������� � ���������� �������� �������
	dec cx			;��������� ���������� ���������� ���������
	jz ex1                  ;���� 0 - ���������
	mov ax,cx		;���������� ���������� ���������
	div m			;����� ������� ������� �� ����� ������ �������
	test ah,ah              ;���� �� 0
	jnz mo6			;�� ����������
	putch 13		;������� �������
	putch 10		;������� ������
	jmp mo6			;���������� �����
ex1:	ret
outmatrix endp
end start
