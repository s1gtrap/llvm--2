%struct.baz = type { [17 x i8], [3 x i8], i32, i32 }

@.str = global [4 x i8] c"abc\00"
@.str.1 = global [18 x i8] c"01234567890123456\00"

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @llvm.memset.p0.i64(i8*, i8, i64, i1)
declare void @abort()
declare void @exit(i32)

define void @foo (i8* %0, i32 %1, i32 %2) {
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i32
 store i8* %0, i8** %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i8*, i8** %4
 %8 = getelementptr %struct.baz, i8* %7, i32 0, i32 1
 %9 = getelementptr [3 x i8], i8* %8, i64 0, i64 0
 call void @memcpy (i8* %9, i8* @.str, i64 3, i1 0)
 %10 = load i32, i32* %5
 %11 = load i8*, i8** %4
 %12 = getelementptr %struct.baz, i8* %11, i32 0, i32 2
 store i32 %10, i32* %12
 %13 = load i32, i32* %6
 %14 = load i8*, i8** %4
 %15 = getelementptr %struct.baz, i8* %14, i32 0, i32 3
 store i32 %13, i32* %15
 ret void
}

define void @bar (i8* %0, i32 %1, i32 %2) {
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i8*
 %8 = alloca i8*
 store i8* %0, i8** %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %9 = load i8*, i8** %4
 store i8* %9, i8** %7
 %10 = load i8*, i8** %7
 call void @memset (i8* %10, i8 0, i64 28, i1 0)
 %11 = load i8*, i8** %7
 store i8* %11, i8** %8
 %12 = load i8*, i8** %8
 %13 = load i8*, i8** %4
 %14 = getelementptr %struct.baz, i8* %13, i32 0, i32 0
 %15 = getelementptr [17 x i8], i8* %14, i64 0, i64 0
 call void @memcpy (i8* %15, i8* @.str.1, i64 17, i1 0)
 %16 = load i8*, i8** %4
 %17 = getelementptr %struct.baz, i8* %16, i32 0, i32 1
 %18 = getelementptr [3 x i8], i8* %17, i64 0, i64 0
 call void @memcpy (i8* %18, i8* @.str, i64 3, i1 0)
 %19 = load i32, i32* %5
 %20 = load i8*, i8** %4
 %21 = getelementptr %struct.baz, i8* %20, i32 0, i32 2
 store i32 %19, i32* %21
 %22 = load i32, i32* %6
 %23 = load i8*, i8** %4
 %24 = getelementptr %struct.baz, i8* %23, i32 0, i32 3
 store i32 %22, i32* %24
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.baz
 store i32 0, i32* %1
 call void @foo (i8* %2, i32 71, i32 18)
 %3 = getelementptr %struct.baz, i8* %2, i32 0, i32 2
 %4 = load i32, i32* %3
 %5 = icmp ne i32 %4, 71
 br i1 %5, label %10, label %6
6:
 %7 = getelementptr %struct.baz, i8* %2, i32 0, i32 3
 %8 = load i32, i32* %7
 %9 = icmp ne i32 %8, 18
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 call void @bar (i8* %2, i32 59, i32 26)
 %12 = getelementptr %struct.baz, i8* %2, i32 0, i32 2
 %13 = load i32, i32* %12
 %14 = icmp ne i32 %13, 59
 br i1 %14, label %19, label %15
15:
 %16 = getelementptr %struct.baz, i8* %2, i32 0, i32 3
 %17 = load i32, i32* %16
 %18 = icmp ne i32 %17, 26
 br i1 %18, label %19, label %20
19:
 call void @abort ()
 unreachable
20:
 call void @exit (i32 0)
 unreachable
}
