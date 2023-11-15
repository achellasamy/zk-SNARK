#define _USE_MATH_DEFINES
#include <stdio.h>
#include <math.h>
#include <complex.h>
#include <stdlib.h>
#include <time.h>

#ifndef M_PI
#define M_PI (3.14159265358979323846264338327950288) // Define M_PI if not already defined
#endif

double complex* fft(double complex P[], int n);

int main() {
	
	clock_t start_time, end_time;
	double elapsed_time;
	
	start_time = clock();
	
	char *filename = "polynomials.txt";
	char *outputname = "outputFFT.txt";
	FILE *fp = fopen(filename, "r");
	FILE *out = fopen(outputname, "w");
	
	if (fp == NULL)
    {
        printf("Error: could not open file %s", filename);
        return 1;
    }
	
	char line[256];
    while (fgets(line, sizeof(line), fp) != NULL) {
        
        // Split the line into an array of coefficients
        int read[4];
		double complex P[4];
		
		if (sscanf(line, "{%d, %d, %d, %d}\n", &read[0], &read[1], &read[2], &read[3]) == 4) {
			for(int i = 0; i < 4; i++)
				P[i] = (double) read[i];
			
 			int n = sizeof(P) / sizeof(P[0]);
			double complex* x = fft(P, n);
			
			fprintf(out, "{%f + %fi, %f + %fi, %f + %fi, %f + %fi}\n", creal(x[0]), cimag(x[0]),
																	   creal(x[1]), cimag(x[1]),
																	   creal(x[2]), cimag(x[2]),
																	   creal(x[3]), cimag(x[3]));
		
			free(x);
        } else {
            printf("Error parsing P from line: %s\n", line);
        }
    }
	
	end_time = clock();
	elapsed_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;
	printf("Program execution time: %f seconds\n", elapsed_time);
	
	fclose(fp);
	fclose(out);

    return 0;
}

double complex* fft(double complex P[], int n) {
    if (n == 1) {
        double complex* result = (double complex*)malloc(sizeof(double complex));
        result[0] = P[0];
        return result;
    }

    double complex w = cexp(2.0 * I * M_PI / n);

    double complex* Pe = (double complex*)malloc((n / 2) * sizeof(double complex));
    double complex* Po = (double complex*)malloc((n / 2) * sizeof(double complex));

    for (int i = 0; i < n; i++) {
        if (i % 2 == 0)
            Pe[i / 2] = P[i];
        else
            Po[(i - 1) / 2] = P[i];
    }

    double complex* ye = fft(Pe, n / 2);
    double complex* yo = fft(Po, n / 2);

    double complex* y = (double complex*)malloc(n * sizeof(double complex));
    for (int i = 0; i < n / 2; i++) {
        y[i] = ye[i] + cpow(w, i) * yo[i];
        y[i + n / 2] = ye[i] - cpow(w, i) * yo[i];
    }

    free(Pe);
    free(Po);
    free(ye);
    free(yo);

    return y;
}
