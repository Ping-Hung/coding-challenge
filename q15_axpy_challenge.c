// src/q15_axpy_challenge.c
// Single-solution RVV challenge: Q15 y = a + alpha * b  (saturating to Q15)
//

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// -------------------- Scalar reference (no intrinsics) --------------------
static inline int16_t sat_q15_scalar(int32_t v) 
{
    /* casting int32_t to int16_t */
    // 32767 ⇔ 2^15 - 1; -32768 ⇔ -2^15; boundary values for int16_t
    if (v >  32767) return  32767;
    if (v < -32768) return -32768;
    return (int16_t)v;
}

void q15_axpy_ref(const int16_t *a, const int16_t *b, int16_t *y, int n, int16_t alpha)
{
    /**
     * for each element in y:
     *    acc ← int32_t computation
     *    y[i] ← int16_t_version(acc) 
     */
    for (int i = 0; i < n; ++i) {
        int32_t acc = (int32_t)a[i] + (int32_t)alpha * (int32_t)b[i];
        y[i] = sat_q15_scalar(acc);
    }
}

// -------------------- RVV include per ratified v1.0 spec ------------------
#if __riscv_v_intrinsic >= 1000000
#include <riscv_vector.h>  // v1.0 test macro & header inclusion
#endif

// -------------------- RVV implementation (mentees edit only here) ---------
void q15_axpy_rvv(const int16_t *a, const int16_t *b, int16_t *y, int n, int16_t alpha)
{
#if !defined(__riscv) || !defined(__riscv_vector) || (__riscv_v_intrinsic < 1000000)
    // Fallback (keeps correctness off-target)
    q15_axpy_ref(a, b, y, n, alpha);
#else
    // Vectors: a: int16_t[], b: int16_t[], y: int16_t[], acc: int32_t[]
    // scalar: n: int16_t, alpha: int16_t
    // TODO: Enter your solution here
    // strip-mining loop
    size_t vl = 0;
    int32_t alpha32 = (int32_t)alpha;   // cast (sign extend) alpha (a scalar)
    for (int i = 0; i < n; i += vl) {
        // setup vl for the remaining elements, each element 16-bit wide
        vl = __riscv_vsetvl_e16mf2(n - i);
        // load a, b into vector units (respect their original width of 16 bits)
        vint16mf2_t v_a16_mf2 = __riscv_vle16_v_i16mf2(a + i, vl);
        vint16mf2_t v_b16_mf2 = __riscv_vle16_v_i16mf2(b + i, vl);
        // compute int32_t acc = (int32_t)a[i] + (int32_t)alpha * (int32_t)b[i];
        // with sign-extended multiply then sign-extended add
        vint32m1_t v_acc32_m1 = __riscv_vwmul_vx_i32m1(v_b16_mf2, alpha32); // sign-extended multiply first
        v_acc32_m1 = __riscv_vwadd_wv_i32m1(v_acc32_m1, v_a16_mf2); // arg1: vint32m1_t; arg2: vint16mf2_t
        // convert result from int32_t to int16_t
        vint16mf2 result = __riscv_vncvt_x_x_w_i16mf2(v_acc32_m1, vl);
        // store result to memory (vector y)
        __riscv_vse16_v_i16mf2(y + i, result, vl);  // base, value, vector length
    }
#endif
}

// -------------------- Verification & tiny benchmark -----------------------
static int verify_equal(const int16_t *ref, const int16_t *test, int n, int32_t *max_diff) 
{
    int ok = 1;
    int32_t md = 0;
    for (int i = 0; i < n; ++i) {
        int32_t d = (int32_t)ref[i] - (int32_t)test[i];
        if (d < 0) d = -d;
        if (d > md) md = d;
        if (d != 0) ok = 0;
    }
    *max_diff = md;
    return ok;
}

#if defined(__riscv)
static inline uint64_t rdcycle(void) { uint64_t c; asm volatile ("rdcycle %0" : "=r"(c)); return c; }
#endif

int main(void) 
{
    int ok = 1;
    const int N = 4096;
    int16_t *a  = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));
    int16_t *b  = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));
    int16_t *y0 = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));
    int16_t *y1 = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));

    // Deterministic integer data (no libm)
    srand(1234);
    for (int i = 0; i < N; ++i) {
        a[i] = (int16_t)((rand() % 65536) - 32768);
        b[i] = (int16_t)((rand() % 65536) - 32768);
    }

    const int16_t alpha = 3; // example scalar gain

    uint32_t c0 = rdcycle();
    q15_axpy_ref(a, b, y0, N, alpha);
    uint32_t c1 = rdcycle();
    printf("Cycles ref: %u\n", c1 - c0);

    int32_t md = 0;

#if defined(__riscv)
    c0 = rdcycle();
    q15_axpy_rvv(a, b, y1, N, alpha);
    c1 = rdcycle();
    ok = verify_equal(y0, y1, N, &md);
    printf("Verify RVV: %s (max diff = %d)\n", ok ? "OK" : "FAIL", md);
    printf("Cycles RVV: %llu\n", (unsigned long long)(c1 - c0));
#endif

    free(a); 
    free(b); 
    free(y0); 
    free(y1);
    return ok ? 0 : 1;
}
