%struct.T = type { i16, i16, i16, i16 }

@__const.main.t = global %struct.T {i16 1, i16 515, i16 1029, i16 1543}

declare void @memcpy(i8*, i8*, i64, i1)
declare void @abort()

define void @foo (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i32
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 store i32 0, i32* %5
 br label %6
6:
 %7 = load i32, i32* %5
 %8 = load i32, i32* %3
 %9 = icmp slt i32 %7, %8
 br i1 %9, label %10, label %114
10:
 %11 = load i8*, i8** %4
 %12 = load i32, i32* %5
 %13 = sext i32 %12 to i64
 %14 = getelementptr %struct.T, i8* %11, i64 %13
 %15 = getelementptr %struct.T, i8* %14, i32 0, i32 0
 %16 = load i16, i16* %15
 %17 = zext i16 %16 to i32
 %18 = ashr i32 %17, 8
 %19 = and i32 255, %18
 %20 = load i8*, i8** %4
 %21 = load i32, i32* %5
 %22 = sext i32 %21 to i64
 %23 = getelementptr %struct.T, i8* %20, i64 %22
 %24 = getelementptr %struct.T, i8* %23, i32 0, i32 0
 %25 = load i16, i16* %24
 %26 = zext i16 %25 to i32
 %27 = shl i32 %26, 8
 %28 = and i32 65280, %27
 %29 = or i32 %19, %28
 %30 = trunc i32 %29 to i16
 %31 = load i8*, i8** %4
 %32 = load i32, i32* %5
 %33 = sext i32 %32 to i64
 %34 = getelementptr %struct.T, i8* %31, i64 %33
 %35 = getelementptr %struct.T, i8* %34, i32 0, i32 0
 store i16 %30, i16* %35
 %36 = load i8*, i8** %4
 %37 = load i32, i32* %5
 %38 = sext i32 %37 to i64
 %39 = getelementptr %struct.T, i8* %36, i64 %38
 %40 = getelementptr %struct.T, i8* %39, i32 0, i32 1
 %41 = load i16, i16* %40
 %42 = zext i16 %41 to i32
 %43 = ashr i32 %42, 8
 %44 = and i32 255, %43
 %45 = load i8*, i8** %4
 %46 = load i32, i32* %5
 %47 = sext i32 %46 to i64
 %48 = getelementptr %struct.T, i8* %45, i64 %47
 %49 = getelementptr %struct.T, i8* %48, i32 0, i32 1
 %50 = load i16, i16* %49
 %51 = zext i16 %50 to i32
 %52 = shl i32 %51, 8
 %53 = and i32 65280, %52
 %54 = or i32 %44, %53
 %55 = trunc i32 %54 to i16
 %56 = load i8*, i8** %4
 %57 = load i32, i32* %5
 %58 = sext i32 %57 to i64
 %59 = getelementptr %struct.T, i8* %56, i64 %58
 %60 = getelementptr %struct.T, i8* %59, i32 0, i32 1
 store i16 %55, i16* %60
 %61 = load i8*, i8** %4
 %62 = load i32, i32* %5
 %63 = sext i32 %62 to i64
 %64 = getelementptr %struct.T, i8* %61, i64 %63
 %65 = getelementptr %struct.T, i8* %64, i32 0, i32 2
 %66 = load i16, i16* %65
 %67 = zext i16 %66 to i32
 %68 = ashr i32 %67, 8
 %69 = and i32 255, %68
 %70 = load i8*, i8** %4
 %71 = load i32, i32* %5
 %72 = sext i32 %71 to i64
 %73 = getelementptr %struct.T, i8* %70, i64 %72
 %74 = getelementptr %struct.T, i8* %73, i32 0, i32 2
 %75 = load i16, i16* %74
 %76 = zext i16 %75 to i32
 %77 = shl i32 %76, 8
 %78 = and i32 65280, %77
 %79 = or i32 %69, %78
 %80 = trunc i32 %79 to i16
 %81 = load i8*, i8** %4
 %82 = load i32, i32* %5
 %83 = sext i32 %82 to i64
 %84 = getelementptr %struct.T, i8* %81, i64 %83
 %85 = getelementptr %struct.T, i8* %84, i32 0, i32 2
 store i16 %80, i16* %85
 %86 = load i8*, i8** %4
 %87 = load i32, i32* %5
 %88 = sext i32 %87 to i64
 %89 = getelementptr %struct.T, i8* %86, i64 %88
 %90 = getelementptr %struct.T, i8* %89, i32 0, i32 3
 %91 = load i16, i16* %90
 %92 = zext i16 %91 to i32
 %93 = ashr i32 %92, 8
 %94 = and i32 255, %93
 %95 = load i8*, i8** %4
 %96 = load i32, i32* %5
 %97 = sext i32 %96 to i64
 %98 = getelementptr %struct.T, i8* %95, i64 %97
 %99 = getelementptr %struct.T, i8* %98, i32 0, i32 3
 %100 = load i16, i16* %99
 %101 = zext i16 %100 to i32
 %102 = shl i32 %101, 8
 %103 = and i32 65280, %102
 %104 = or i32 %94, %103
 %105 = trunc i32 %104 to i16
 %106 = load i8*, i8** %4
 %107 = load i32, i32* %5
 %108 = sext i32 %107 to i64
 %109 = getelementptr %struct.T, i8* %106, i64 %108
 %110 = getelementptr %struct.T, i8* %109, i32 0, i32 3
 store i16 %105, i16* %110
 br label %111
111:
 %112 = load i32, i32* %5
 %113 = add i32 %112, 1
 store i32 %113, i32* %5
 br label %6
114:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.T
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.t, i64 8, i1 0)
 call void @foo (i32 1, i8* %2)
 %3 = getelementptr %struct.T, i8* %2, i32 0, i32 0
 %4 = load i16, i16* %3
 %5 = zext i16 %4 to i32
 %6 = icmp ne i32 %5, 256
 br i1 %6, label %22, label %7
7:
 %8 = getelementptr %struct.T, i8* %2, i32 0, i32 1
 %9 = load i16, i16* %8
 %10 = zext i16 %9 to i32
 %11 = icmp ne i32 %10, 770
 br i1 %11, label %22, label %12
12:
 %13 = getelementptr %struct.T, i8* %2, i32 0, i32 2
 %14 = load i16, i16* %13
 %15 = zext i16 %14 to i32
 %16 = icmp ne i32 %15, 1284
 br i1 %16, label %22, label %17
17:
 %18 = getelementptr %struct.T, i8* %2, i32 0, i32 3
 %19 = load i16, i16* %18
 %20 = zext i16 %19 to i32
 %21 = icmp ne i32 %20, 1798
 br i1 %21, label %22, label %23
22:
 call void @abort ()
 unreachable
23:
 ret i32 0
}
