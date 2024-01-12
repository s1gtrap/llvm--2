%struct.C = type { [1 x %struct.B], i32, i32 }
%struct.B = type { i32, i32, i32, i32, i32 }
%struct.A = type { i16, i64 }

declare void @memset(i8*, i8, i64, i1)

define i32 @bar (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i64
 %8 = alloca i32
 %9 = alloca i64
 %10 = alloca i64
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %11 = load i8*, i8** %3
 %12 = getelementptr %struct.C, i8* %11, i32 0, i32 2
 %13 = load i32, i32* %12
 store i32 %13, i32* %5
 %14 = load i8*, i8** %4
 %15 = getelementptr %struct.A, i8* %14, i32 0, i32 0
 %16 = load i16, i16* %15
 %17 = zext i16 %16 to i32
 %18 = ashr i32 %17, 9
 store i32 %18, i32* %6
 %19 = load i8*, i8** %4
 %20 = getelementptr %struct.A, i8* %19, i32 0, i32 1
 %21 = load i64, i64* %20
 store i64 %21, i64* %7
 %22 = load i32, i32* %5
 store i32 %22, i32* %8
 %23 = load i64, i64* %7
 %24 = load i8*, i8** %3
 %25 = getelementptr %struct.C, i8* %24, i32 0, i32 0
 %26 = load i32, i32* %8
 %27 = sext i32 %26 to i64
 %28 = getelementptr [1 x %struct.B], i8* %25, i64 0, i64 %27
 %29 = getelementptr %struct.B, i8* %28, i32 0, i32 3
 %30 = load i32, i32* %29
 %31 = sext i32 %30 to i64
 %32 = sub i64 %23, %31
 %33 = trunc i64 %32 to i32
 %34 = call i32 @foo (i32 %33)
 %35 = sext i32 %34 to i64
 store i64 %35, i64* %10
 br label %36
36:
 %37 = load i32, i32* %8
 %38 = icmp sle i32 %37, 0
 br i1 %38, label %39, label %43
39:
 %40 = load i8*, i8** %3
 %41 = getelementptr %struct.C, i8* %40, i32 0, i32 1
 %42 = load i32, i32* %41
 store i32 %42, i32* %8
 br label %43
43:
 %44 = load i32, i32* %8
 %45 = add i32 %44, -1
 store i32 %45, i32* %8
 %46 = load i64, i64* %7
 %47 = load i8*, i8** %3
 %48 = getelementptr %struct.C, i8* %47, i32 0, i32 0
 %49 = load i32, i32* %8
 %50 = sext i32 %49 to i64
 %51 = getelementptr [1 x %struct.B], i8* %48, i64 0, i64 %50
 %52 = getelementptr %struct.B, i8* %51, i32 0, i32 3
 %53 = load i32, i32* %52
 %54 = sext i32 %53 to i64
 %55 = sub i64 %46, %54
 %56 = trunc i64 %55 to i32
 %57 = call i32 @foo (i32 %56)
 %58 = sext i32 %57 to i64
 store i64 %58, i64* %9
 %59 = load i64, i64* %9
 %60 = load i64, i64* %10
 %61 = icmp ult i64 %59, %60
 br i1 %61, label %62, label %64
62:
 %63 = load i32, i32* %8
 store i32 %63, i32* %5
 br label %64
64:
 br label %65
65:
 %66 = load i32, i32* %8
 %67 = load i8*, i8** %3
 %68 = getelementptr %struct.C, i8* %67, i32 0, i32 2
 %69 = load i32, i32* %68
 %70 = icmp ne i32 %66, %69
 br i1 %70, label %36, label %71
71:
 %72 = load i64, i64* %7
 %73 = load i32, i32* %6
 %74 = sext i32 %73 to i64
 %75 = add i64 %72, %74
 %76 = trunc i64 %75 to i32
 %77 = load i8*, i8** %3
 %78 = getelementptr %struct.C, i8* %77, i32 0, i32 0
 %79 = load i32, i32* %5
 %80 = sext i32 %79 to i64
 %81 = getelementptr [1 x %struct.B], i8* %78, i64 0, i64 %80
 %82 = getelementptr %struct.B, i8* %81, i32 0, i32 3
 store i32 %76, i32* %82
 %83 = load i32, i32* %5
 ret i32 %83
}

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp slt i32 %3, 0
 br i1 %4, label %5, label %8
5:
 %6 = load i32, i32* %2
 %7 = sub i32 0, %6
 br label %10
8:
 %9 = load i32, i32* %2
 br label %10
10:
 %11 = phi i32 [%7, %5], [%9, %8]
 ret i32 %11
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.A
 %3 = alloca %struct.C
 %4 = alloca i32
 store i32 0, i32* %1
 %5 = getelementptr %struct.A, i8* %2, i32 0, i32 0
 store i16 512, i16* %5
 %6 = getelementptr %struct.A, i8* %2, i32 0, i32 1
 store i64 4242, i64* %6
 call void @memset (i8* %3, i8 0, i64 28, i1 0)
 %7 = getelementptr %struct.C, i8* %3, i32 0, i32 0
 %8 = getelementptr [1 x %struct.B], i8* %7, i64 0, i64 0
 %9 = getelementptr %struct.B, i8* %8, i32 0, i32 2
 store i32 424242, i32* %9
 %10 = getelementptr %struct.C, i8* %3, i32 0, i32 1
 store i32 1, i32* %10
 %11 = call i32 @bar (i8* %3, i8* %2)
 store i32 %11, i32* %4
 ret i32 0
}
