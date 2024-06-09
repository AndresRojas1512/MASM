#include "double_64.h"

void double_sum_cpp(double a, double b)
{
    double result = 0;
    result = a + b;
}

void double_sum_ams(double a, double b)
{
    double result = 0;
    asm("fldl %1\n"
        "fldl %2\n"
        "faddp\n"
        "fstpl %0\n"
            : "=m"(result)
            : "m"(a), "m"(b)
            );
}

void double_mult_cpp(double a, double b)
{
    double res;
    res = a * b;
}

void double_mult_ams(double a, double b)
{
    double result = 0;
    asm("fldl %1\n"
        "fldl %2\n"
        "fmulp\n"
        "fstpl %0\n"
            : "=m"(result)
            : "m"(a), "m"(b)
            );
}