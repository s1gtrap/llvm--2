%struct.mp_int = type { i32, i32, i32, i8* }

@__const.main.i = global %struct.mp_int {i32 2, i32 0, i32 -1, i8* null}

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define i32 @mytest (i8* %0, i64 %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i64
 store i8* %0, i8** %4
 store i64 %1, i64* %5
 %6 = load i8*, i8** %4
 %7 = getelementptr %struct.mp_int, i8* %6, i32 0, i32 2
 %8 = load i32, i32* %7
 %9 = icmp eq i32 %8, 1
 br i1 %9, label %10, label %11
10:
 store i32 -1, i32* %3
 br label %36
11:
 %12 = load i8*, i8** %4
 %13 = getelementptr %struct.mp_int, i8* %12, i32 0, i32 0
 %14 = load i32, i32* %13
 %15 = icmp sgt i32 %14, 1
 br i1 %15, label %16, label %17
16:
 store i32 1, i32* %3
 br label %36
17:
 %18 = load i8*, i8** %4
 %19 = getelementptr %struct.mp_int, i8* %18, i32 0, i32 3
 %20 = load i8*, i8** %19
 %21 = getelementptr i64, i8* %20, i64 0
 %22 = load i64, i64* %21
 %23 = load i64, i64* %5
 %24 = icmp ugt i64 %22, %23
 br i1 %24, label %25, label %26
25:
 store i32 1, i32* %3
 br label %36
26:
 %27 = load i8*, i8** %4
 %28 = getelementptr %struct.mp_int, i8* %27, i32 0, i32 3
 %29 = load i8*, i8** %28
 %30 = getelementptr i64, i8* %29, i64 0
 %31 = load i64, i64* %30
 %32 = load i64, i64* %5
 %33 = icmp ult i64 %31, %32
 br i1 %33, label %34, label %35
34:
 store i32 -1, i32* %3
 br label %36
35:
 store i32 0, i32* %3
 br label %36
36:
 %37 = load i32, i32* %3
 ret i32 %37
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.mp_int
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.i, i64 24, i1 0)
 %3 = call i32 @mytest (i8* %2, i64 0)
 %4 = icmp ne i32 %3, 1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret i32 0
}
