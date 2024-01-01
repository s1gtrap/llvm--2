declare i32 @add(i32, i32)

define i32 @mul (i32 %0, i32 %1) {
 %3 = icmp sgt i32 %0, 0
 br i1 %3, label %6, label %4
4:
 %5 = phi i32 [0, %2], [%9, %6]
 ret i32 %5
6:
 %7 = phi i32 [%10, %6], [0, %2]
 %8 = phi i32 [%9, %6], [0, %2]
 %9 = call i32 @add (i32 %8, i32 %1)
 %10 = add i32 %7, 1
 %11 = icmp eq i32 %10, %0
 br i1 %11, label %4, label %6
}
