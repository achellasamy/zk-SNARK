#!/bin/bash

gcc -g -std=c99 randPoly.c && ./a.out 1000
gcc -g -std=c99 FFT.c -lm && ./a.out
gcc -g -std=c99 NTT.c && ./a.out

gcc -g -std=c99 randPoly.c && ./a.out 10000
gcc -g -std=c99 FFT.c -lm && ./a.out
gcc -g -std=c99 NTT.c && ./a.out

gcc -g -std=c99 randPoly.c && ./a.out 100000
gcc -g -std=c99 FFT.c -lm && ./a.out
gcc -g -std=c99 NTT.c && ./a.out

gcc -g -std=c99 randPoly.c && ./a.out 1000000
gcc -g -std=c99 FFT.c -lm && ./a.out
gcc -g -std=c99 NTT.c && ./a.out

gcc -g -std=c99 randPoly.c && ./a.out 10000000
gcc -g -std=c99 FFT.c -lm && ./a.out
gcc -g -std=c99 NTT.c && ./a.out

gcc -g -std=c99 randPoly.c && ./a.out 100000000
gcc -g -std=c99 FFT.c -lm && ./a.out
gcc -g -std=c99 NTT.c && ./a.out


