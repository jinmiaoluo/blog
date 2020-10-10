	.file	"xor-same-register.c"
	.text
	.globl	xorSameRegister
	.type	xorSameRegister, @function
xorSameRegister:
.LFB0:
	.cfi_startproc
	movl	$0, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	xorSameRegister, .-xorSameRegister
	.ident	"GCC: (GNU) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
