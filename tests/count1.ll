@.str = global [5 x i8] c"%d!\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = icmp slt i32 %0, 1
 br i1 %3, label %4, label %5
4:
 ret i32 0
5:
 %6 = phi i32 [%8, %5], [1, %2]
 %7 = call i32 (i8*, ...) @printf (i8* @.str, i32 %6)
 %8 = add i32 %6, 1
 %9 = icmp eq i32 %6, %0
 br i1 %9, label %4, label %5
}
