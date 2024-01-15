@.str = global [4 x i8] c"%d\0A\00"
declare i32 @printf(i8*, ...)

define i32 @main() {
0:
  %1 = add i32 0, 1
  %2 = add i32 2, 3
  %3 = add i32 4, 5
  %4 = add i32 6, 7
  %5 = add i32 8, 9
  br label %6
6:
  %7 = phi i32 [0, %0], [%18, %6]
  %8 = phi i32 [%1, %0], [%8, %6]
  %9 = phi i32 [%2, %0], [%9, %6]
  %10 = phi i32 [%3, %0], [%10, %6]
  %11 = phi i32 [%4, %0], [%11, %6]
  %12 = phi i32 [%5, %0], [%12, %6]
  ;call void @printf (i8* @.str, i32 %8)
  ;call void @printf (i8* @.str, i32 %9)
  ;call void @printf (i8* @.str, i32 %10)
  ;call void @printf (i8* @.str, i32 %11)
  ;call void @printf (i8* @.str, i32 %12)
  %13 = add i32 %8, %12
  %14 = add i32 %9, %11
  %15 = add i32 %10, %10
  %16 = add i32 %11, %9
  %17 = add i32 %12, %8
  ;call void @printf (i8* @.str, i32 %13)
  ;call void @printf (i8* @.str, i32 %14)
  ;call void @printf (i8* @.str, i32 %15)
  ;call void @printf (i8* @.str, i32 %16)
  ;call void @printf (i8* @.str, i32 %17)
  %18 = add i32 %7, 1
  %19 = icmp eq i32 %18, 16777215
  br i1 %19, label %20, label %6
20:
  ret i32 0
}
