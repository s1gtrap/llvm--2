%struct.large = type { i32, [9 x i32] }

declare void @abort()
declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca %struct.large
 %8 = alloca %struct.large
 %9 = alloca %struct.large
 %10 = alloca %struct.large
 store i32 0, i32* %1
 store i32 2, i32* %3
 %11 = load i32, i32* %3
 store i32 %11, i32* %4
 %12 = load i32, i32* %4
 store i32 1, i32* %5
 %13 = load i32, i32* %5
 store i32 %13, i32* %6
 %14 = load i32, i32* %6
 %15 = sub i32 %12, %14
 store i32 %15, i32* %2
 %16 = load i32, i32* %2
 %17 = icmp ne i32 %16, 1
 br i1 %17, label %18, label %19
18:
 call void @abort ()
 unreachable
19:
 %20 = getelementptr %struct.large, i8* %8, i32 0, i32 0
 store i32 2, i32* %20
 call void @memcpy (i8* %7, i8* %8, i64 40, i1 0)
 %21 = getelementptr %struct.large, i8* %7, i32 0, i32 0
 %22 = load i32, i32* %21
 %23 = getelementptr %struct.large, i8* %10, i32 0, i32 0
 store i32 1, i32* %23
 call void @memcpy (i8* %9, i8* %10, i64 40, i1 0)
 %24 = getelementptr %struct.large, i8* %9, i32 0, i32 0
 %25 = load i32, i32* %24
 %26 = sub i32 %22, %25
 store i32 %26, i32* %2
 %27 = load i32, i32* %2
 %28 = icmp ne i32 %27, 1
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 call void @exit (i32 0)
 unreachable
}
