%struct.st = type { i32 }

@__const.main._1 = global [2 x %struct.st] [%struct.st {i32 2}, %struct.st {i32 1}]

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define i32 @foo (i8* %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
 %9 = alloca i32
 %10 = alloca i32
 store i8* %0, i8** %4
 store i32 %1, i32* %5
 store i32 1, i32* %6
 %11 = load i32, i32* %5
 store i32 %11, i32* %7
 %12 = load i8*, i8** %4
 store i8* %12, i8** %8
 %13 = load i8*, i8** %4
 %14 = getelementptr %struct.st, i8* %13, i32 0, i32 0
 %15 = load i32, i32* %14
 store i32 %15, i32* %9
 br label %16
16:
 %17 = load i32, i32* %7
 %18 = add i32 %17, -1
 store i32 %18, i32* %7
 %19 = icmp ne i32 %17, 0
 br i1 %19, label %20, label %37
20:
 %21 = load i8*, i8** %8
 %22 = getelementptr %struct.st, i8* %21, i32 0, i32 0
 %23 = load i32, i32* %22
 store i32 %23, i32* %10
 %24 = load i32, i32* %6
 %25 = icmp ne i32 %24, 0
 br i1 %25, label %26, label %27
26:
 store i32 0, i32* %6
 br label %33
27:
 %28 = load i32, i32* %10
 %29 = load i32, i32* %9
 %30 = icmp sge i32 %28, %29
 br i1 %30, label %31, label %32
31:
 store i32 1, i32* %3
 br label %38
32:
 br label %33
33:
 %34 = load i32, i32* %10
 store i32 %34, i32* %9
 %35 = load i8*, i8** %8
 %36 = getelementptr %struct.st, i8* %35, i32 1
 store i8* %36, i8** %8
 br label %16
37:
 store i32 0, i32* %3
 br label %38
38:
 %39 = load i32, i32* %3
 ret i32 %39
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [2 x %struct.st]
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main._1, i64 8, i1 0)
 %3 = getelementptr [2 x %struct.st], i8* %2, i64 0, i64 0
 %4 = call i32 @foo (i8* %3, i32 2)
 %5 = icmp ne i32 %4, 0
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}
