@.str = global [1 x i8] c"\00"

declare i32 @printf(i8*, ...)

define i64 @main() {
0:
  br label %1
1:
  %2 = phi i64 [0, %0], [%3, %1]
  %3 = add i64 %2, 1
  %a = add i64 %3, 1
  %b = add i64 %3, 1
  %c = add i64 %3, 1
  call void @printf(i8* @.str)
  %4 = icmp eq i64 %3, 100000000
  br i1 %4, label %5, label %1
5:
  %6 = add i64 %3, 1
  %7 = add i64 %3, 2
  %8 = add i64 %3, 3
  %9 = add i64 %3, 4
  %10 = add i64 %3, 5
  %11 = add i64 %3, 6
  %12 = add i64 %3, 7
  %13 = add i64 %3, 8
  %14 = add i64 %3, 9
  %15 = add i64 %3, 10
  %16 = add i64 %3, 11
  %17 = add i64 %3, 12
  %18 = add i64 %3, 13
  %19 = add i64 %3, 14
  %20 = add i64 %3, 15
  %21 = add i64 %3, 16
  %22 = add i64 %3, 17
  %23 = add i64 %3, %6
  %24 = add i64 %3, %7
  %25 = add i64 %3, %8
  %26 = add i64 %3, %9
  %27 = add i64 %3, %10
  %28 = add i64 %3, %11
  %29 = add i64 %3, %12
  %30 = add i64 %3, %13
  %31 = add i64 %3, %14
  %32 = add i64 %3, %15
  %33 = add i64 %3, %16
  %34 = add i64 %3, %17
  ret i64 %3
}
