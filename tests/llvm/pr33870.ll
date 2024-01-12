%struct.PgHdr = type { i32, i8*, i8*, i8*, i8*, i8*, i8, i16, i8*, i8*, i32 }

declare void @memset(i8*, i8, i64, i1)
declare void @abort()

define i8* @sort_pagelist (i8* %0) {
 %2 = alloca i8*
 %3 = alloca [25 x i8*]
 %4 = alloca i8*
 %5 = alloca i32
 store i8* %0, i8** %2
 %6 = getelementptr [25 x i8*], i8* %3, i64 0, i64 0
 call void @memset (i8* %6, i8 0, i64 200, i1 0)
 br label %7
7:
 %8 = load i8*, i8** %2
 %9 = icmp ne i8* %8, null
 br i1 %9, label %10, label %59
10:
 %11 = load i8*, i8** %2
 store i8* %11, i8** %4
 %12 = load i8*, i8** %4
 %13 = getelementptr %struct.PgHdr, i8* %12, i32 0, i32 8
 %14 = load i8*, i8** %13
 store i8* %14, i8** %2
 %15 = load i8*, i8** %4
 %16 = getelementptr %struct.PgHdr, i8* %15, i32 0, i32 8
 store i8* null, i8** %16
 store i32 0, i32* %5
 br label %17
17:
 %18 = load i32, i32* %5
 %19 = icmp slt i32 %18, 24
 br i1 %19, label %20, label %45
20:
 %21 = load i32, i32* %5
 %22 = sext i32 %21 to i64
 %23 = getelementptr [25 x i8*], i8* %3, i64 0, i64 %22
 %24 = load i8*, i8** %23
 %25 = icmp eq i8* %24, null
 br i1 %25, label %26, label %31
26:
 %27 = load i8*, i8** %4
 %28 = load i32, i32* %5
 %29 = sext i32 %28 to i64
 %30 = getelementptr [25 x i8*], i8* %3, i64 0, i64 %29
 store i8* %27, i8** %30
 br label %45
31:
 %32 = load i32, i32* %5
 %33 = sext i32 %32 to i64
 %34 = getelementptr [25 x i8*], i8* %3, i64 0, i64 %33
 %35 = load i8*, i8** %34
 %36 = load i8*, i8** %4
 %37 = call i8* @merge_pagelist (i8* %35, i8* %36)
 store i8* %37, i8** %4
 %38 = load i32, i32* %5
 %39 = sext i32 %38 to i64
 %40 = getelementptr [25 x i8*], i8* %3, i64 0, i64 %39
 store i8* null, i8** %40
 br label %41
41:
 br label %42
42:
 %43 = load i32, i32* %5
 %44 = add i32 %43, 1
 store i32 %44, i32* %5
 br label %17
45:
 %46 = load i32, i32* %5
 %47 = icmp eq i32 %46, 24
 br i1 %47, label %48, label %58
48:
 %49 = load i32, i32* %5
 %50 = sext i32 %49 to i64
 %51 = getelementptr [25 x i8*], i8* %3, i64 0, i64 %50
 %52 = load i8*, i8** %51
 %53 = load i8*, i8** %4
 %54 = call i8* @merge_pagelist (i8* %52, i8* %53)
 %55 = load i32, i32* %5
 %56 = sext i32 %55 to i64
 %57 = getelementptr [25 x i8*], i8* %3, i64 0, i64 %56
 store i8* %54, i8** %57
 br label %58
58:
 br label %7
59:
 %60 = getelementptr [25 x i8*], i8* %3, i64 0, i64 0
 %61 = load i8*, i8** %60
 store i8* %61, i8** %4
 store i32 1, i32* %5
 br label %62
62:
 %63 = load i32, i32* %5
 %64 = icmp slt i32 %63, 25
 br i1 %64, label %65, label %75
65:
 %66 = load i8*, i8** %4
 %67 = load i32, i32* %5
 %68 = sext i32 %67 to i64
 %69 = getelementptr [25 x i8*], i8* %3, i64 0, i64 %68
 %70 = load i8*, i8** %69
 %71 = call i8* @merge_pagelist (i8* %66, i8* %70)
 store i8* %71, i8** %4
 br label %72
72:
 %73 = load i32, i32* %5
 %74 = add i32 %73, 1
 store i32 %74, i32* %5
 br label %62
75:
 %76 = load i8*, i8** %4
 ret i8* %76
}

