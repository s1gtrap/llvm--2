%struct.S = type { [64 x i16] }

declare void @abort()

define void @foo (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i8*
 store i8* %0, i8** %2
 %5 = load i8*, i8** %2
 %6 = getelementptr %struct.S, i8* %5, i32 0, i32 0
 %7 = getelementptr [64 x i16], i8* %6, i64 0, i64 0
 store i8* %7, i8** %4
 store i32 0, i32* %3
 br label %8
8:
 %9 = load i32, i32* %3
 %10 = icmp ult i32 %9, 64
 br i1 %10, label %11, label %38
11:
 %12 = load i8*, i8** %4
 %13 = load i32, i32* %3
 %14 = mul i32 %13, 2
 %15 = zext i32 %14 to i64
 %16 = getelementptr i8, i8* %12, i64 %15
 %17 = load i8, i8* %16
 %18 = zext i8 %17 to i32
 %19 = load i8*, i8** %4
 %20 = load i32, i32* %3
 %21 = mul i32 %20, 2
 %22 = add i32 %21, 1
 %23 = zext i32 %22 to i64
 %24 = getelementptr i8, i8* %19, i64 %23
 %25 = load i8, i8* %24
 %26 = zext i8 %25 to i32
 %27 = shl i32 %26, 8
 %28 = or i32 %18, %27
 %29 = trunc i32 %28 to i16
 %30 = load i8*, i8** %2
 %31 = getelementptr %struct.S, i8* %30, i32 0, i32 0
 %32 = load i32, i32* %3
 %33 = zext i32 %32 to i64
 %34 = getelementptr [64 x i16], i8* %31, i64 0, i64 %33
 store i16 %29, i16* %34
 br label %35
35:
 %36 = load i32, i32* %3
 %37 = add i32 %36, 1
 store i32 %37, i32* %3
 br label %8
38:
 ret void
}

define void @bar (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i8*
 store i8* %0, i8** %2
 %5 = load i8*, i8** %2
 %6 = getelementptr %struct.S, i8* %5, i32 0, i32 0
 %7 = getelementptr [64 x i16], i8* %6, i64 0, i64 0
 store i8* %7, i8** %4
 store i32 0, i32* %3
 br label %8
8:
 %9 = load i32, i32* %3
 %10 = icmp ult i32 %9, 64
 br i1 %10, label %11, label %38
11:
 %12 = load i8*, i8** %4
 %13 = load i32, i32* %3
 %14 = mul i32 %13, 2
 %15 = zext i32 %14 to i64
 %16 = getelementptr i8, i8* %12, i64 %15
 %17 = load i8, i8* %16
 %18 = zext i8 %17 to i32
 %19 = shl i32 %18, 8
 %20 = load i8*, i8** %4
 %21 = load i32, i32* %3
 %22 = mul i32 %21, 2
 %23 = add i32 %22, 1
 %24 = zext i32 %23 to i64
 %25 = getelementptr i8, i8* %20, i64 %24
 %26 = load i8, i8* %25
 %27 = zext i8 %26 to i32
 %28 = or i32 %19, %27
 %29 = trunc i32 %28 to i16
 %30 = load i8*, i8** %2
 %31 = getelementptr %struct.S, i8* %30, i32 0, i32 0
 %32 = load i32, i32* %3
 %33 = zext i32 %32 to i64
 %34 = getelementptr [64 x i16], i8* %31, i64 0, i64 %33
 store i16 %29, i16* %34
 br label %35
35:
 %36 = load i32, i32* %3
 %37 = add i32 %36, 1
 store i32 %37, i32* %3
 br label %8
38:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca %struct.S
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %4
4:
 %5 = load i32, i32* %2
 %6 = icmp ult i32 %5, 64
 br i1 %6, label %7, label %21
7:
 %8 = load i32, i32* %2
 %9 = load i32, i32* %2
 %10 = sub i32 64, %9
 %11 = shl i32 %10, 8
 %12 = add i32 %8, %11
 %13 = trunc i32 %12 to i16
 %14 = getelementptr %struct.S, i8* %3, i32 0, i32 0
 %15 = load i32, i32* %2
 %16 = zext i32 %15 to i64
 %17 = getelementptr [64 x i16], i8* %14, i64 0, i64 %16
 store i16 %13, i16* %17
 br label %18
18:
 %19 = load i32, i32* %2
 %20 = add i32 %19, 1
 store i32 %20, i32* %2
 br label %4
21:
 call void @foo (i8* %3)
 store i32 0, i32* %2
 br label %22
22:
 %23 = load i32, i32* %2
 %24 = icmp ult i32 %23, 64
 br i1 %24, label %25, label %43
25:
 %26 = getelementptr %struct.S, i8* %3, i32 0, i32 0
 %27 = load i32, i32* %2
 %28 = zext i32 %27 to i64
 %29 = getelementptr [64 x i16], i8* %26, i64 0, i64 %28
 %30 = load i16, i16* %29
 %31 = zext i16 %30 to i32
 %32 = load i32, i32* %2
 %33 = load i32, i32* %2
 %34 = sub i32 64, %33
 %35 = shl i32 %34, 8
 %36 = add i32 %32, %35
 %37 = icmp ne i32 %31, %36
 br i1 %37, label %38, label %39
38:
 call void @abort ()
 unreachable
39:
 br label %40
40:
 %41 = load i32, i32* %2
 %42 = add i32 %41, 1
 store i32 %42, i32* %2
 br label %22
43:
 store i32 0, i32* %2
 br label %44
44:
 %45 = load i32, i32* %2
 %46 = icmp ult i32 %45, 64
 br i1 %46, label %47, label %61
47:
 %48 = load i32, i32* %2
 %49 = load i32, i32* %2
 %50 = sub i32 64, %49
 %51 = shl i32 %50, 8
 %52 = add i32 %48, %51
 %53 = trunc i32 %52 to i16
 %54 = getelementptr %struct.S, i8* %3, i32 0, i32 0
 %55 = load i32, i32* %2
 %56 = zext i32 %55 to i64
 %57 = getelementptr [64 x i16], i8* %54, i64 0, i64 %56
 store i16 %53, i16* %57
 br label %58
58:
 %59 = load i32, i32* %2
 %60 = add i32 %59, 1
 store i32 %60, i32* %2
 br label %44
61:
 call void @bar (i8* %3)
 store i32 0, i32* %2
 br label %62
62:
 %63 = load i32, i32* %2
 %64 = icmp ult i32 %63, 64
 br i1 %64, label %65, label %83
65:
 %66 = getelementptr %struct.S, i8* %3, i32 0, i32 0
 %67 = load i32, i32* %2
 %68 = zext i32 %67 to i64
 %69 = getelementptr [64 x i16], i8* %66, i64 0, i64 %68
 %70 = load i16, i16* %69
 %71 = zext i16 %70 to i32
 %72 = load i32, i32* %2
 %73 = sub i32 64, %72
 %74 = load i32, i32* %2
 %75 = shl i32 %74, 8
 %76 = add i32 %73, %75
 %77 = icmp ne i32 %71, %76
 br i1 %77, label %78, label %79
78:
 call void @abort ()
 unreachable
79:
 br label %80
80:
 %81 = load i32, i32* %2
 %82 = add i32 %81, 1
 store i32 %82, i32* %2
 br label %62
83:
 ret i32 0
}
