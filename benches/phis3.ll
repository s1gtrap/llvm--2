@.str = global [4 x i8] c"%d\0A\00"
declare i32 @printf(i8*, ...)

define i32 @main() {
0:
  %1 = add i32 0, 1
  %2 = add i32 2, 3
  %3 = add i32 4, 5
  br label %4
4:
  %5 = phi i32 [0, %0], [%12, %4]
  %6 = phi i32 [%1, %0], [%6, %4]
  %7 = phi i32 [%2, %0], [%7, %4]
  %8 = phi i32 [%3, %0], [%8, %4]
  ;call void @printf (i8* @.str, i32 %6)
  ;call void @printf (i8* @.str, i32 %7)
  ;call void @printf (i8* @.str, i32 %8)
  %9 = add i32 %6, %8
  %10 = add i32 %7, %7
  %11 = add i32 %8, %6
  ;call void @printf (i8* @.str, i32 %9)
  ;call void @printf (i8* @.str, i32 %10)
  ;call void @printf (i8* @.str, i32 %11)
  %12 = add i32 %5, 1
  %13 = icmp eq i32 %12, 536870912
  br i1 %13, label %14, label %4
14:
  ret i32 0
}
