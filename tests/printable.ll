declare void @puts(i8*)

define i8 @main () {
entry:
 %msg = alloca [2 x i8]
 %char1ptr = getelementptr i8, i8* %msg, i64 1
 store i8 0, i8* %char1ptr
 br label %loop
loop:
 %i0 = phi i8 [32, %entry], [%i1, %loop]
 %char0ptr = getelementptr i8, i8* %msg, i64 0
 store i8 %i0, i8* %char0ptr
 call void @puts (i8* %msg)
 %i1 = add i8 %i0, 1
 %c = icmp eq i8 %i1, 127
 br i1 %c, label %exit, label %loop
exit:
 ret i8 %i1
}
