@.str = global [4 x i8] c"%d\0A\00"
declare i32 @printf(i8*, ...)

define i32 @main() {
0:
  %1 = add i32 0, 1
  %2 = add i32 2, 3
  %3 = add i32 4, 5
  %4 = add i32 6, 7
  br label %5
5:
  %6 = phi i32 [0, %0], [%15, %5]
  %7 = phi i32 [%1, %0], [%7, %5]
  %8 = phi i32 [%2, %0], [%8, %5]
  %9 = phi i32 [%3, %0], [%9, %5]
  %10 = phi i32 [%4, %0], [%10, %5]
  ;call void @printf (i8* @.str, i32 %7)
  ;call void @printf (i8* @.str, i32 %8)
  ;call void @printf (i8* @.str, i32 %9)
  ;call void @printf (i8* @.str, i32 %10)
  %11 = add i32 %7, %10
  %12 = add i32 %8, %9
  %13 = add i32 %9, %8
  %14 = add i32 %10, %7
  ;call void @printf (i8* @.str, i32 %11)
  ;call void @printf (i8* @.str, i32 %12)
  ;call void @printf (i8* @.str, i32 %13)
  ;call void @printf (i8* @.str, i32 %14)
  %15 = add i32 %6, 1
  %16 = icmp eq i32 %15, 4294967295
  br i1 %16, label %17, label %5
17:
  ret i32 0
}
