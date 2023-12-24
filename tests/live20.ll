define i8 @main () {
 %1 = add i8 0, 1
 %2 = add i8 %1, 1
 %3 = add i8 %2, 1
 %4 = add i8 %3, 1
 %5 = add i8 %4, 1
 %6 = add i8 %5, 1
 %7 = add i8 %6, 1
 %8 = add i8 %7, 1
 %9 = add i8 %8, 1
 %10 = add i8 %9, 1
 %11 = add i8 %10, %10
 %12 = add i8 %9, %11
 %13 = add i8 %8, %12
 %14 = add i8 %7, %13
 %15 = add i8 %6, %14
 %16 = add i8 %5, %15
 %17 = add i8 %4, %16
 %18 = add i8 %3, %17
 %19 = add i8 %2, %18
 %20 = add i8 %1, %19
 ret i8 %20
}
