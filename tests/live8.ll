define i32 @main (i32 %0, i8* %1) {
  %3 = add i32 %0, 1
  %4 = add i32 %3, 2
  %5 = add i32 %4, 3
  %6 = add i32 %5, 4
  %7 = add i32 %6, 5
  %8 = add i32 %7, 6
  %9 = add i32 %8, 7
  %10 = add i32 %9, 8
  %11 = add i32 %10, 9
  %12 = add i32 %11, 10
  %13 = add i32 %10, 11
  %14 = add i32 %9, 12
  %15 = add i32 %8, 13
  %16 = add i32 %7, 14
  %17 = add i32 %6, 15
  %18 = add i32 %5, 16
  %19 = add i32 %4, 17
  %20 = add i32 %3, 18
  ret i32 %20
}
