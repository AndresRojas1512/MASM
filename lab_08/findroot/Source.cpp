#include <iostream>
#include <iomanip>
using namespace std;
int main()
{
	setlocale(LC_ALL, "Russian");//������� ������
	double pi1 = 3.14, pi2 = 3.141596;
	double sin1, sin2, sin3, sin12, sin22, sin32, c2=2.0, c7=7;
	//�������� �������� ���������� sin pi � sin(pi/2) ��� ����������� �������� 3.14, 3.141596 � ��������, ������������ �������� ������������.
	_asm
	{
		fld pi1		//3.14
		fsin		//sin(3.14)
		fstp sin1	//��������� sin(3.14)
		fld pi1		//3.14
		fdiv c2		//3.14/2
		fsin		//sin(3.14/2)
		fstp sin12	//��������� sin(3.14/2)

		fld pi2		//3.141596
		fsin		//sin(3.141596)
		fstp sin2	//��������� sin(3.141596)
		fld pi2		//3.141596
		fdiv c2		//3.141596/2
		fsin		//sin(3.141596/2)
		fstp sin22	//��������� sin(3.141596/2)

		fldpi		//pi
		fsin		//sin(pi)
		fstp sin3	//��������� sin(pi)
		fldpi		//pi
		fdiv c2		//pi/2
		fsin		//sin(pi/2)
		fstp sin32	//��������� sin(pi/2)
	}
	// cout << "sin(3.14) = " << sin1 << endl;
	// cout << "sin(3.14/2) = " << sin12 << endl;

	// cout << "sin(3.141596) = " << sin2 << endl;
	// cout << "sin(3.141596/2) = " << sin22 << endl;

	// cout << "sin(pi) = " << sin3 << endl;
	// cout << "sin(pi/2) = " << sin32 << endl;
	double a = 0.7, b = 1,e=0.0001,x;
	//��������� ����� ������� ������� �������
	_asm
	{
lp:	fld b		//b
	fsub a		//b-a
	fcomp e		//�������� b-a � e
	fstsw	ax	// �������� ����� ������������ � ��
	sahf	// ��������� �� � ����� ����������
	jna	fin		//���� b-a<=e, �� ��������� ����
	fld a			//a
	fmul st(0),st(0)	//a^2
	fmul a			//a^3
	fadd c7			//a^3+7
	fcos			//cos(a^3+7)

	fld a			//a
	fadd b			//a+b
	fdiv c2			//(a+b)/2
	fld st(0)		//������� ����� (a+b)/2
	fmul st(0), st(0)	//((a+b)/2)^2
	fmul				//((a+b)/2)^3
	fadd c7				//((a+b)/2)^3+7
	fcos				//cos(((a+b)/2)^3+7)
	fmul				//cos(a^3+7)*cos(((a+b)/2)^3+7)
	ftst				//�������� ��������� � 0
	fstsw	ax	// �������� ����� ������������ � ��
	sahf	// ��������� �� � ����� ����������
	fstp st(0)			//������� �� ����� ��� ���������
	fld a			//a
	fadd b			//a+b
	fdiv c2			//(a+b)/2
	ja m1			//���� f(a)*f((a + b) / 2)>0, �� �������
	fstp b			//b=(a + b) / 2
	jmp lp			//���������� ����
m1:	fstp a			//a=(a + b) / 2
	jmp lp			//���������� ����
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