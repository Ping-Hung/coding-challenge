# Coding Challenge
+ GitHub link: https://github.com/Ping-Hung/coding-challenge/tree/main
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
+ The design attempts to translate the semantic of the provided loop into RVV
  assembly by using RVV C intrinsics. The implementation attempted to achieve
  one-to-one translation of the original `for` loop to RVV assembly for
  correctness.
+ Version2 (V2): 
    - Try swapping the use of `mf2` types to `m1` to ensure more elements
      are processed in each iteration
    - Try using `__riscv_vnclip_wx_i16m1(result, 0, __RISCV_VXRM_RN, vl);` so
    the int-narrowing actually have the semantic meaning of `sat_q15_scalar`.
    - Use `__riscv_vnclip_wx_i16m1` for saturation rounding and choose the
      rounding rule to be round to nearest, ties to even to reduce rounding errors.
+ The output assembly stay unchanged probably because of the `-O3` flag, but
  that flag is required on my machine to output RVV assembly

