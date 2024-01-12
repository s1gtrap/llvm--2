declare void @llvm.memset.p0.i64(i8*, i8, i64, i1)
declare void @abort()

define void @f (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 call void @memset (i8* %3, i8 0, i64 15, i1 0)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca [15 x i8]
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %4
4:
 %5 = load i32, i32* %2
 %6 = sext i32 %5 to i64
 %7 = icmp ult i64 %6, 15
 br i1 %7, label %8, label %17
8:
 %9 = load i32, i32* %2
 %10 = trunc i32 %9 to i8
 %11 = load i32, i32* %2
 %12 = sext i32 %11 to i64
 %13 = getelementptr [15 x i8], i8* %3, i64 0, i64 %12
 store i8 %10, i8* %13
 br label %14
14:
 %15 = load i32, i32* %2
 %16 = add i32 %15, 1
 store i32 %16, i32* %2
 br label %4
17:
 %18 = getelementptr [15 x i8], i8* %3, i64 0, i64 0
 call void @f (i8* %18)
 store i32 0, i32* %2
 br label %19
19:
 %20 = load i32, i32* %2
 %21 = sext i32 %20 to i64
 %22 = icmp ult i64 %21, 15
 br i1 %22, label %23, label %35
23:
 %24 = load i32, i32* %2
 %25 = sext i32 %24 to i64
 %26 = getelementptr [15 x i8], i8* %3, i64 0, i64 %25
 %27 = load i8, i8* %26
 %28 = sext i8 %27 to i32
 %29 = icmp ne i32 0, %28
 br i1 %29, label %30, label %31
30:
 call void @abort ()
 unreachable
31:
 br label %32
32:
 %33 = load i32, i32* %2
 %34 = add i32 %33, 1
 store i32 %34, i32* %2
 br label %19
35:
 ret i32 0
}
