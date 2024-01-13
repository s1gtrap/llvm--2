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
  %8 = add i32 14, 15
  br label %9
9:
  %10 = phi i32 [0, %0], [%27, %9]
  %11 = phi i32 [%1, %0], [%11, %9]
  %12 = phi i32 [%2, %0], [%12, %9]
  %13 = phi i32 [%3, %0], [%13, %9]
  %14 = phi i32 [%4, %0], [%14, %9]
  %15 = phi i32 [%5, %0], [%15, %9]
  %16 = phi i32 [%6, %0], [%16, %9]
  %17 = phi i32 [%7, %0], [%17, %9]
  %18 = phi i32 [%8, %0], [%18, %9]
  ;call void @printf (i8* @.str, i32 %11)
  ;call void @printf (i8* @.str, i32 %12)
  ;call void @printf (i8* @.str, i32 %13)
  ;call void @printf (i8* @.str, i32 %14)
  ;call void @printf (i8* @.str, i32 %15)
  ;call void @printf (i8* @.str, i32 %16)
  ;call void @printf (i8* @.str, i32 %17)
  ;call void @printf (i8* @.str, i32 %18)
  %19 = add i32 %11, %18
  %20 = add i32 %12, %17
  %21 = add i32 %13, %16
  %22 = add i32 %14, %15
  %23 = add i32 %15, %14
  %24 = add i32 %16, %13
  %25 = add i32 %17, %12
  %26 = add i32 %18, %11
  ;call void @printf (i8* @.str, i32 %19)
  ;call void @printf (i8* @.str, i32 %20)
  ;call void @printf (i8* @.str, i32 %21)
  ;call void @printf (i8* @.str, i32 %22)
  ;call void @printf (i8* @.str, i32 %23)
  ;call void @printf (i8* @.str, i32 %24)
  ;call void @printf (i8* @.str, i32 %25)
  ;call void @printf (i8* @.str, i32 %26)
  %27 = add i32 %10, 1
  %28 = icmp eq i32 %27, 536870912
  br i1 %28, label %29, label %9
29:
  ret i32 0
}
