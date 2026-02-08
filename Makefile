EXE = q15_axpy_challenge
SRC = $(EXE).c
# GCC config
CC = gcc
FLAGS = -O3
# RISCV related configs
RCC = riscv64-unknown-elf-gcc 
RVV_FLAGS = -march=rv64gcv -O3	# need O3 optimization to invoke RVV

$(EXE): $(SRC)
	$(CC) -S $(SRC) $(FLAGS) -o $(EXE).s

rvv_assembly: $(SRC)
	$(RCC) -S $(SRC) $(RVV_FLAGS) -o $(EXE).rvv.s
