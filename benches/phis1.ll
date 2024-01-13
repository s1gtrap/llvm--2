@.str = global [4 x i8] c"%d\0A\00"
declare i32 @printf(i8*, ...)

define i32 @main() {
0:
  %1 = add i32 0, 1
  br label %2
2:
  %3 = phi i32 [0, %0], [%6, %2]
  %4 = phi i32 [%1, %0], [%4, %2]
  ;call void @printf (i8* @.str, i32 %4)
  %5 = add i32 %4, %4
  ;call void @printf (i8* @.str, i32 %5)
  %6 = add i32 %3, 1
  %7 = icmp eq i32 %6, 4294967295
  br i1 %7, label %8, label %2
8:
  ret i32 0
}
