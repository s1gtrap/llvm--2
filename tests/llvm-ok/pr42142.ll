@__const.sort.end = global [2 x i32] [i32 10, i32 10]

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define i32 @sort (i32 %0) {
 %2 = alloca i32
 %3 = alloca [2 x i32]
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %2
 call void @memcpy (i8* %3, i8* @__const.sort.end, i64 8, i1 0)
 store i32 0, i32* %4
 br label %6
6:
 %7 = load i32, i32* %4
 %8 = icmp slt i32 %7, 2
 br i1 %8, label %9, label %29
9:
 %10 = load i32, i32* %4
 %11 = sext i32 %10 to i64
 %12 = getelementptr [2 x i32], i8* %3, i64 0, i64 %11
 %13 = load i32, i32* %12
 store i32 %13, i32* %5
 %14 = load i32, i32* %2
 %15 = load i32, i32* %5
 %16 = icmp slt i32 %14, %15
 br i1 %16, label %17, label %27
17:
 %18 = load i32, i32* %4
 %19 = add i32 %18, 1
 %20 = sext i32 %19 to i64
 %21 = getelementptr [2 x i32], i8* %3, i64 0, i64 %20
 store i32 1, i32* %21
 %22 = load i32, i32* %4
 %23 = sext i32 %22 to i64
 %24 = getelementptr [2 x i32], i8* %3, i64 0, i64 %23
 store i32 10, i32* %24
 %25 = load i32, i32* %4
 %26 = add i32 %25, 1
 store i32 %26, i32* %4
 br label %28
27:
 br label %29
28:
 br label %6
29:
 %30 = load i32, i32* %4
 ret i32 %30
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @sort (i32 5)
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
