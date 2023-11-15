#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define MODULUS 998244353  // A prime modulus for NTT
#define PRIMITIVE_ROOT 3   // A primitive root for the chosen modulus

int mod_pow(int base, int exp, int mod);
void ntt(int *a, int n, int root);

/*
int main() {
    int n = 4;  // Change the size according to your requirement

    // Coefficients of the polynomials a = x^2 and b = x
    int a[] = {0, 0, 1, 0};  // Coefficients of x^2
    int b[] = {0, 1, 0, 0};  // Coefficients of x
    int result[n];

    int root = mod_pow(PRIMITIVE_ROOT, (MODULUS - 1) / n, MODULUS);
    ntt(a, n, root); 

    printf("Result of polynomial multiplication: \n");
    for (int i = 0; i < n; i++) {
        printf("%d ", a[i]);
    }
    
    printf("\n");

    return 0;
}
*/

int main() {
	
	clock_t start_time, end_time;
	double elapsed_time;
	
	start_time = clock();
	
	char *filename = "polynomials.txt";
	char *outputname = "outputNTT.txt";
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
		int P[4];
		
		if (sscanf(line, "{%d, %d, %d, %d}\n", &read[0], &read[1], &read[2], &read[3]) == 4) {
			for(int i = 0; i < 4; i++)
				P[i] = (double) read[i];
			
 			int root = mod_pow(PRIMITIVE_ROOT, (MODULUS - 1) / 4, MODULUS);
    			ntt(P, 4, root);
			
			fprintf(out, "{%d + 0i, %d + 0i, %d + 0i, %d + 0i}\n",P[0], P[1], P[2], P[3]);
		
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

int mod_pow(int base, int exp, int mod) {
    int result = 1;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * (long long)base) % mod;
        }
        base = (base * (long long)base) % mod;
        exp /= 2;
    }
    return result;
}

void ntt(int *a, int n, int root) {
    // Bit-reverse permutation
    int i, j, k;
    for (i = 0, j = 1; j < n - 1; j++) {
        for (k = n >> 1; k > (i ^= k); k >>= 1);
        if (j < i) {
            int temp = a[i];
            a[i] = a[j];
            a[j] = temp;
        }
    }

    // NTT
    for (int m = 1; m < n; m *= 2) {
        int w_m = mod_pow(root, (MODULUS - 1) / (2 * m), MODULUS);
        for (int k = 0; k < n; k += 2 * m) {
            int w = 1;
            for (int j = 0; j < m; j++) {
                int u = a[k + j];
                int v = (w * (long long)a[k + j + m]) % MODULUS;
                a[k + j] = (u + v) % MODULUS;
                a[k + j + m] = (u - v + MODULUS) % MODULUS;
                w = (w * (long long)w_m) % MODULUS;
            }
        }
    }
}
