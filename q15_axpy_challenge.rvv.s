	.file	"q15_axpy_challenge.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_v1p0_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0_zca1p0_zcd1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	q15_axpy_ref
	.type	q15_axpy_ref, @function
q15_axpy_ref:
	ble	a3,zero,.L14
	addi	a5,a2,-2
	sub	t3,a5,a1
	sub	a5,a5,a0
	mv	t1,a2
	mv	a6,a0
	mv	a7,a1
	bgtu	a5,t3,.L18
.L4:
	csrr	t3,vlenb
	srli	t3,t3,1
	addi	t3,t3,-4
	bleu	a5,t3,.L3
	li	a5,32768
	vsetvli	t1,zero,e32,m1,ta,ma
	addiw	a7,a5,-1
	li	t3,-32768
	vmv.v.x	v7,a7
	vmv.v.x	v6,a4
	vmv.v.x	v5,t3
.L5:
	vsetvli	a5,a3,e16,mf2,ta,ma
	vle16.v	v1,0(a0)
	vle16.v	v3,0(a1)
	li	a4,-32768
	vmv.v.x	v4,a4
	vsetvli	zero,zero,e32,m1,ta,ma
	xori	a4,a4,-1
	vsext.vf2	v2,v1
	vsext.vf2	v1,v3
	vsetvli	zero,zero,e16,mf2,ta,ma
	vmv.v.x	v3,a4
	vsetvli	zero,zero,e32,m1,ta,ma
	vmadd.vv	v1,v6,v2
	slli	a4,a5,1
	sub	a3,a3,a5
	add	a0,a0,a4
	vmslt.vv	v0,v1,v5
	vsetvli	zero,zero,e16,mf2,ta,ma
	vnsrl.wi	v2,v1,0
	add	a1,a1,a4
	vmerge.vvm	v2,v2,v4,v0
	vsetvli	zero,zero,e32,m1,ta,ma
	vmsgt.vv	v0,v1,v7
	vsetvli	zero,zero,e16,mf2,ta,ma
	vmerge.vvm	v2,v2,v3,v0
	vse16.v	v2,0(a2)
	add	a2,a2,a4
	bne	a3,zero,.L5
	ret
.L3:
	slli	a3,a3,1
	add	a0,a0,a3
	li	a1,32768
	li	t3,-32768
.L8:
	lh	a3,0(a7)
	lh	a5,0(a6)
	addi	a2,a1,-1
	mulw	a3,a3,a4
	addw	a5,a5,a3
	bge	a5,a1,.L7
	blt	a5,t3,.L11
	mv	a2,a5
.L7:
	sh	a2,0(t1)
	addi	a6,a6,2
	addi	a7,a7,2
	addi	t1,t1,2
	bne	a0,a6,.L8
.L14:
	ret
.L18:
	mv	a5,t3
	j	.L4
.L11:
	li	a2,-32768
	j	.L7
	.size	q15_axpy_ref, .-q15_axpy_ref
	.align	1
	.globl	q15_axpy_rvv
	.type	q15_axpy_rvv, @function
q15_axpy_rvv:
	ble	a3,zero,.L32
	addi	a5,a2,-2
	sub	t3,a5,a1
	sub	a5,a5,a0
	mv	t1,a2
	mv	a6,a0
	mv	a7,a1
	bgtu	a5,t3,.L35
.L22:
	csrr	t3,vlenb
	srli	t3,t3,1
	addi	t3,t3,-4
	bleu	a5,t3,.L21
	li	a5,32768
	vsetvli	t1,zero,e32,m1,ta,ma
	addiw	a7,a5,-1
	li	t3,-32768
	vmv.v.x	v7,a7
	vmv.v.x	v6,a4
	vmv.v.x	v5,t3
.L23:
	vsetvli	a5,a3,e16,mf2,ta,ma
	vle16.v	v1,0(a0)
	vle16.v	v3,0(a1)
	li	a4,-32768
	vmv.v.x	v4,a4
	vsetvli	zero,zero,e32,m1,ta,ma
	xori	a4,a4,-1
	vsext.vf2	v2,v1
	vsext.vf2	v1,v3
	vsetvli	zero,zero,e16,mf2,ta,ma
	vmv.v.x	v3,a4
	vsetvli	zero,zero,e32,m1,ta,ma
	vmadd.vv	v1,v6,v2
	slli	a4,a5,1
	sub	a3,a3,a5
	add	a0,a0,a4
	vmslt.vv	v0,v1,v5
	vsetvli	zero,zero,e16,mf2,ta,ma
	vnsrl.wi	v2,v1,0
	add	a1,a1,a4
	vmerge.vvm	v2,v2,v4,v0
	vsetvli	zero,zero,e32,m1,ta,ma
	vmsgt.vv	v0,v1,v7
	vsetvli	zero,zero,e16,mf2,ta,ma
	vmerge.vvm	v2,v2,v3,v0
	vse16.v	v2,0(a2)
	add	a2,a2,a4
	bne	a3,zero,.L23
	ret
