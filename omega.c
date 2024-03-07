#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>


#define MODULUS 998244353  // A prime modulus for NTT
#define PRIMITIVE_ROOT 3   // A primitive root for the chosen modulus

int mod_pow(int base, int exp, int mod);
void omega(int n, int root);

int main() {
    int root = mod_pow(PRIMITIVE_ROOT, (MODULUS - 1) / 4, MODULUS);
    printf("Root: %d\n\n", root);
    omega(64, root);
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



void omega(int n, int root) {
int index = 0;
for (int m = 1; m < n; m *= 2) {
        int w_m = mod_pow(root, (MODULUS - 1) / (2 * m), MODULUS);
        printf("Int w_m: %d\n\n", w_m);
        for (int k = 0; k < n; k += 2 * m) {
            int w = 1;
            for (int j = 0; j < m; j++) {
                w = (w * (long long)w_m) % MODULUS;
                printf("Index: %d, W: %llu\n",index, w);
                index++;
            }
        }
    }
}
