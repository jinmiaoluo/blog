	.file	"pcount_for.c"
	.text
	.globl	pcount_for
	.type	pcount_for, @function
pcount_for:
.LFB0:
	.cfi_startproc
	movl	$0, %edx
	movl	$0, %ecx
	jmp	.L2
.L3:
	movq	%rdi, %rax
	shrq	%cl, %rax
	andl	$1, %eax
	addq	%rax, %rdx
	addq	$1, %rcx
.L2:
	cmpq	$31, %rcx
	jbe	.L3
	movq	%rdx, %rax
	ret
	.cfi_endproc
.LFE0:
	.size	pcount_for, .-pcount_for
	.ident	"GCC: (GNU) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
