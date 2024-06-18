#include <iostream>
#include <iomanip>
using namespace std;
int main()
{
	setlocale(LC_ALL, "Russian");//русская локаль
	double c2=2.0, c7=7;
	double a = 0.7, b = 1,e = 0.0001, x;
	// double a = -1.5, b = -1, e = 0.0001, x;
	// double a = -4, b = -3.5, e = 0.0001, x;
	//уточнение корня методом деления пополам
	_asm
	{
lp:	fld b		//b
	fsub a		//b-a
	fcomp e		//сравнить b-a и e
	fstsw	ax	// записать флаги сопроцессора в ах
	sahf	// перенести их в флаги процессора
	jna	fin		//если b-a<=e, то закончить цикл
	fld a			//a
	fmul st(0),st(0)	//a^2
	fmul a			//a^3
	fadd c7			//a^3+7
	fcos			//cos(a^3+7)

	fld a			//a
	fadd b			//a+b
	fdiv c2			//(a+b)/2
	fld st(0)		//сделать копию (a+b)/2
	fmul st(0), st(0)	//((a+b)/2)^2
	fmul				//((a+b)/2)^3
	fadd c7				//((a+b)/2)^3+7
	fcos				//cos(((a+b)/2)^3+7)
	fmul				//cos(a^3+7)*cos(((a+b)/2)^3+7)
	ftst				//сравнить выражение с 0
	fstsw	ax	// записать флаги сопроцессора в ах
	sahf	// перенести их в флаги процессора
	fstp st(0)			//удалить из стека это выражение
	fld a			//a
	fadd b			//a+b
	fdiv c2			//(a+b)/2
	ja m1			//если f(a)*f((a + b) / 2)>0, то переход
	fstp b			//b=(a + b) / 2
	jmp lp			//продолжить цикл
m1:	fstp a			//a=(a + b) / 2
	jmp lp			//продолжить цикл
fin:
	fld a			//a
	fadd b			//a+b
	fdiv c2			//(a+b)/2
	fstp x			//x=(a+b)/2
}
	cout << "x = " << x << endl;
	system("pause");
	return 0;
}