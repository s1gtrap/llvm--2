@.str = global [4 x i8] c"%d\0A\00"

declare i32 @atoi(i8*)
declare i8* @calloc(i64, i64)
declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %9 = load i32, i32* %4
 %10 = icmp eq i32 %9, 2
 br i1 %10, label %11, label %16
11:
 %12 = load i8*, i8** %5
 %13 = getelementptr i8*, i8* %12, i64 1
 %14 = load i8*, i8** %13
 %15 = call i32 @atoi (i8* %14)
 br label %17
16:
 br label %17
17:
 %18 = phi i32 [%15, %11], [1, %16]
 store i32 %18, i32* %7
 %19 = load i32, i32* %7
 %20 = sext i32 %19 to i64
 %21 = call i8* @calloc (i64 %20, i64 4)
 store i8* %21, i8** %8
 store i32 0, i32* %6
 br label %22
22:
 %23 = load i32, i32* %6
 %24 = load i32, i32* %7
 %25 = icmp slt i32 %23, %24
 br i1 %25, label %26, label %37
26:
 %27 = load i32, i32* %6
 %28 = load i32, i32* %6
 %29 = mul i32 %27, %28
 %30 = load i8*, i8** %8
 %31 = load i32, i32* %6
 %32 = sext i32 %31 to i64
 %33 = getelementptr i32, i8* %30, i64 %32
 store i32 %29, i32* %33
 br label %34
34:
 %35 = load i32, i32* %6
 %36 = add i32 %35, 1
 store i32 %36, i32* %6
 br label %22
37:
 %38 = load i8*, i8** %8
 %39 = load i32, i32* %7
 %40 = sub i32 %39, 1
 %41 = sext i32 %40 to i64
 %42 = getelementptr i32, i8* %38, i64 %41
 %43 = load i32, i32* %42
 %44 = call i32 (i8*, ...) @printf (i8* @.str, i32 %43)
 ret i32 0
}
