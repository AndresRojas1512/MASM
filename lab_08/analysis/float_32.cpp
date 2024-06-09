#include "float_32.h"

void float_sum_cpp(float a, float b)
{
    float res;
    res = a + b;
}

void float_sum_ams(float a, float b)
{
    float result = 0;
    asm("flds %1\n"
        "flds %2\n"
        "faddp\n"
        "fstps %0\n"
            : "=m"(result)
            : "m"(a), "m"(b));
}

void float_mult_cpp(float a, float b)
{
    float res;
    res = a * b;
}

void float_mult_ams(float a, float b)
{
    float result = 0;
    asm("flds %1\n"
        "flds %2\n"
        "fmulp\n"
        "fstps %0\n"
            : "=m"(result)
            : "m"(a), "m"(b));
}