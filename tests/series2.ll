define i32 @main (i32 %0, i8* %1) {
  %3 = add i32 %0, 1
  %4 = add i32 %0, %3
  %5 = add i32 %0, %4
  ret i32 %5
}
