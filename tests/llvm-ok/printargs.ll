@.str = global [23 x i8] c"#Args = %d. They are:\0A\00"

declare i32 @printf(i8*, ...)
declare i32 @puts(i8*)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %7 = load i32, i32* %4
 %8 = sub i32 %7, 1
 %9 = call i32 (i8*, ...) @printf (i8* @.str, i32 %8)
 store i32 1, i32* %6
 br label %10
10:
 %11 = load i32, i32* %6
 %12 = load i32, i32* %4
 %13 = icmp slt i32 %11, %12
 br i1 %13, label %14, label %24
14:
 %15 = load i8*, i8** %5
 %16 = load i32, i32* %6
 %17 = sext i32 %16 to i64
 %18 = getelementptr i8*, i8* %15, i64 %17
 %19 = load i8*, i8** %18
 %20 = call i32 @puts (i8* %19)
 br label %21
21:
 %22 = load i32, i32* %6
 %23 = add i32 %22, 1
 store i32 %23, i32* %6
 br label %10
24:
 ret i32 0
}
