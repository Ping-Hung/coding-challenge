# Progress
- Installed MSYS2
    + A software development and distribution environment.
- Installed QEMU
    + A virtual machine that could emulate a computer system or(and) user space.
- Forked and cloned the repository

# TODO
- [x] Figure out first steps of open-source contribution on GitHub.
- [x] Complete the Steps
- [x] Setup development environment (a RISCV supported system (let's use QEMU as emulator))
    - for now, only RISCV toolchain (which supports vectors) is compiled locally
- [ ] Begin working on the assigned task

# Dev Environment notes
- Only RISCV toolchain is built (i.e. I can compile my c code with `riscv64-unknown-elf-gcc`) 
- Maybe setup Qemu later

# Hardware General Information
```powershell
  裝置名稱  SF314-54
  處理器    Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz (1.80 GHz)
  已安裝記憶體(RAM) 8.00 GB (7.89 GB 可用)
  裝置識別碼    D375CD1B-F68A-4B7D-B403-27C3C0E933B8
  產品識別碼    00331-10000-00001-AA307
  系統類型  64 位元作業系統，x64 型處理器
  手寫筆與觸控  此顯示器不提供手寫筆或觸控式輸入功能
```
```wsl
  Architecture:             x86_64
    CPU op-mode(s):         32-bit, 64-bit
    Address sizes:          39 bits physical, 48 bits virtual
    Byte Order:             Little Endian
  CPU(s):                   8
    On-line CPU(s) list:    0-7
  Vendor ID:                GenuineIntel
    Model name:             Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
      CPU family:           6
      Model:                142
      Thread(s) per core:   2
      Core(s) per socket:   4
      Socket(s):            1
      Stepping:             10
      BogoMIPS:             3599.99
      Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2
                            ss ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon rep_good nopl xtopology cpuid 
                            tsc_known_freq pni pclmul qdq vmx ssse3 fma cx16 pdcm pcid sse4_1 sse4_2 movbe popcnt aes xsave avx 
                            f16c rdrand hypervisor lahf_lm abm 3dnowprefetch pti ssbd ibrs ibpb stibp tpr_shadow ept vpid 
                            ept_ad fsgsbase bmi1 avx2 smep bmi2 erms invpc id rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 
                            xsaves vnmi md_clear flush_l1d arch_capabilities
  Virtualization features:
    Virtualization:         VT-x
    Hypervisor vendor:      Microsoft
    Virtualization type:    full
  Caches (sum of all):
    L1d:                    128 KiB (4 instances)
    L1i:                    128 KiB (4 instances)
    L2:                     1 MiB (4 instances)
    L3:                     6 MiB (1 instance)
  NUMA:
    NUMA node(s):           1
    NUMA node0 CPU(s):      0-7
  Vulnerabilities:
    Gather data sampling:   Unknown: Dependent on hypervisor status
    Itlb multihit:          KVM: Mitigation: VMX disabled
    L1tf:                   Mitigation; PTE Inversion
    Mds:                    Mitigation; Clear CPU buffers; SMT Host state unknown
    Meltdown:               Mitigation; PTI
    Mmio stale data:        Mitigation; Clear CPU buffers; SMT Host state unknown
    Reg file data sampling: Not affected
    Retbleed:               Mitigation; IBRS
    Spec rstack overflow:   Not affected
    Spec store bypass:      Mitigation; Speculative Store Bypass disabled via prctl
    Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
    Spectre v2:             Mitigation; IBRS; IBPB conditional; STIBP conditional; RSB filling; PBRSB-eIBRS Not affected; 
                            BHI SW loop, KVM SW loop
    Srbds:                  Unknown: Dependent on hypervisor status
    Tsx async abort:        Not affected
```

# Development Environment
- WSL + Qemu (`qemu-user-static` for now)
- setup: 
    + cross compile program to RISCV hardware, run program with Qemu User Mode.

# Assigned Task Summary
- Write code that uses RISCV vector intrinsics which accelerates performance of function `q15_axpy_rvv(const`.
- Document design choices and reasoning
- Provide a rough calculation of expected speed-up if possible.

# Keywords
- RV-32, RV-64
- Vectorization: a parallel computing method with the idea of processing multiple data elements in a single instruction

# Docs and Resources:
## Project Contributor Contacts
### Mentor (主負責人)
- Christian Herber: https://www.linkedin.com/in/christian-herber-b8a019b9/
### Contributors
- Laurent Le Faucheur: https://www.linkedin.com/in/laurentlefaucheur/
### Slack Group
https://risc-v-international.slack.com/x-p1252003144916-10463783596386-10457394375027/messages/C017LD0GJ8Z

## Environment setup
- https://medium.com/@e1d1/risc-v-simulation-with-qemu-61ea8f2d8f4b 
- https://www.qemu.org/docs/master/system/target-riscv.html

## MSYS2
- https://www.msys2.org/docs/what-is-msys2/

## QEMU
- https://www.qemu.org/docs/master/about/index.html

## RISC-V V Vector Extension
- https://drive.google.com/file/d/1RTZi2iOLKzqaX95JCCnzwOm7iCIN3JEq/view
- https://medium.com/@ulhaqhassan1/understanding-risc-v-vector-architecture-elen-vlen-sew-lmul-vlmax-vl-vstart-explained-680f0abf5b18
- https://fprox.substack.com/p/risc-v-vector-programming-in-c-with
- https://github.com/riscv-non-isa/riscv-c-api-doc/blob/main/src/c-api.adoc

## Coding Challenge
- https://docs.google.com/document/d/1BLO9GU57161sGLYuBxm7MzcDJSVZIj5OYhqFli7t-Y0/edit?tab=t.0

## First Steps of Open Source Contribution
-  https://github.com/firstcontributions/first-contributions/blob/main/README.md
