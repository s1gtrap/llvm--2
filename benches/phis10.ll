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
  %10 = add i32 18, 19
  br label %11
11:
  %12 = phi i32 [0, %0], [%33, %11]
  %13 = phi i32 [%1, %0], [%13, %11]
  %14 = phi i32 [%2, %0], [%14, %11]
  %15 = phi i32 [%3, %0], [%15, %11]
  %16 = phi i32 [%4, %0], [%16, %11]
  %17 = phi i32 [%5, %0], [%17, %11]
  %18 = phi i32 [%6, %0], [%18, %11]
  %19 = phi i32 [%7, %0], [%19, %11]
  %20 = phi i32 [%8, %0], [%20, %11]
  %21 = phi i32 [%9, %0], [%21, %11]
  %22 = phi i32 [%10, %0], [%22, %11]
  ;call void @printf (i8* @.str, i32 %13)
  ;call void @printf (i8* @.str, i32 %14)
  ;call void @printf (i8* @.str, i32 %15)
  ;call void @printf (i8* @.str, i32 %16)
  ;call void @printf (i8* @.str, i32 %17)
  ;call void @printf (i8* @.str, i32 %18)
  ;call void @printf (i8* @.str, i32 %19)
  ;call void @printf (i8* @.str, i32 %20)
  ;call void @printf (i8* @.str, i32 %21)
  ;call void @printf (i8* @.str, i32 %22)
  %23 = add i32 %13, %22
  %24 = add i32 %14, %21
  %25 = add i32 %15, %20
  %26 = add i32 %16, %19
  %27 = add i32 %17, %18
  %28 = add i32 %18, %17
  %29 = add i32 %19, %16
  %30 = add i32 %20, %15
  %31 = add i32 %21, %14
  %32 = add i32 %22, %13
  ;call void @printf (i8* @.str, i32 %23)
  ;call void @printf (i8* @.str, i32 %24)
  ;call void @printf (i8* @.str, i32 %25)
  ;call void @printf (i8* @.str, i32 %26)
  ;call void @printf (i8* @.str, i32 %27)
  ;call void @printf (i8* @.str, i32 %28)
  ;call void @printf (i8* @.str, i32 %29)
  ;call void @printf (i8* @.str, i32 %30)
  ;call void @printf (i8* @.str, i32 %31)
  ;call void @printf (i8* @.str, i32 %32)
  %33 = add i32 %12, 1
  %34 = icmp eq i32 %33, 536870912
  br i1 %34, label %35, label %11
35:
  ret i32 0
}
