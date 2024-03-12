#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <inttypes.h>

#define ROWS 64
#define COLS 64

//global variables
uint64_t P = 0xFFFFFFFF00000001; //Prime P

int main() {
	
	clock_t start_time, end_time;
	double elapsed_time;
	start_time = clock();

    FILE *file = fopen("polynomials64x64.txt", "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    //Array storing polynomial values (x values)
    uint64_t inputArray[ROWS][COLS];

    //Array storing output of NTT (y values)
    uint64_t outputArray[ROWS][COLS];

    // Read the values from the file into the array
    for (int i = 0; i < ROWS; i++) {
        for (int j = 0; j < COLS; j++) {
            if (fscanf(file, "%" SCNu64, &inputArray[i][j]) != 1) {
                fprintf(stderr, "Error reading file at row %d, column %d\n", i+1, j+1);
                fclose(file);
                return 1;
            }
        }
    }

    // Close the file
    fclose(file);

    //Omega Value Array
    uint64_t W [64][64];

    //Omega Value Generation
    for(int i = 0; i < 64; i++){
        for(int j = 0; j < 64; j++){
            W[i][j] = (i*j) % P;
        }
    }

    //NTT Calculation
    for(int i = 0; i < 64; i++) {
        for(int j = 0; j < ROWS; j++) {
            uint64_t sum = 0;
            for(int k = 0; k < COLS; k++) {
                uint64_t temp;
                temp = (inputArray[j][k] << W[j][k]) % P;
                sum = (sum + temp) % P;
            }
            outputArray[i][j] = sum;
        }
    }

    //Print output array to file
    char *outputname = "outputNTT64x64.txt";
    FILE *out = fopen(outputname, "w");

    for (int i = 0; i < ROWS; i++) {
        for (int j = 0; j < COLS; j++) {
            fprintf(out, "%lX, ", outputArray[i][j]);
        }
        fprintf(out, "\n");
    }
/*
    // Printing the content of the array (for verification)
    for (int i = 0; i < ROWS; i++) {
        for (int j = 0; j < COLS; j++) {
            printf("%" PRIu64 " ", outputArray[i][j]);
        }
        printf("\n");
    }	
*/
    return 0;
}
