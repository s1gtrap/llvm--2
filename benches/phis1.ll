define i32 @main() {
0:
  %1 = add i32 0, 1
  br label %2
2:
  %3 = phi i32 [0, %0], [%5, %2]
  %4 = phi i32 [%1, %0], [%4, %2]
  %5 = add i32 %3, 1
  %6 = icmp eq i32 %5, 2147483647
  br i1 %6, label %7, label %2
7:
  ret i32 0
}
