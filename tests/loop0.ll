define i32 @main() {
entry:
  %c0 = add i32 0, 0
  br label %loop
loop:
  %c1 = phi i32 [%entry, %c0], [%loop, %c2]
  %c2 = add i32 %c1, 1
  %cn = icmp eq i32 %c2, 10
  br i1 %cn, label %loop, label %exit
exit:
  ret i32 0
}
