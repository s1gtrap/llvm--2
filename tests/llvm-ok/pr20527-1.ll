@b = global [4 x i64] [i64 1, i64 5, i64 11, i64 23]

declare void @abort()
declare void @exit(i32)

define void @f (i8* %0, i8* %1, i64 %2, i64 %3) {
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i64
 %8 = alloca i64
 %9 = alloca i64
 %10 = alloca i64
 store i8* %0, i8** %5
 store i8* %1, i8** %6
 store i64 %2, i64* %7
 store i64 %3, i64* %8
 store i64 0, i64* %10
 %11 = load i64, i64* %7
 store i64 %11, i64* %9
 br label %12
12:
 %13 = load i64, i64* %9
 %14 = load i64, i64* %8
 %15 = icmp sle i64 %13, %14
 br i1 %15, label %16, label %37
16:
 %17 = load i8*, i8** %6
 %18 = load i64, i64* %9
 %19 = add i64 %18, 1
 %20 = getelementptr i64, i8* %17, i64 %19
 %21 = load i64, i64* %20
 %22 = load i8*, i8** %6
 %23 = load i64, i64* %9
 %24 = getelementptr i64, i8* %22, i64 %23
 %25 = load i64, i64* %24
 %26 = sub i64 %21, %25
 %27 = load i64, i64* %10
 %28 = add i64 %27, %26
 store i64 %28, i64* %10
 %29 = load i64, i64* %10
 %30 = sub i64 %29, 1
 %31 = load i8*, i8** %5
 %32 = load i64, i64* %9
 %33 = getelementptr i64, i8* %31, i64 %32
 store i64 %30, i64* %33
 br label %34
34:
 %35 = load i64, i64* %9
 %36 = add i64 %35, 1
 store i64 %36, i64* %9
 br label %12
37:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [3 x i64]
 store i32 0, i32* %1
 %3 = getelementptr [3 x i64], i8* %2, i64 0, i64 0
 call void @f (i8* %3, i8* @b, i64 0, i64 2)
 %4 = getelementptr [3 x i64], i8* %2, i64 0, i64 0
 %5 = load i64, i64* %4
 %6 = icmp ne i64 %5, 3
 br i1 %6, label %15, label %7
7:
 %8 = getelementptr [3 x i64], i8* %2, i64 0, i64 1
 %9 = load i64, i64* %8
 %10 = icmp ne i64 %9, 9
 br i1 %10, label %15, label %11
11:
 %12 = getelementptr [3 x i64], i8* %2, i64 0, i64 2
 %13 = load i64, i64* %12
 %14 = icmp ne i64 %13, 21
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 call void @exit (i32 0)
 unreachable
}
