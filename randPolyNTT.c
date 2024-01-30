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
        int length = 64;

        // Initialize an array for the coefficients
        int *coefficients = malloc(length * sizeof(int));

        // Generate random integer coefficients for degrees 0 to 63
        for (int j = 0; j < length; j++) {
            coefficients[j] = rand() % 101; // Random integer values between 0 and 100
        }

        // Write the coefficients to the file in the specified format
        fprintf(fp, "{");
        for (int j = 0; j < length - 1; j++) {
            fprintf(fp, "%d, ", coefficients[j]);
        }
        fprintf(fp, "%d}\n", coefficients[length - 1]);

        free(coefficients);
    }

    fclose(fp);
    printf("Polynomials with integer coefficients have been written to %s\n", filename);

    return 0;
}
