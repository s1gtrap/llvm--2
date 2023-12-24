define i32 @main (i32 %0) {
1:
 %2 = icmp sgt i32 %0, 0
 br i1 %2, label %3, label %9
3:
 %4 = phi i32 [%0, %1], [%7, %3]
 %5 = phi i32 [0, %1], [%6, %3]
 %6 = add i32 %5, %0
 %7 = sub i32 %4, 1
 %8 = icmp ugt i32 %7, 0
 br i1 %8, label %3, label %9
9:
 %10 = phi i32 [0, %1], [%6, %3]
 ret i32 %10
}
