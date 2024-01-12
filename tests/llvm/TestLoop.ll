@.str = global [4 x i8] c"%d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %4
 %6 = call i32 (i8*, ...) @printf (i8* @.str, i32 %5)
 %7 = load i32, i32* %4
 ret i32 %7
}

define i32 @main (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca [4 x i32]
 store i32 0, i32* %2
 store i32 %0, i32* %3
 store i32 3, i32* %4
 br label %6
6:
 %7 = load i32, i32* %4
 %8 = icmp sge i32 %7, 0
 br i1 %8, label %9, label %24
9:
 %10 = load i32, i32* %3
 %11 = sub i32 %10, 1
 %12 = load i32, i32* %3
 %13 = mul i32 %12, 4
 %14 = load i32, i32* %4
 %15 = add i32 %13, %14
 %16 = add i32 %15, 1
 %17 = call i32 @foo (i32 %11, i32 %16)
 %18 = load i32, i32* %4
 %19 = sext i32 %18 to i64
 %20 = getelementptr [4 x i32], i8* %5, i64 0, i64 %19
 store i32 %17, i32* %20
 br label %21
21:
 %22 = load i32, i32* %4
 %23 = add i32 %22, -1
 store i32 %23, i32* %4
 br label %6
24:
 store i32 0, i32* %4
 br label %25
25:
 %26 = load i32, i32* %4
 %27 = icmp slt i32 %26, 4
 br i1 %27, label %28, label %37
28:
 %29 = load i32, i32* %4
 %30 = sext i32 %29 to i64
 %31 = getelementptr [4 x i32], i8* %5, i64 0, i64 %30
 %32 = load i32, i32* %31
 %33 = call i32 @foo (i32 0, i32 %32)
 br label %34
34:
 %35 = load i32, i32* %4
 %36 = add i32 %35, 1
 store i32 %36, i32* %4
 br label %25
37:
 ret i32 0
}