.L21:
	slli	a3,a3,1
	add	a0,a0,a3
	li	a1,32768
	li	t3,-32768
.L26:
	lh	a3,0(a7)
	lh	a5,0(a6)
	addi	a2,a1,-1
	mulw	a3,a3,a4
	addw	a5,a5,a3
	bge	a5,a1,.L25
	blt	a5,t3,.L29
	mv	a2,a5
.L25:
	sh	a2,0(t1)
	addi	a6,a6,2
	addi	a7,a7,2
	addi	t1,t1,2
	bne	a0,a6,.L26
.L32:
	ret
.L35:
	mv	a5,t3
	j	.L22
.L29:
	li	a2,-32768
	j	.L25
	.size	q15_axpy_rvv, .-q15_axpy_rvv
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"OK"
	.align	3
.LC1:
	.string	"FAIL"
	.align	3
.LC2:
	.string	"Cycles ref: %u\n"
	.align	3
.LC3:
	.string	"Verify RVV: %s (max diff = %d)\n"
	.align	3
.LC4:
	.string	"Cycles RVV: %llu\n"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	li	a1,8192
	li	a0,64
	sd	ra,72(sp)
	sd	s0,64(sp)
	sd	s1,56(sp)
	sd	s2,48(sp)
	sd	s3,40(sp)
	sd	s4,32(sp)
	sd	s5,24(sp)
	sd	s6,16(sp)
	sd	s7,8(sp)
	call	aligned_alloc
	mv	s3,a0
	li	a1,8192
	li	a0,64
	call	aligned_alloc
	mv	s4,a0
	li	a1,8192
	li	a0,64
	call	aligned_alloc
	li	a1,8192
	mv	s6,a0
	li	a0,64
	call	aligned_alloc
	mv	s5,a0
	li	s7,8192
	li	a0,1234
	call	srand
	mv	s0,s3
	mv	s1,s4
	add	s7,s3,s7
	li	s2,-32768
.L37:
	call	rand
	addw	a0,s2,a0
	sh	a0,0(s0)
	call	rand
	addw	a0,s2,a0
	sh	a0,0(s1)
	addi	s0,s0,2
	addi	s1,s1,2
	bne	s7,s0,.L37
 #APP
# 85 "q15_axpy_challenge.c" 1
	rdcycle a1
# 0 "" 2
 #NO_APP
	li	a5,32768
	vsetvli	a4,zero,e32,m1,ta,ma
	addiw	a5,a5,-1
	vmv.v.x	v3,a5
	vmv.v.i	v7,3
	li	a4,-32768
	vmv.v.x	v4,a4
	mv	a3,s6
	mv	a6,s4
	mv	a0,s3
	li	a4,4096
.L38:
	vsetvli	a5,a4,e16,mf2,ta,ma
	vle16.v	v1,0(a0)
	vle16.v	v5,0(a6)
	li	a2,-32768
	vmv.v.x	v6,a2
	vsetvli	zero,zero,e32,m1,ta,ma
	xori	a2,a2,-1
	vsext.vf2	v2,v1
	vsext.vf2	v1,v5
	vsetvli	zero,zero,e16,mf2,ta,ma
	vmv.v.x	v5,a2
	vsetvli	zero,zero,e32,m1,ta,ma
	vmadd.vv	v1,v7,v2
	slli	a2,a5,1
	sub	a4,a4,a5
	add	a0,a0,a2
	vmslt.vv	v0,v1,v4
	vsetvli	zero,zero,e16,mf2,ta,ma
	vnsrl.wi	v2,v1,0
	add	a6,a6,a2
	vmerge.vvm	v2,v2,v6,v0
	vsetvli	zero,zero,e32,m1,ta,ma
	vmsgt.vv	v0,v1,v3
	vsetvli	zero,zero,e16,mf2,ta,ma
	vmerge.vvm	v2,v2,v5,v0
	vse16.v	v2,0(a3)
	add	a3,a3,a2
	bne	a4,zero,.L38
 #APP
# 85 "q15_axpy_challenge.c" 1
	rdcycle a5
