# zk-SNARK
Hardware acceleration of zk-SNARK

**FFT and NTT**
- Bash script will run all the code
- The number of computations can be changed in the bash script

**Hardware NTT**
- This is a 64-bit NTT that uses modulus and shift operators.
  **Input to the NTT**
  - Input is an unpacked array of size 64. Each element of the array is packed 64 bits.
  - The input represents an input vector x which has 64 elements each 64 bits long.
  - The input vector represents a polynomial of size 64.
  - The values of the vector can only be positive integers between 0 and Q-1.
  - Q being the prime number chosen. (It is 64'hffffffff00000001 in the NTT)

