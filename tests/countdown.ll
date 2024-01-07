@fmt = global [4 x i8] c"%i\0A\00"

declare void @printf(i8*)

define i32 @main (i32 %argc, i8** %argv) {
entry:
 br label %loop
loop:
 %c1 = phi i32 [%argc, %entry], [%c2, %loop]
 call void @printf (i8* @fmt, i32 %c1)
 %c2 = sub i32 %c1, 1
 %cn = icmp sgt i32 %c2, 0
 br i1 %cn, label %loop, label %exit
exit:
 ret i32 0
}
