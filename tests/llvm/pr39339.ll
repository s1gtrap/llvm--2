%struct.D = type { i32 }
%struct.E = type { i64, i64, %struct.C }
%struct.C = type { i32, %struct.D }
%struct.B = type { i8*, i8 }
%struct.A = type { i8*, i32 }

@__const.main.e = global { i64, i64, { i32, { i8, i8, i8, i8 } } } {i64 5, i64 0, { i32, { i8, i8, i8, i8 } } {i32 6, { i8, i8, i8, i8 } {i8 -1, i8 -1, i8 127, i8 85}}}

declare void @memcpy(i8*, i8*, i64, i1)
declare void @memset(i8*, i8, i64, i1)
declare i32 @memcmp(i8*, i8*, i64)
declare void @abort()

define void @foo (i8* %0, i32 %1, i32 %2, i8* %3) {
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
 %9 = alloca %struct.D
 %10 = alloca i64
 %11 = alloca i32
 store i8* %0, i8** %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 store i8* %3, i8** %8
 %12 = load i8*, i8** %5
 %13 = getelementptr %struct.E, i8* %12, i32 0, i32 1
 %14 = load i64, i64* %13
 store i64 %14, i64* %10
 %15 = load i8*, i8** %5
 %16 = getelementptr %struct.E, i8* %15, i32 0, i32 2
 %17 = getelementptr %struct.C, i8* %16, i32 0, i32 1
 call void @memcpy (i8* %9, i8* %17, i64 4, i1 0)
 %18 = load i32, i32* %7
 %19 = load i32, i32* %9
 %20 = and i32 %18, 15
 %21 = and i32 %19, -16
 %22 = or i32 %21, %20
 store i32 %22, i32* %9
 %23 = load i32, i32* %6
 %24 = load i8*, i8** %8
 %25 = getelementptr %struct.B, i8* %24, i32 0, i32 0
 %26 = load i8*, i8** %25
 %27 = getelementptr %struct.A, i8* %26, i32 0, i32 0
 %28 = load i8*, i8** %27
 %29 = load i64, i64* %10
 %30 = getelementptr %struct.C, i8* %28, i64 %29
 %31 = getelementptr %struct.C, i8* %30, i32 0, i32 0
 store i32 %23, i32* %31
 %32 = load i8*, i8** %8
 %33 = getelementptr %struct.B, i8* %32, i32 0, i32 0
 %34 = load i8*, i8** %33
 %35 = getelementptr %struct.A, i8* %34, i32 0, i32 0
 %36 = load i8*, i8** %35
 %37 = load i64, i64* %10
 %38 = getelementptr %struct.C, i8* %36, i64 %37
 %39 = getelementptr %struct.C, i8* %38, i32 0, i32 1
 call void @memcpy (i8* %39, i8* %9, i64 4, i1 0)
 %40 = load i64, i64* %10
 %41 = add i64 %40, 1
 store i64 %41, i64* %10
 %42 = load i32, i32* %9
 %43 = and i32 %42, -4194305
 %44 = or i32 %43, 4194304
 store i32 %44, i32* %9
 store i32 1, i32* %11
 br label %45
45:
 %46 = load i32, i32* %11
 %47 = load i32, i32* %7
 %48 = icmp slt i32 %46, %47
 br i1 %48, label %49, label %72
49:
 %50 = load i32, i32* %6
 %51 = load i8*, i8** %8
 %52 = getelementptr %struct.B, i8* %51, i32 0, i32 0
 %53 = load i8*, i8** %52
 %54 = getelementptr %struct.A, i8* %53, i32 0, i32 0
 %55 = load i8*, i8** %54
 %56 = load i64, i64* %10
 %57 = getelementptr %struct.C, i8* %55, i64 %56
 %58 = getelementptr %struct.C, i8* %57, i32 0, i32 0
 store i32 %50, i32* %58
 %59 = load i8*, i8** %8
 %60 = getelementptr %struct.B, i8* %59, i32 0, i32 0
 %61 = load i8*, i8** %60
 %62 = getelementptr %struct.A, i8* %61, i32 0, i32 0
 %63 = load i8*, i8** %62
 %64 = load i64, i64* %10
 %65 = getelementptr %struct.C, i8* %63, i64 %64
 %66 = getelementptr %struct.C, i8* %65, i32 0, i32 1
 call void @memcpy (i8* %66, i8* %9, i64 4, i1 0)
 %67 = load i64, i64* %10
 %68 = add i64 %67, 1
 store i64 %68, i64* %10
 br label %69
69:
 %70 = load i32, i32* %11
 %71 = add i32 %70, 1
 store i32 %71, i32* %11
 br label %45
72:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.E
 %3 = alloca [4 x %struct.C]
 %4 = alloca %struct.A
 %5 = alloca %struct.B
 %6 = alloca %struct.D
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.e, i64 24, i1 0)
 %7 = getelementptr %struct.A, i8* %4, i32 0, i32 0
 %8 = getelementptr [4 x %struct.C], i8* %3, i64 0, i64 0
 store i8* %8, i8** %7
 %9 = getelementptr %struct.A, i8* %4, i32 0, i32 1
 store i32 4, i32* %9
 %10 = getelementptr %struct.B, i8* %5, i32 0, i32 0
 store i8* %4, i8** %10
 %11 = getelementptr %struct.B, i8* %5, i32 0, i32 1
 %12 = load i8, i8* %11
 %13 = and i8 %12, -2
 %14 = or i8 %13, 1
 store i8 %14, i8* %11
 call void @memset (i8* %3, i8 0, i64 32, i1 0)
 call void @foo (i8* %2, i32 65, i32 2, i8* %5)
 %15 = getelementptr %struct.E, i8* %2, i32 0, i32 2
 %16 = getelementptr %struct.C, i8* %15, i32 0, i32 1
 call void @memcpy (i8* %6, i8* %16, i64 4, i1 0)
 %17 = load i32, i32* %6
 %18 = and i32 %17, -16
 %19 = or i32 %18, 2
 store i32 %19, i32* %6
 %20 = getelementptr [4 x %struct.C], i8* %3, i64 0, i64 0
 %21 = getelementptr %struct.C, i8* %20, i32 0, i32 1
 %22 = call i32 @memcmp (i8* %6, i8* %21, i64 4)
 %23 = icmp ne i32 %22, 0
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 %26 = load i32, i32* %6
 %27 = and i32 %26, -4194305
 %28 = or i32 %27, 4194304
 store i32 %28, i32* %6
 %29 = getelementptr [4 x %struct.C], i8* %3, i64 0, i64 1
 %30 = getelementptr %struct.C, i8* %29, i32 0, i32 1
 %31 = call i32 @memcmp (i8* %6, i8* %30, i64 4)
 %32 = icmp ne i32 %31, 0
 br i1 %32, label %33, label %34
33:
 call void @abort ()
 unreachable
34:
 ret i32 0
}
