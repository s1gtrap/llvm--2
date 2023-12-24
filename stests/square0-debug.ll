@fmt = global [13 x i8] c"%%%u = %08x\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main (i32 %o0) {
l1:
 %o2 = icmp sgt i32 %o0, 0
 br i1 %o2, label %l3, label %l9
l3:
 %o4 = phi i32 [%o0, %l1], [%o7, %l3]
 %o5 = phi i32 [0, %l1], [%o6, %l3]
 call i32 @printf (i8* @fmt, i32 4, i32 %o4)
 call i32 @printf (i8* @fmt, i32 5, i32 %o5)
 %o6 = add i32 %o5, %o0
 call i32 @printf (i8* @fmt, i32 6, i32 %o6)
 %o7 = sub i32 %o4, 1
 call i32 @printf (i8* @fmt, i32 7, i32 %o7)
 %o8 = icmp ugt i32 %o7, 0
 br i1 %o8, label %l3, label %l9
l9:
 %o10 = phi i32 [0, %l1], [%o6, %l3]
 call i32 @printf (i8* @fmt, i32 10, i32 %o10)
 ret i32 %o10
}
