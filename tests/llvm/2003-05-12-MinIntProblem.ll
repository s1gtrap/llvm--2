@.str = global [9 x i8] c"success\0A\00"

declare i32 @printf(i8*, ...)

define void @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = add i32 %3, 1
 %5 = icmp slt i32 %4, 0
 br i1 %5, label %6, label %8
6:
 %7 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %8
8:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i32 -2147483648)
 ret i32 0
}