define i8* @merge_pagelist (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca %struct.PgHdr
 %6 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 store i8* %5, i8** %6
 br label %7
7:
 %8 = load i8*, i8** %3
 %9 = icmp ne i8* %8, null
 br i1 %9, label %10, label %13
10:
 %11 = load i8*, i8** %4
 %12 = icmp ne i8* %11, null
 br label %13
13:
 %14 = phi i1 [0, %7], [%12, %10]
 br i1 %14, label %15, label %40
15:
 %16 = load i8*, i8** %3
 %17 = getelementptr %struct.PgHdr, i8* %16, i32 0, i32 0
 %18 = load i32, i32* %17
 %19 = load i8*, i8** %4
 %20 = getelementptr %struct.PgHdr, i8* %19, i32 0, i32 0
 %21 = load i32, i32* %20
 %22 = icmp ult i32 %18, %21
 br i1 %22, label %23, label %31
23:
 %24 = load i8*, i8** %3
 %25 = load i8*, i8** %6
 %26 = getelementptr %struct.PgHdr, i8* %25, i32 0, i32 8
 store i8* %24, i8** %26
 %27 = load i8*, i8** %3
 store i8* %27, i8** %6
 %28 = load i8*, i8** %3
 %29 = getelementptr %struct.PgHdr, i8* %28, i32 0, i32 8
 %30 = load i8*, i8** %29
 store i8* %30, i8** %3
 br label %39
31:
 %32 = load i8*, i8** %4
 %33 = load i8*, i8** %6
 %34 = getelementptr %struct.PgHdr, i8* %33, i32 0, i32 8
 store i8* %32, i8** %34
 %35 = load i8*, i8** %4
 store i8* %35, i8** %6
 %36 = load i8*, i8** %4
 %37 = getelementptr %struct.PgHdr, i8* %36, i32 0, i32 8
 %38 = load i8*, i8** %37
 store i8* %38, i8** %4
 br label %39
39:
 br label %7
40:
 %41 = load i8*, i8** %3
 %42 = icmp ne i8* %41, null
 br i1 %42, label %43, label %47
43:
 %44 = load i8*, i8** %3
 %45 = load i8*, i8** %6
 %46 = getelementptr %struct.PgHdr, i8* %45, i32 0, i32 8
 store i8* %44, i8** %46
 br label %58
47:
 %48 = load i8*, i8** %4
 %49 = icmp ne i8* %48, null
 br i1 %49, label %50, label %54
50:
 %51 = load i8*, i8** %4
 %52 = load i8*, i8** %6
 %53 = getelementptr %struct.PgHdr, i8* %52, i32 0, i32 8
 store i8* %51, i8** %53
 br label %57
54:
 %55 = load i8*, i8** %6
 %56 = getelementptr %struct.PgHdr, i8* %55, i32 0, i32 8
 store i8* null, i8** %56
 br label %57
57:
 br label %58
58:
 %59 = getelementptr %struct.PgHdr, i8* %5, i32 0, i32 8
 %60 = load i8*, i8** %59
 ret i8* %60
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [5 x %struct.PgHdr]
 %3 = alloca i8*
 store i32 0, i32* %1
 %4 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 0
 %5 = getelementptr %struct.PgHdr, i8* %4, i32 0, i32 0
 store i32 5, i32* %5
 %6 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 1
 %7 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 0
 %8 = getelementptr %struct.PgHdr, i8* %7, i32 0, i32 8
 store i8* %6, i8** %8
 %9 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 1
 %10 = getelementptr %struct.PgHdr, i8* %9, i32 0, i32 0
 store i32 4, i32* %10
 %11 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 2
 %12 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 1
 %13 = getelementptr %struct.PgHdr, i8* %12, i32 0, i32 8
 store i8* %11, i8** %13
 %14 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 2
 %15 = getelementptr %struct.PgHdr, i8* %14, i32 0, i32 0
 store i32 1, i32* %15
 %16 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 3
 %17 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 2
 %18 = getelementptr %struct.PgHdr, i8* %17, i32 0, i32 8
 store i8* %16, i8** %18
 %19 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 3
 %20 = getelementptr %struct.PgHdr, i8* %19, i32 0, i32 0
 store i32 3, i32* %20
 %21 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 3
 %22 = getelementptr %struct.PgHdr, i8* %21, i32 0, i32 8
 store i8* null, i8** %22
 %23 = getelementptr [5 x %struct.PgHdr], i8* %2, i64 0, i64 0
 %24 = call i8* @sort_pagelist (i8* %23)
 store i8* %24, i8** %3
 %25 = load i8*, i8** %3
 %26 = getelementptr %struct.PgHdr, i8* %25, i32 0, i32 8
 %27 = load i8*, i8** %26
 %28 = load i8*, i8** %3
 %29 = icmp eq i8* %27, %28
 br i1 %29, label %30, label %31
30:
 call void @abort ()
 unreachable
31:
 ret i32 0
}
