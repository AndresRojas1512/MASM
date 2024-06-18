#include <iostream>
using namespace std;
extern "C" void *mymemmove(char *dst, char *src, int len);

_declspec(naked) int mystrlen(char *s)	//объявление функции naked, чтобы самостоятельно прописать пролог и эпилог
{
	_asm
	{
		push ebp
		mov ebp, esp
		push edi	// сохранить регистр.По соглашению си ebx, esi, edi должны сохраняться
		mov edi, [ebp + 8]	// загрузить переданный указатель на строку
		mov al, 0		// искомый символ конца строки
		mov ecx, -1		// в eсх максимально возможное число
		repne scasb		// ищем конец строки
		not ecx			// инверсия eсх.
		dec ecx			// После нее в eсх будет длина строки
		mov eax, ecx	// вернуть дину строки
		pop edi			// восстановить регистр
		pop ebp			// эпилог функции
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
	mymemmove(s1, s, mystrlen(s) + 1);	//перемещение без перекрытия даных
	cout << "s1 = " << s1 << endl;
	mymemmove(s, s + 1, mystrlen(s + 1) + 1);		//перемещение с перекрытием в одну сторону
	cout << "Shift s one byte left: " << s << endl;
	mymemmove(s1 + 1, s1, mystrlen(s1) + 1);		//и в другую
	cout << "Shift s1 one byte right: " << s1 << endl;

	system("pause");
	return 0;
}