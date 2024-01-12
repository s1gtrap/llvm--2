@__const.main.listElem = global [4 x i32] [i32 30, i32 2, i32 10, i32 5]

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()
declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [4 x i32]
 %3 = alloca [2 x i32]
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.listElem, i64 16, i1 0)
 store i32 -1, i32* %6
 store i32 -1, i32* %7
 store i32 0, i32* %4
 br label %8
8:
 %9 = load i32, i32* %4
 %10 = icmp slt i32 %9, 2
 br i1 %10, label %11, label %35
11:
 %12 = load i32, i32* %4
 %13 = sext i32 %12 to i64
 %14 = getelementptr [4 x i32], i8* %2, i64 0, i64 %13
 %15 = load i32, i32* %14
 %16 = load i32, i32* %4
 %17 = sext i32 %16 to i64
 %18 = getelementptr [2 x i32], i8* %3, i64 0, i64 %17
 store i32 %15, i32* %18
 %19 = load i32, i32* %4
 %20 = sext i32 %19 to i64
 %21 = getelementptr [4 x i32], i8* %2, i64 0, i64 %20
 %22 = load i32, i32* %21
 %23 = load i32, i32* %7
 %24 = icmp sgt i32 %22, %23
 br i1 %24, label %25, label %31
25:
 %26 = load i32, i32* %4
 store i32 %26, i32* %6
 %27 = load i32, i32* %4
 %28 = sext i32 %27 to i64
 %29 = getelementptr [4 x i32], i8* %2, i64 0, i64 %28
 %30 = load i32, i32* %29
 store i32 %30, i32* %7
 br label %31
31:
 br label %32
32:
 %33 = load i32, i32* %4
 %34 = add i32 %33, 1
 store i32 %34, i32* %4
 br label %8
35:
 store i32 2, i32* %4
 br label %36
36:
 %37 = load i32, i32* %4
 %38 = icmp slt i32 %37, 4
 br i1 %38, label %39, label %81
39:
 %40 = load i32, i32* %4
 %41 = sext i32 %40 to i64
 %42 = getelementptr [4 x i32], i8* %2, i64 0, i64 %41
 %43 = load i32, i32* %42
 %44 = load i32, i32* %7
 %45 = icmp slt i32 %43, %44
 br i1 %45, label %46, label %77
46:
 %47 = load i32, i32* %4
 %48 = sext i32 %47 to i64
 %49 = getelementptr [4 x i32], i8* %2, i64 0, i64 %48
 %50 = load i32, i32* %49
 %51 = load i32, i32* %6
 %52 = sext i32 %51 to i64
 %53 = getelementptr [2 x i32], i8* %3, i64 0, i64 %52
 store i32 %50, i32* %53
 store i32 0, i32* %6
 %54 = getelementptr [2 x i32], i8* %3, i64 0, i64 0
 %55 = load i32, i32* %54
 store i32 %55, i32* %7
 store i32 1, i32* %5
 br label %56
56:
 %57 = load i32, i32* %5
 %58 = icmp slt i32 %57, 2
 br i1 %58, label %59, label %76
59:
 %60 = load i32, i32* %5
 %61 = sext i32 %60 to i64
 %62 = getelementptr [2 x i32], i8* %3, i64 0, i64 %61
 %63 = load i32, i32* %62
 %64 = load i32, i32* %7
 %65 = icmp sgt i32 %63, %64
 br i1 %65, label %66, label %72
66:
 %67 = load i32, i32* %5
 store i32 %67, i32* %6
 %68 = load i32, i32* %5
 %69 = sext i32 %68 to i64
 %70 = getelementptr [2 x i32], i8* %3, i64 0, i64 %69
 %71 = load i32, i32* %70
 store i32 %71, i32* %7
 br label %72
72:
 br label %73
73:
 %74 = load i32, i32* %5
 %75 = add i32 %74, 1
 store i32 %75, i32* %5
 br label %56
76:
 br label %77
77:
 br label %78
78:
 %79 = load i32, i32* %4
 %80 = add i32 %79, 1
 store i32 %80, i32* %4
 br label %36
81:
 %82 = getelementptr [2 x i32], i8* %3, i64 0, i64 0
 %83 = load i32, i32* %82
 %84 = icmp ne i32 %83, 5
 br i1 %84, label %89, label %85
85:
 %86 = getelementptr [2 x i32], i8* %3, i64 0, i64 1
 %87 = load i32, i32* %86
 %88 = icmp ne i32 %87, 2
 br i1 %88, label %89, label %90
89:
 call void @abort ()
 unreachable
90:
 call void @exit (i32 0)
 unreachable
}
