#include "long_80.h"

void long_sum_cpp(long double a, long double b)
{
    long double result = 0;
    result = a + b;
}

void long_sum_ams(long double a, long double b)
{
    long double result = 0;
    asm("fldt %1\n"
        "fldt %2\n"
        "faddp\n"
        "fstpt %0\n"
            : "=m"(result)
            : "m"(a), "m"(b)
            );
}

void long_mult_cpp(long double a, long double b)
{
    long double res;
    res = a * b;
}

void long_mult_ams(long double a, long double b)
{
    long double result = 0;
    asm("fldt %1\n"
        "fldt %2\n"
        "fmulp\n"
        "fstpt %0\n"
            : "=m"(result)
            : "m"(a), "m"(b)
            );
}