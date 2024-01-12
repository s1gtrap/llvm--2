@.str = global [5 x i8] c"%ld\0A\00"

declare i32 @atoi(i8*)
declare i32 @printf(i8*, ...)

define i64 @fib (i64 %0) {
 %2 = alloca i64
 %3 = alloca i64
 store i64 %0, i64* %3
 %4 = load i64, i64* %3
 %5 = icmp ult i64 %4, 2
 br i1 %5, label %6, label %7
6:
 store i64 1, i64* %2
 br label %15
7:
 %8 = load i64, i64* %3
 %9 = sub i64 %8, 2
 %10 = call i64 @fib (i64 %9)
 %11 = load i64, i64* %3
 %12 = sub i64 %11, 1
 %13 = call i64 @fib (i64 %12)
 %14 = add i64 %10, %13
 store i64 %14, i64* %2
 br label %15
15:
 %16 = load i64, i64* %2
 ret i64 %16
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %7 = load i32, i32* %4
 %8 = icmp eq i32 %7, 2
 br i1 %8, label %9, label %14
9:
 %10 = load i8*, i8** %5
 %11 = getelementptr i8*, i8* %10, i64 1
 %12 = load i8*, i8** %11
 %13 = call i32 @atoi (i8* %12)
 br label %15
14:
 br label %15
15:
 %16 = phi i32 [%13, %9], [43, %14]
 store i32 %16, i32* %6
 %17 = load i32, i32* %6
 %18 = sext i32 %17 to i64
 %19 = call i64 @fib (i64 %18)
 %20 = call i32 (i8*, ...) @printf (i8* @.str, i64 %19)
 ret i32 0
}
