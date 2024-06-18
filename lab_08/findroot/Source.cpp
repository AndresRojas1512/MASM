#include <iostream>
#include <iomanip>
using namespace std;
int main()
{
	setlocale(LC_ALL, "Russian");//������� ������
	double c2=2.0, c7=7;
	double a = 0.7, b = 1,e = 0.0001, x;
	// double a = -1.5, b = -1, e = 0.0001, x;
	// double a = -4, b = -3.5, e = 0.0001, x;
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