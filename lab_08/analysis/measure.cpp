#include "measure.h"

#define N 100000

using namespace std;

typedef void (*float_func)(float, float);
typedef void (*double_func)(double, double);

long measure_float(float a, float b, float_func f);
long measure_double(double a, double b, double_func  f);

void sin_measure(float pi);

void measure_arithmetic()
{
    float fa = 2, fb = 3;
    double da = 2, db = 3;
    long double la = 2, lb = 3;

    cout << "Sum" << endl;
    cout << "float:" << "\tcpp: " << measure_float(fa, fb, float_sum_cpp) << "\t asm: " << measure_float(fa, fb, float_sum_ams) << endl;
    cout << "double:" << "\tcpp: " << measure_double(da, db, double_sum_cpp) << "\t asm: " << measure_double(da, db, double_sum_ams) << endl;
    cout << endl;

    cout << "Mult" << endl;
    cout << "float:" << "\tcpp: " << measure_float(fa, fb, float_mult_cpp) << "\t asm: " << measure_float(fa, fb, float_mult_ams) << endl;
    cout << "double:" << "\tcpp: " << measure_double(da, db, double_mult_cpp) << "\t asm: " << measure_double(da, db, double_mult_ams) << endl;
    cout << endl << endl;
}

void measure_sinus()
{
    float pi_1 = 3.14, pi_2 = 3.141596;
    float a = 2, result = 0;

    cout << "sin(pi)" << endl;
    sin_measure(pi_1);
    sin_measure(pi_2);

    asm("fldpi\n"
        "fsin\n"
        "fstps %0\n"
            : "=m"(result)
            );
    cout <<"fldpi: " << result << endl;
    cout << endl;

    cout << "sin(pi/2)" << endl;
    sin_measure(pi_1 / 2.0);
    sin_measure(pi_2 / 2.0);

    asm("fldpi\n"
        "flds %1\n"
        "fdivp\n"
        "fsin\n"
        "fstps %0\n"
            : "=m"(result)
            : "m"(a)
            );
    cout <<"fldpi / 2: " << result << endl;
}

long measure_float(float a, float b, float_func f)
{
    struct timeval start, end;
    gettimeofday(&start, nullptr);
    for (size_t i = 0; i < N; i++) f(a, b);
    gettimeofday(&end, nullptr);
    return end.tv_usec - start.tv_usec;
}

long measure_double(double a, double b, double_func f)
{
    struct timeval start, end;
    gettimeofday(&start, nullptr);
    for (size_t i = 0; i < N; i++) f(a, b);
    gettimeofday(&end, nullptr);
    return end.tv_usec - start.tv_usec;
}

void sin_measure(float pi)
{
    cout << "pi = " << pi << endl;
    cout << "cpp: " << sin_cpp(pi) << "\tasm: " << sin_asm(pi) << endl;
}