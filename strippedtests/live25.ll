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
 %11 = add i8 %10, 1
 %12 = add i8 %11, 1
 %13 = add i8 %12, 1
 %14 = add i8 %12, %13
 %15 = add i8 %11, %14
 %16 = add i8 %10, %15
 %17 = add i8 %9, %16
 %18 = add i8 %8, %17
 %19 = add i8 %7, %18
 %20 = add i8 %6, %19
 %21 = add i8 %5, %20
 %22 = add i8 %4, %21
 %23 = add i8 %3, %22
 %24 = add i8 %2, %23
 %25 = add i8 %1, %24
 ret i8 %25
}
