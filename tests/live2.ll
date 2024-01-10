define i32 @main (i32 %0, i8* %1) {
  %3 = add i32 %0, 1
  %4 = add i32 %3, 2
  %5 = add i32 %4, 3
  %6 = add i32 %5, 4
  %7 = add i32 %4, 5
  %8 = add i32 %3, 6
  ret i32 %8
}
