#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_SIZE 64
#define MAX_VALUE 100

uint64_t MAX = 0xffffffff00000001;

void generateRandomArray(uint64_t array[ARRAY_SIZE]) {
    for (int i = 0; i < ARRAY_SIZE; i++) {
        array[i] = rand() % (MAX + 1);
    }
}

void printArrayToFile(FILE *file, uint64_t array[ARRAY_SIZE]) {
    for (int i = 0; i < ARRAY_SIZE; i++) {
        fprintf(file, "%llu ", array[i]);
    }
    fprintf(file, "\n");
}

int main() {
    srand(time(NULL)); // Seed the random number generator

    FILE *file = fopen("array.txt", "w");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    uint64_t arrays[ARRAY_SIZE][ARRAY_SIZE];

    for (int i = 0; i < ARRAY_SIZE; i++) {
        generateRandomArray(arrays[i]);
        printArrayToFile(file, arrays[i]);
    }

    fclose(file);
    printf("Arrays have been printed to array.txt\n");

    return 0;
}

