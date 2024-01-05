@.str = global [5 x i8] c"%d!\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 1, i32* %6
 br label %7
7:
 %8 = load i32, i32* %6
 %9 = load i32, i32* %4
 %10 = icmp sle i32 %8, %9
 br i1 %10, label %11, label %17
11:
 %12 = load i32, i32* %6
 %13 = call i32 (i8*, ...) @printf (i8* @.str, i32 %12)
 br label %14
14:
 %15 = load i32, i32* %6
 %16 = add i32 %15, 1
 store i32 %16, i32* %6
 br label %7
17:
 ret i32 0
}
