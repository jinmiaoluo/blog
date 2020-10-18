	.file	"get_univ_digit.c"
	.text
	.globl	get_univ_digit
	.type	get_univ_digit, @function
get_univ_digit:
.LFB0:
	.cfi_startproc
	leaq	univ(%rip), %rax
	movq	(%rax,%rdi,8), %rax
	movl	(%rax,%rsi,4), %eax
	ret
	.cfi_endproc
.LFE0:
	.size	get_univ_digit, .-get_univ_digit
	.globl	univ
	.section	.data.rel.local,"aw"
	.align 16
	.type	univ, @object
	.size	univ, 24
univ:
	.quad	mit
	.quad	cmu
	.quad	ucb
	.globl	ucb
	.data
	.align 16
	.type	ucb, @object
	.size	ucb, 20
ucb:
	.long	9
	.long	4
	.long	7
	.long	2
	.long	0
	.globl	mit
	.align 16
	.type	mit, @object
	.size	mit, 20
mit:
	.long	0
	.long	2
	.long	1
	.long	3
	.long	9
	.globl	cmu
	.align 16
	.type	cmu, @object
	.size	cmu, 20
cmu:
	.long	1
	.long	5
	.long	2
	.long	1
	.long	3
	.ident	"GCC: (GNU) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
