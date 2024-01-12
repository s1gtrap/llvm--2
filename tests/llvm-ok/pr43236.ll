declare void @llvm.memset.p0.i64(i8*, i8, i64, i1)
declare i32 @memcmp(i8*, i8*, i64)
declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [30 x i8]
 %3 = alloca [30 x i8]
 %4 = alloca [30 x i8]
 %5 = alloca i32
 store i32 0, i32* %1
 %6 = getelementptr [30 x i8], i8* %2, i64 0, i64 0
 call void @memset (i8* %6, i8 1, i64 30, i1 0)
 %7 = getelementptr [30 x i8], i8* %3, i64 0, i64 0
 call void @memset (i8* %7, i8 1, i64 30, i1 0)
 store i32 20, i32* %5
 br label %8
8:
 %9 = load i32, i32* %5
 %10 = add i32 %9, -1
 store i32 %10, i32* %5
 %11 = icmp sgt i32 %9, 10
 br i1 %11, label %12, label %19
12:
 %13 = load i32, i32* %5
 %14 = sext i32 %13 to i64
 %15 = getelementptr [30 x i8], i8* %2, i64 0, i64 %14
 store i8 0, i8* %15
 %16 = load i32, i32* %5
 %17 = sext i32 %16 to i64
 %18 = getelementptr [30 x i8], i8* %3, i64 0, i64 %17
 store i8 0, i8* %18
 br label %8
19:
 %20 = getelementptr [30 x i8], i8* %4, i64 0, i64 0
 call void @memset (i8* %20, i8 1, i64 30, i1 0)
 %21 = getelementptr [30 x i8], i8* %4, i64 0, i64 0
 %22 = getelementptr i8, i8* %21, i64 10
 call void @memset (i8* %22, i8 0, i64 10, i1 0)
 %23 = getelementptr [30 x i8], i8* %2, i64 0, i64 0
 %24 = getelementptr [30 x i8], i8* %4, i64 0, i64 0
 %25 = call i32 @memcmp (i8* %23, i8* %24, i64 30)
 %26 = icmp ne i32 %25, 0
 br i1 %26, label %32, label %27
27:
 %28 = getelementptr [30 x i8], i8* %3, i64 0, i64 0
 %29 = getelementptr [30 x i8], i8* %4, i64 0, i64 0
 %30 = call i32 @memcmp (i8* %28, i8* %29, i64 30)
 %31 = icmp ne i32 %30, 0
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 ret i32 0
}
