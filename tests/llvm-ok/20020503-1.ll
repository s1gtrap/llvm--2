declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [128 x i8]
 %3 = alloca i8*
 store i32 0, i32* %1
 %4 = getelementptr [128 x i8], i8* %2, i64 0, i64 0
 %5 = call i8* @inttostr (i64 -1, i8* %4)
 store i8* %5, i8** %3
 %6 = load i8*, i8** %3
 %7 = load i8, i8* %6
 %8 = sext i8 %7 to i32
 %9 = icmp ne i32 %8, 45
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret i32 0
}

define i8* @inttostr (i64 %0, i8* %1) {
 %3 = alloca i64
 %4 = alloca i8*
 %5 = alloca i64
 %6 = alloca i8*
 store i64 %0, i64* %3
 store i8* %1, i8** %4
 %7 = load i64, i64* %3
 store i64 %7, i64* %5
 %8 = load i8*, i8** %4
 %9 = getelementptr i8, i8* %8, i64 127
 store i8* %9, i8** %6
 %10 = load i8*, i8** %6
 store i8 0, i8* %10
 %11 = load i64, i64* %3
 %12 = icmp slt i64 %11, 0
 br i1 %12, label %13, label %16
13:
 %14 = load i64, i64* %5
 %15 = sub i64 0, %14
 store i64 %15, i64* %5
 br label %16
16:
 br label %17
17:
 %18 = load i64, i64* %5
 %19 = urem i64 %18, 10
 %20 = add i64 48, %19
 %21 = trunc i64 %20 to i8
 %22 = load i8*, i8** %6
 %23 = getelementptr i8, i8* %22, i32 -1
 store i8* %23, i8** %6
 store i8 %21, i8* %23
 br label %24
24:
 %25 = load i64, i64* %5
 %26 = udiv i64 %25, 10
 store i64 %26, i64* %5
 %27 = icmp ne i64 %26, 0
 br i1 %27, label %17, label %28
28:
 %29 = load i64, i64* %3
 %30 = icmp slt i64 %29, 0
 br i1 %30, label %31, label %34
31:
 %32 = load i8*, i8** %6
 %33 = getelementptr i8, i8* %32, i32 -1
 store i8* %33, i8** %6
 store i8 45, i8* %33
 br label %34
34:
 %35 = load i8*, i8** %6
 ret i8* %35
}
