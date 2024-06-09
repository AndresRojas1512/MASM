#include "sinus.h"

float sin_cpp(float pi)
{
    float result = 0;
    result = sin(pi);
    return result;
}

float sin_asm(float pi)
{
    float result = 0;
    asm("flds %1\n"
        "fsin\n"
        "fstps %0\n"
            : "=m"(result)
            : "m"(pi)
            );
    return result;
}