#include <iostream>
using namespace std;
extern "C" void *mymemmove(char *dst, char *src, int len);

_declspec(naked) int mystrlen(char *s)	//���������� ������� naked, ����� �������������� ��������� ������ � ������
{
	_asm
	{
		push ebp
		mov ebp, esp
		push edi	// ��������� �������.�� ���������� �� ebx, esi, edi ������ �����������
		mov edi, [ebp + 8]	// ��������� ���������� ��������� �� ������
		mov al, 0		// ������� ������ ����� ������
		mov ecx, -1		// � e�� ����������� ��������� �����
		repne scasb		// ���� ����� ������
		not ecx			// �������� e��.
		dec ecx			// ����� ��� � e�� ����� ����� ������
		mov eax, ecx	// ������� ���� ������
		pop edi			// ������������ �������
		pop ebp			// ������ �������
		ret
	}
}

int main()
{
	char s[100], s1[100],s2[100]="abcdef";
	mymemmove(s2 + 3, s2, mystrlen(s2) + 1);
	cout << "s2: " << s2 << endl;
	cout << "Enter string: ";
	cin.getline(s, 100);
	cout << "String len = " << mystrlen(s) << endl;
	mymemmove(s1, s, mystrlen(s) + 1);	//����������� ��� ���������� �����
	cout << "s1 = " << s1 << endl;
	mymemmove(s, s + 1, mystrlen(s + 1) + 1);		//����������� � ����������� � ���� �������
	cout << "Shift s one byte left: " << s << endl;
	mymemmove(s1 + 1, s1, mystrlen(s1) + 1);		//� � ������
	cout << "Shift s1 one byte right: " << s1 << endl;

	system("pause");
	return 0;
}