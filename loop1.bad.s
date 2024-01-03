
	.data
	.globl	_fmt
_fmt:
	.asciz	"%i\012\000"
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
	.text
_main$entry:
	# %c0 = add i32 0, 0
	movq	$0, %rax
	movq	$0, %rcx
	addq	%rcx, %rax
	movq	%rax, %rsi
	# br label %loop
	movq	%rbx, %rdx
	jmp	_main$loop
	.text
_main$loop:
	# %c1 = phi i32 [%c0, %entry], [%c2, %loop]
	# call void @printf (i8* @fmt, i32 %c1)
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movq	$0, %rax
	leaq	_fmt(%rip), %rax
	pushq	%rax
	movq	$0, %rax
	movl	%edx, %eax
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
	# %c2 = add i32 %c1, 1
	movq	%rdx, %rax
	movq	$1, %rcx
	addq	%rcx, %rax
	movq	%rax, %rbx
	# %cn = icmp sle i32 %c2, 10
	movq	%rbx, %rax
	movq	$10, %rcx
	cmpl	%ecx, %eax
	movq	$0, %rdx
	setle	%dl
	# br i1 %cn, label %loop, label %exit
	movq	%rdx, %rax
	movq	$0, %rcx
	cmpq	%rax, %rcx
	je	_main$exit
	jmp	_main$loop
	.text
_main$exit:
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
