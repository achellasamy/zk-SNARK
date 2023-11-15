#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <numPolynomials>\n", argv[0]);
        return 1;
    }

    const char* filename = "polynomials.txt";
    FILE* fp = fopen(filename, "w");

    if (fp == NULL) {
        printf("Error: Could not open file %s for writing\n", filename);
        return 1;
    }

    srand(time(NULL));

    int numPolynomials = atoi(argv[1]);

    for (int i = 0; i < numPolynomials; i++) {
        // Generate a random length for the polynomial (2, 4, 8, 16, etc.)
        int length = 1 << (rand() % 4 + 1); // 2^1, 2^2, 2^3, or 2^4

        // Initialize an array for the coefficients
        int coefficients[length];

        // Generate random integer coefficients for degrees 0 to 3
        for (int j = 0; j < length; j++) {
            coefficients[j] = rand() % 101; // Random integer values between 0 and 100
        }

        // Write the coefficients to the file in the specified format
        fprintf(fp, "{%d, %d, %d, %d}\n", coefficients[0], coefficients[1], coefficients[2], coefficients[3]);
    }

    fclose(fp);
    printf("Polynomials with integer coefficients have been written to %s\n", filename);

    return 0;
}
