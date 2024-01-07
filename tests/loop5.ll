define i32 @main () {
 br label %2
1:
 ret i32 0
2:
 %3 = phi i32 [0, %0], [%4, %2]
 %4 = add i32 %3, 1
 %5 = icmp eq i32 %4, 2147483647
 br i1 %5, label %1, label %2
}
