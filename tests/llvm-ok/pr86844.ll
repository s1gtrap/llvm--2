@__const.main.a = global [2 x i32] [i32 -1, i32 0]

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define void @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 store i32 0, i32* %3
 %4 = load i8*, i8** %2
 %5 = getelementptr i8, i8* %4, i64 3
 store i8 1, i8* %5
 %6 = load i8*, i8** %2
 %7 = getelementptr i8, i8* %6, i64 1
 store i8 2, i8* %7
 %8 = load i8*, i8** %2
 %9 = getelementptr i8, i8* %8, i64 6
 %10 = load i8, i8* %9
 %11 = load i8*, i8** %2
 %12 = getelementptr i8, i8* %11, i64 2
 store i8 %10, i8* %12
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [2 x i32]
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.a, i64 8, i1 0)
 %3 = getelementptr [2 x i32], i8* %2, i64 0, i64 0
 %4 = getelementptr i8, i8* %3, i64 6
 store i8 3, i8* %4
 %5 = getelementptr [2 x i32], i8* %2, i64 0, i64 0
 call void @foo (i8* %5)
 %6 = getelementptr [2 x i32], i8* %2, i64 0, i64 0
 %7 = getelementptr i8, i8* %6, i64 0
 %8 = load i8, i8* %7
 %9 = sext i8 %8 to i32
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %29, label %11
11:
 %12 = getelementptr [2 x i32], i8* %2, i64 0, i64 0
 %13 = getelementptr i8, i8* %12, i64 1
 %14 = load i8, i8* %13
 %15 = sext i8 %14 to i32
 %16 = icmp ne i32 %15, 2
 br i1 %16, label %29, label %17
17:
 %18 = getelementptr [2 x i32], i8* %2, i64 0, i64 0
 %19 = getelementptr i8, i8* %18, i64 2
 %20 = load i8, i8* %19
 %21 = sext i8 %20 to i32
 %22 = icmp ne i32 %21, 3
 br i1 %22, label %29, label %23
23:
 %24 = getelementptr [2 x i32], i8* %2, i64 0, i64 0
 %25 = getelementptr i8, i8* %24, i64 3
 %26 = load i8, i8* %25
 %27 = sext i8 %26 to i32
 %28 = icmp ne i32 %27, 1
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 ret i32 0
}
