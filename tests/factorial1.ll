define i32 @main (i32 %0, i8* %1) {
 %3 = icmp sgt i32 %0, 1
 br i1 %3, label %4, label %10
4:
 %5 = phi i32 [%7, %4], [1, %2]
 %6 = phi i32 [%8, %4], [%0, %2]
 %7 = mul i32 %5, %6
 %8 = add i32 %6, -1
 %9 = icmp sgt i32 %6, 2
 br i1 %9, label %4, label %10
10:
 %11 = phi i32 [1, %2], [%7, %4]
 ret i32 %11
}
