@.str = global [4 x i8] c"%d\0A\00"
declare i32 @printf(i8*, ...)

define i32 @main() {
0:
  %1 = add i32 0, 1
  %2 = add i32 2, 3
  br label %3
3:
  %4 = phi i32 [0, %0], [%9, %3]
  %5 = phi i32 [%1, %0], [%5, %3]
  %6 = phi i32 [%2, %0], [%6, %3]
  ;call void @printf (i8* @.str, i32 %5)
  ;call void @printf (i8* @.str, i32 %6)
  %7 = add i32 %5, %6
  %8 = add i32 %6, %5
  ;call void @printf (i8* @.str, i32 %7)
  ;call void @printf (i8* @.str, i32 %8)
  %9 = add i32 %4, 1
  %10 = icmp eq i32 %9, 536870912
  br i1 %10, label %11, label %3
11:
  ret i32 0
}
