.686
.MODEL FLAT, C
.STACK
.CODE
public  mymemmove	;���������� �������, ����� �� ������ C ����� ����
mymemmove proc
		push ebp
		mov ebp,esp
		push esi		; ��������� ��������. �� ���������� � esi, edi ������ �����������
		push edi
		mov edi, [ebp+8]	;����� ����������
	    mov esi, [ebp+12]	;����� ������ ����������
		mov ecx, [ebp+16]	;���������� ���������� ����
		cmp esi, edi		;���� �������� ������������� ������ ���������
		jnb move			;�� ����� ����������
		;����� ����� ���������� � �����, ����� �� �������� ������
		std			;�������� ����������� ��������� �������
		add esi, ecx	;������� � ����� ������ ���������
		dec esi
		add edi, ecx	;������� � ����� ������ ���������
		dec edi
move:		jecxz fin		;���� ���������� ������, ���������
		rep movsb		;����������� ������
fin:		cld				;������� ������ ����������� ��������� ������
		pop edi			;������������ ��������
		pop esi
		pop ebp
ret
mymemmove ENDP
END