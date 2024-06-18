#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX_STRING_LEN 64

double scalar_product(const double *a, const double *b, int length)
{
    double result = 0.0;
    double temp_result[2] = {0.0, 0.0};
    int i;
    for (i = 0; i < length - 1; i += 2)
	{
        asm(
            "ld1 {v0.2d}, [%[a]], #16    \n"
            "ld1 {v1.2d}, [%[b]], #16    \n"
            "fmul v2.2d, v0.2d, v1.2d    \n"
            "faddp d0, v2.2d             \n"
            "fadd %d[result], %d[result], d0 \n"
            : [a] "+r" (a), [b] "+r" (b), [result] "+w" (result)
            :
            : "v0", "v1", "v2", "d0", "memory"
        );
    }
    if (length & 1)
	{
        asm(
            "ldr d0, [%[a]]              \n"
            "ldr d1, [%[b]]              \n"
            "fmul d2, d0, d1             \n"
            "fadd %d[result], %d[result], d2 \n"
            : [result] "+w" (result)
            : [a] "r" (a), [b] "r" (b)
            : "d0", "d1", "d2", "memory"
        );
    }
    return result;
}

size_t mystrlen(const char *str)
{
    size_t res;
    asm("mov x0, %1              \n"
        "mov x1, #0              \n"
        "1:                      \n"
        "ldrb w2, [x0], #1       \n"
        "cmp w2, #0              \n"
        "add x1, x1, #1          \n"
        "bne 1b                  \n"
        "sub x1, x1, #1          \n"
        "mov %0, x1              \n"
        : "=r" (res)
        : "r" (str)
        : "x0", "x1", "w2");
    return res;
}

void print_vector(double *vector, size_t len)
{
	for (size_t i = 0; i < len; ++i)
	{
		printf("%.6lf ", vector[i]);
	}
	printf("\n");
}

int main(void)
{
    double v1[3] = {1, 1, 1};
	double v2[3] = {1, 1, 1};
    double result = scalar_product(v1, v2, 3);
    printf("v1:\n");
    print_vector(v1, 3);
    printf("v2:\n");
    print_vector(v2, 3);
	printf("Result: %f\n", result);

    const char *str = "Assembler";
    size_t len = mystrlen(str);
    printf("String: %s\n", str);
    printf("Length: %zu\n\n", len);
    return 0;
}