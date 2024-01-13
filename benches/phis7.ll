@.str = global [4 x i8] c"%d\0A\00"
declare i32 @printf(i8*, ...)

define i32 @main() {
0:
  %1 = add i32 0, 1
  %2 = add i32 2, 3
  %3 = add i32 4, 5
  %4 = add i32 6, 7
  %5 = add i32 8, 9
  %6 = add i32 10, 11
  %7 = add i32 12, 13
  br label %8
8:
  %9 = phi i32 [0, %0], [%24, %8]
  %10 = phi i32 [%1, %0], [%10, %8]
  %11 = phi i32 [%2, %0], [%11, %8]
  %12 = phi i32 [%3, %0], [%12, %8]
  %13 = phi i32 [%4, %0], [%13, %8]
  %14 = phi i32 [%5, %0], [%14, %8]
  %15 = phi i32 [%6, %0], [%15, %8]
  %16 = phi i32 [%7, %0], [%16, %8]
  ;call void @printf (i8* @.str, i32 %10)
  ;call void @printf (i8* @.str, i32 %11)
  ;call void @printf (i8* @.str, i32 %12)
  ;call void @printf (i8* @.str, i32 %13)
  ;call void @printf (i8* @.str, i32 %14)
  ;call void @printf (i8* @.str, i32 %15)
  ;call void @printf (i8* @.str, i32 %16)
  %17 = add i32 %10, %16
  %18 = add i32 %11, %15
  %19 = add i32 %12, %14
  %20 = add i32 %13, %13
  %21 = add i32 %14, %12
  %22 = add i32 %15, %11
  %23 = add i32 %16, %10
  ;call void @printf (i8* @.str, i32 %17)
  ;call void @printf (i8* @.str, i32 %18)
  ;call void @printf (i8* @.str, i32 %19)
  ;call void @printf (i8* @.str, i32 %20)
  ;call void @printf (i8* @.str, i32 %21)
  ;call void @printf (i8* @.str, i32 %22)
  ;call void @printf (i8* @.str, i32 %23)
  %24 = add i32 %9, 1
  %25 = icmp eq i32 %24, 4294967295
  br i1 %25, label %26, label %8
26:
  ret i32 0
}
