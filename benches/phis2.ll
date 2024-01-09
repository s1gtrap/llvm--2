define i32 @main() {
0:
  %1 = add i32 0, 1
  %2 = add i32 2, 3
  br label %3
3:
  %4 = phi i32 [0, %0], [%7, %3]
  %5 = phi i32 [%1, %0], [%5, %3]
  %6 = phi i32 [%2, %0], [%6, %3]
  %7 = add i32 %4, 1
  %8 = icmp eq i32 %7, 2147483647
  br i1 %8, label %9, label %3
9:
  ret i32 0
}
