@Link = global [1 x i32] [i32 -1]
@W = global [1 x i32] [i32 2]

declare void @abort()

define i32 @f (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 store i32 0, i32* %6
 store i32 0, i32* %5
 br label %8
8:
 %9 = load i32, i32* %5
 %10 = icmp sgt i32 %9, 2
 br i1 %10, label %11, label %21
11:
 br label %12
12:
 %13 = load i32, i32* %6
 %14 = add i32 %13, -1
 store i32 %14, i32* %6
 %15 = load i32, i32* %5
 %16 = add i32 %15, 1
 store i32 %16, i32* %5
 br label %17
17:
 %18 = load i32, i32* %6
 %19 = icmp sgt i32 %18, 2
 br i1 %19, label %12, label %20
20:
 br label %21
21:
 %22 = load i32, i32* %6
 %23 = icmp eq i32 %22, 1
 br i1 %23, label %24, label %25
24:
 br label %83
25:
 br label %26
26:
 %27 = load i32, i32* %5
 %28 = load i32, i32* %4
 %29 = icmp sgt i32 %27, %28
 br i1 %29, label %30, label %38
30:
 %31 = load i32, i32* %6
 %32 = load i32, i32* %4
 %33 = icmp eq i32 %31, %32
 br i1 %33, label %34, label %37
34:
 %35 = load i32, i32* %5
 %36 = add i32 %35, 1
 store i32 %36, i32* %5
 br label %37
37:
 br label %26
38:
 br label %39
39:
 %40 = load i32, i32* %3
 %41 = sext i32 %40 to i64
 %42 = getelementptr [1 x i32], i8* @W, i64 0, i64 %41
 %43 = load i32, i32* %42
 store i32 %43, i32* %7
 br label %44
44:
 %45 = load i32, i32* %7
 %46 = icmp ne i32 %45, 0
 br i1 %46, label %47, label %51
47:
 store i32 1, i32* %5
 store i32 0, i32* %7
 %48 = load i32, i32* %3
 %49 = sext i32 %48 to i64
 %50 = getelementptr [1 x i32], i8* @W, i64 0, i64 %49
 store i32 0, i32* %50
 br label %51
51:
 br label %52
52:
 %53 = load i32, i32* %4
 %54 = icmp slt i32 %53, 1
 br i1 %54, label %44, label %55
55:
 br label %56
56:
 %57 = load i32, i32* %3
 %58 = icmp sgt i32 %57, 0
 br i1 %58, label %39, label %59
59:
 br label %60
60:
 store i32 0, i32* %4
 %61 = load i32, i32* %3
 %62 = sext i32 %61 to i64
 %63 = getelementptr [1 x i32], i8* @Link, i64 0, i64 %62
 %64 = load i32, i32* %63
 store i32 %64, i32* %3
 br label %65
65:
 %66 = load i32, i32* %4
 %67 = load i32, i32* %6
 %68 = icmp slt i32 %66, %67
 br i1 %68, label %69, label %78
69:
 %70 = load i32, i32* %3
 %71 = icmp ne i32 %70, -1
 br i1 %71, label %72, label %77
72:
 %73 = load i32, i32* %5
 %74 = add i32 %73, 1
 store i32 %74, i32* %5
 %75 = load i32, i32* %4
 %76 = add i32 %75, 1
 store i32 %76, i32* %4
 br label %77
77:
 br label %65
78:
 br label %79
79:
 %80 = load i32, i32* %3
 %81 = icmp ne i32 %80, -1
 br i1 %81, label %60, label %82
82:
 store i32 1, i32* %6
 br label %8
83:
 %84 = load i32, i32* %5
 ret i32 %84
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f (i32 0, i32 2)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %5, label %4
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
