	.file	"get_pgh_digit.c"
	.text
	.globl	get_pgh_digit
	.type	get_pgh_digit, @function
get_pgh_digit:
.LFB0:
	.cfi_startproc
	leaq	(%rdi,%rdi,4), %rax
	addq	%rsi, %rax
	leaq	pgh(%rip), %rdx
	movl	(%rdx,%rax,4), %eax
	ret
	.cfi_endproc
.LFE0:
	.size	get_pgh_digit, .-get_pgh_digit
	.globl	pgh
	.data
	.align 32
	.type	pgh, @object
	.size	pgh, 80
pgh:
	.long	1
	.long	5
	.long	2
	.long	0
	.long	6
	.long	1
	.long	5
	.long	2
	.long	1
	.long	3
	.long	1
	.long	5
	.long	2
	.long	1
	.long	7
	.long	1
	.long	5
	.long	2
	.long	2
	.long	1
	.ident	"GCC: (GNU) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
