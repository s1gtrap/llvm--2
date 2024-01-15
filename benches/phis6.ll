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
  br label %7
7:
  %8 = phi i32 [0, %0], [%21, %7]
  %9 = phi i32 [%1, %0], [%9, %7]
  %10 = phi i32 [%2, %0], [%10, %7]
  %11 = phi i32 [%3, %0], [%11, %7]
  %12 = phi i32 [%4, %0], [%12, %7]
  %13 = phi i32 [%5, %0], [%13, %7]
  %14 = phi i32 [%6, %0], [%14, %7]
  ;call void @printf (i8* @.str, i32 %9)
  ;call void @printf (i8* @.str, i32 %10)
  ;call void @printf (i8* @.str, i32 %11)
  ;call void @printf (i8* @.str, i32 %12)
  ;call void @printf (i8* @.str, i32 %13)
  ;call void @printf (i8* @.str, i32 %14)
  %15 = add i32 %9, %14
  %16 = add i32 %10, %13
  %17 = add i32 %11, %12
  %18 = add i32 %12, %11
  %19 = add i32 %13, %10
  %20 = add i32 %14, %9
  ;call void @printf (i8* @.str, i32 %15)
  ;call void @printf (i8* @.str, i32 %16)
  ;call void @printf (i8* @.str, i32 %17)
  ;call void @printf (i8* @.str, i32 %18)
  ;call void @printf (i8* @.str, i32 %19)
  ;call void @printf (i8* @.str, i32 %20)
  %21 = add i32 %8, 1
  %22 = icmp eq i32 %21, 16777215
  br i1 %22, label %23, label %7
23:
  ret i32 0
}
