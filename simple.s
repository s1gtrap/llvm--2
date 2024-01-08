
	.data
	.globl	_.str
_.str:
	.asciz	"%d!\012\000"
	.text
	.globl	_main
_main:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rsp, %rbp
	subq	$0, %rsp
	pushq	%rdi
	pushq	%rsi
	popq	%rdx
	popq	%rdi
	.text
_main$2:
	# %3 = icmp slt i32 %0, 1
	movq	$0, %rax
	movl	%edi, %eax
	movq	$0, %rcx
	movl	$1, %ecx
	cmpl	%ecx, %eax
	movq	$0, %rdx
	setl	%dl
	# br i1 %3, label %4, label %5
	movq	%rdx, %rax
	cmpq	$0, %rax
	movq	$1, %rax
	movq	%rax, %rsi
	je	_main$5
	jmp	_main$4
	.text
_main$4:
	# ret i32 0
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq	
	.text
_main$5:
	# %6 = phi i32 [%8, %5], [1, %2]
	# %7 = call i32 (i8*, ...) @printf (i8* @.str, i32 %6)
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movq	$0, %rax
	leaq	_.str(%rip), %rax
	pushq	%rax
	movq	$0, %rax
	movl	%esi, %eax
	pushq	%rax
	popq	%rsi
	popq	%rdi
	xorq	%rax, %rax
	callq	_printf
	addq	$0, %rsp
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	movq	%rax, %rdx
	# %8 = add i32 %6, 1
	movq	%rsi, %rax
	movq	$1, %rcx
	addq	%rcx, %rax
	movq	%rax, %rbx
	# %9 = icmp eq i32 %6, %0
	movq	$0, %rax
	movl	%esi, %eax
	movq	$0, %rcx
	movl	%edi, %ecx
	cmpl	%ecx, %eax
	movq	$0, %rdx
	sete	%dl
	# br i1 %9, label %4, label %5
	movq	%rdx, %rax
	cmpq	$0, %rax
	movq	%rbx, %rax
	movq	%rax, %rsi
	je	_main$5
	jmp	_main$4
