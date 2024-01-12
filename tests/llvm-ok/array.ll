@.str = global [10 x i8] c"i=%u: %x\0A\00"
@.str.1 = global [4 x i8] c"%x\0A\00"

declare i32 @printf(i8*, ...)

define i32 @my_test () {
 %1 = alloca [8 x i32]
 %2 = alloca i32
 %3 = alloca i64
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %2
 store i32 0, i32* %2
 br label %6
6:
 %7 = load i32, i32* %2
 %8 = icmp ult i32 %7, 8
 %9 = zext i1 %8 to i32
 store i32 %9, i32* %4
 %10 = load i32, i32* %4
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %13, label %12
12:
 br label %30
13:
 %14 = load i32, i32* %2
 %15 = add i32 %14, 1
 %16 = sub i32 0, %15
 %17 = load i32, i32* %2
 %18 = zext i32 %17 to i64
 %19 = getelementptr [8 x i32], i8* %1, i64 0, i64 %18
 store i32 %16, i32* %19
 %20 = load i32, i32* %2
 %21 = zext i32 %20 to i64
 %22 = getelementptr [8 x i32], i8* %1, i64 0, i64 %21
 %23 = load i32, i32* %22
 %24 = sext i32 %23 to i64
 store i64 %24, i64* %3
 %25 = load i32, i32* %2
 %26 = load i64, i64* %3
 %27 = call i32 (i8*, ...) @printf (i8* @.str, i32 %25, i64 %26)
 %28 = load i32, i32* %2
 %29 = add i32 %28, 1
 store i32 %29, i32* %2
 br label %6
30:
 %31 = getelementptr [8 x i32], i8* %1, i64 0, i64 7
 store i8* %31, i8** %5
 %32 = getelementptr [8 x i32], i8* %1, i64 0, i64 1
 %33 = load i32, i32* %32
 %34 = getelementptr [8 x i32], i8* %1, i64 0, i64 0
 %35 = load i32, i32* %34
 %36 = srem i32 %33, %35
 %37 = load i8*, i8** %5
 store i32 %36, i32* %37
 %38 = load i8*, i8** %5
 %39 = load i32, i32* %38
 %40 = sext i32 %39 to i64
 store i64 %40, i64* %3
 %41 = load i64, i64* %3
 %42 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %41)
 ret i32 0
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @my_test ()
 ret i32 0
}
