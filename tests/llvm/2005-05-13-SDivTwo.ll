@.str = global [4 x i8] c"%d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = icmp ne i32 %4, 258
 br i1 %5, label %6, label %15
6:
 %7 = load i32, i32* %2
 %8 = trunc i32 %7 to i8
 %9 = sext i8 %8 to i32
 %10 = sdiv i32 %9, 2
 %11 = call i32 (i8*, ...) @printf (i8* @.str, i32 %10)
 br label %12
12:
 %13 = load i32, i32* %2
 %14 = add i32 %13, 1
 store i32 %14, i32* %2
 br label %3
15:
 ret i32 0
}
