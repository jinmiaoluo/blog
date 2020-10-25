	.file	"set_val.c"
	.text
	.globl	set_val
	.type	set_val, @function
set_val:
.LFB0:
	.cfi_startproc
	jmp	.L2
.L3:
	movslq	16(%rdi), %rax
	movl	%esi, (%rdi,%rax,4)
	movq	24(%rdi), %rdi
.L2:
	testq	%rdi, %rdi
	jne	.L3
	ret
	.cfi_endproc
.LFE0:
	.size	set_val, .-set_val
	.ident	"GCC: (GNU) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
