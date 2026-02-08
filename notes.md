# LMUL v.s. element width v.s. register width
## Definitions
**vl**: vector length
  + number of application elements in a vector
  + can span multiple vector registers
**LMUL**: logical vector register group multiplier
  + number of vector registers in a group (can be fractional)
  + usually grouped in $2^n$. (1/8, 1/4, 1/2, 1, 2, 4, 8)
**SEW**: selected element width
  + size (in bits) of each element (8, 15, 32)
## Mental Model
**vector** = LMUL * VLEN bits  
**elements** = (LMUL * VLEN) / element_width
## Source