# 0 "" 2
 #NO_APP
	lui	a0,%hi(.LC2)
	subw	a1,a5,a1
	addi	a0,a0,%lo(.LC2)
	call	printf
 #APP
# 85 "q15_axpy_challenge.c" 1
	rdcycle s2
# 0 "" 2
 #NO_APP
	li	a2,-32768
	vsetvli	s0,zero,e32,m1,ta,ma
	vmv.v.x	v4,a2
	li	a2,32768
	addiw	a2,a2,-1
	vmv.v.i	v7,3
	vmv.v.x	v3,a2
	mv	a3,s5
	mv	a0,s4
	mv	a1,s3
	li	a4,4096
.L39:
	vsetvli	a5,a4,e16,mf2,ta,ma
	vle16.v	v1,0(a1)
	vle16.v	v5,0(a0)
	li	a2,-32768
	vmv.v.x	v6,a2
	vsetvli	zero,zero,e32,m1,ta,ma
	xori	a2,a2,-1
	vsext.vf2	v2,v1
	vsext.vf2	v1,v5
	vsetvli	zero,zero,e16,mf2,ta,ma
	vmv.v.x	v5,a2
	vsetvli	zero,zero,e32,m1,ta,ma
	vmadd.vv	v1,v7,v2
	slli	a2,a5,1
	sub	a4,a4,a5
	add	a1,a1,a2
	vmslt.vv	v0,v1,v4
	vsetvli	zero,zero,e16,mf2,ta,ma
	vnsrl.wi	v2,v1,0
	add	a0,a0,a2
	vmerge.vvm	v2,v2,v6,v0
	vsetvli	zero,zero,e32,m1,ta,ma
	vmsgt.vv	v0,v1,v3
	vsetvli	zero,zero,e16,mf2,ta,ma
	vmerge.vvm	v2,v2,v5,v0
	vse16.v	v2,0(a3)
	add	a3,a3,a2
	bne	a4,zero,.L39
 #APP
# 85 "q15_axpy_challenge.c" 1
	rdcycle s1
# 0 "" 2
 #NO_APP
	vsetvli	s0,zero,e32,m1,ta,ma
	vmv.v.i	v3,0
	vmv.v.i	v4,-1
	mv	a2,s6
	vmv1r.v	v6,v3
	mv	a3,s5
	li	a4,4096
.L40:
	vsetvli	a5,a4,e16,mf2,ta,ma
	vle16.v	v2,0(a2)
	vle16.v	v0,0(a3)
	slli	a1,a5,1
	sub	a4,a4,a5
	add	a3,a3,a1
	add	a2,a2,a1
	vwsub.vv	v1,v2,v0
	vwsub.vv	v5,v0,v2
	vmseq.vv	v0,v0,v2
	vsetvli	zero,zero,e32,m1,tu,ma
	vmax.vv	v1,v1,v5
	vmerge.vim	v2,v6,1,v0
	vmax.vv	v3,v1,v3
	vand.vv	v4,v2,v4
	bne	a4,zero,.L40
	vsetvli	s0,zero,e32,m1,ta,ma
	li	a5,-1
	vmv.s.x	v1,a5
	li	a5,-2147483648
	vredand.vs	v4,v4,v1
	vmv.s.x	v1,a5
	vredmax.vs	v3,v3,v1
	vmv.x.s	s0,v4
	andi	s0,s0,1
	vmv.x.s	a2,v3
	beq	s0,zero,.L42
	lui	a1,%hi(.LC0)
	addi	a1,a1,%lo(.LC0)
.L41:
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	printf
	subw	a1,s1,s2
	slli	a1,a1,32
	lui	a0,%hi(.LC4)
	srli	a1,a1,32
	addi	a0,a0,%lo(.LC4)
	call	printf
	mv	a0,s3
	call	free
	mv	a0,s4
	call	free
	mv	a0,s6
	call	free
	mv	a0,s5
	call	free
	ld	ra,72(sp)
	xori	a0,s0,1
	ld	s0,64(sp)
	ld	s1,56(sp)
	ld	s2,48(sp)
	ld	s3,40(sp)
	ld	s4,32(sp)
	ld	s5,24(sp)
	ld	s6,16(sp)
	ld	s7,8(sp)
	addi	sp,sp,80
	jr	ra
.L42:
	lui	a1,%hi(.LC1)
	addi	a1,a1,%lo(.LC1)
	j	.L41
	.size	main, .-main
	.ident	"GCC: () 15.2.0"
	.section	.note.GNU-stack,"",@progbits
