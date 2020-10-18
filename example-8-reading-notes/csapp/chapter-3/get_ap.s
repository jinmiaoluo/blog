	.file	"get_ap.c"
	.text
	.globl	get_ap
	.type	get_ap, @function
get_ap:
.LFB0:
	.cfi_startproc
	leaq	(%rdi,%rsi,4), %rax
	ret
	.cfi_endproc
.LFE0:
	.size	get_ap, .-get_ap
	.ident	"GCC: (GNU) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
