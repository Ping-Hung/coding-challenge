# Coding Challenge

## Main operations (Without Optimization)

```c
   for (int i = 0; i < n; ++i) {
        int32_t acc = (int32_t)a[i] + (int32_t)alpha * (int32_t)b[i];
        y[i] = sat_q15_scalar(acc);
   }
```
+ recall 
> every thing in c is a representation of `unsigned char[]`

# Design Choices and Reasoning
## Using RVV
plan 1: translate `for` loop one to one, see if there are matching RVV functions (strip-mining with loop)
> 1. Initialize vector units/registers
> 2. Set the 'vl' register (configure vector length)
> 3. loop:
> 4.    Load a[i], b[i] into vector registers (sign extended (and widened))
> 5.    Perform arithmetic, and store it to temp register (acc)
> 6.    Store result to memory (y[i])
> 7. if (i < n) goto loop

