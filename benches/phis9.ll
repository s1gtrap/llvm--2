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
  %9 = add i32 16, 17
  br label %10
10:
  %11 = phi i32 [0, %0], [%30, %10]
  %12 = phi i32 [%1, %0], [%12, %10]
  %13 = phi i32 [%2, %0], [%13, %10]
  %14 = phi i32 [%3, %0], [%14, %10]
  %15 = phi i32 [%4, %0], [%15, %10]
  %16 = phi i32 [%5, %0], [%16, %10]
  %17 = phi i32 [%6, %0], [%17, %10]
  %18 = phi i32 [%7, %0], [%18, %10]
  %19 = phi i32 [%8, %0], [%19, %10]
  %20 = phi i32 [%9, %0], [%20, %10]
  ;call void @printf (i8* @.str, i32 %12)
  ;call void @printf (i8* @.str, i32 %13)
  ;call void @printf (i8* @.str, i32 %14)
  ;call void @printf (i8* @.str, i32 %15)
  ;call void @printf (i8* @.str, i32 %16)
  ;call void @printf (i8* @.str, i32 %17)
  ;call void @printf (i8* @.str, i32 %18)
  ;call void @printf (i8* @.str, i32 %19)
  ;call void @printf (i8* @.str, i32 %20)
  %21 = add i32 %12, %20
  %22 = add i32 %13, %19
  %23 = add i32 %14, %18
  %24 = add i32 %15, %17
  %25 = add i32 %16, %16
  %26 = add i32 %17, %15
  %27 = add i32 %18, %14
  %28 = add i32 %19, %13
  %29 = add i32 %20, %12
  ;call void @printf (i8* @.str, i32 %21)
  ;call void @printf (i8* @.str, i32 %22)
  ;call void @printf (i8* @.str, i32 %23)
  ;call void @printf (i8* @.str, i32 %24)
  ;call void @printf (i8* @.str, i32 %25)
  ;call void @printf (i8* @.str, i32 %26)
  ;call void @printf (i8* @.str, i32 %27)
  ;call void @printf (i8* @.str, i32 %28)
  ;call void @printf (i8* @.str, i32 %29)
  %30 = add i32 %11, 1
  %31 = icmp eq i32 %30, 4294967295
  br i1 %31, label %32, label %10
32:
  ret i32 0
}
