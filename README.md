# Coding Challenge
## Main operations (Without Optimization)
```c
   for (int i = 0; i < n; ++i) {
        int32_t acc = (int32_t)a[i] + (int32_t)alpha * (int32_t)b[i];
        y[i] = sat_q15_scalar(acc);
   }
```
> every thing in c is a representation of `unsigned char[]`

# Design Choices and Reasoning
## Design
translate the `for` loop one to one, using appropriate RVV functions (strip-mining with loop)
> Pseudo-code:  
> 1. Initialize vector units/registers  
> 2. Set the 'vl' register (configure vector length)    
> 3. loop:  
> 4.    Load a[i], b[i] into vector registers as they are (`int16_t`)   
> 5.    Perform arithmetic (sign extended), and store it to temp register (`acc`)   
> 7.    int-narrow `acc` to `int16_t`, store it in `result`     
> 8.    Store result to memory (y[i])   
> 9. if (i < n) goto loop

## Implementation and Generated Assembly
+ [Implementation](q15_axpy_challenge.c)
+ [Assembly](q15_axpy_challenge.rvv.s)
### Side Notes:
Compile instruction: `riscv64-unknown-elf-gcc  q15_axpy_challenge.c -march=rv64gcv -O3 -S q15_axpy_challenge.s`

## Reasoning
The design attempts to translate the semantic of the provided loop into RVV
assembly by using RVV C intrinsics. The implementation attempted to achieve
one-to-one translation of the original `for` loop to RVV assembly for correctness.

