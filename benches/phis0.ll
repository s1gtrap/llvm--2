define i32 @main() {
0:
  br label %1
1:
  %2 = phi i32 [0, %0], [%3, %1]
  %3 = add i32 %2, 1
  %4 = icmp eq i32 %3, 2147483647
  br i1 %4, label %5, label %1
5:
  ret i32 0
}
