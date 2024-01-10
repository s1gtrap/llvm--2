define i32 @main (i32 %0, i8* %1) {
  %3 = add i32 %0, 1
  %4 = add i32 %0, %3
  %5 = add i32 %0, %4
  %6 = add i32 %0, %5
  %7 = add i32 %0, %6
  %8 = add i32 %0, %7
  %9 = add i32 %0, %8
  %10 = add i32 %0, %9
  %11 = add i32 %0, %10
  ret i32 %11
}
