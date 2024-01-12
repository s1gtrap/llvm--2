@bork = global [4 x [3 x i32]] [[3 x i32] [i32 1, i32 2, i32 3], [3 x i32] [i32 4, i32 5, i32 6], [3 x i32] [i32 7, i32 8, i32 9], [3 x i32] [i32 10, i32 11, i32 12]]
@bork2 = global [2 x [3 x [4 x i32]]] [[3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 5, i32 6, i32 7, i32 8], [4 x i32] [i32 9, i32 10, i32 11, i32 12]], [3 x [4 x i32]] [[4 x i32] [i32 13, i32 14, i32 15, i32 16], [4 x i32] [i32 17, i32 18, i32 19, i32 20], [4 x i32] [i32 21, i32 22, i32 23, i32 24]]]

declare void @abort()

define void @function (i16 %0, i8* %1) {
 %3 = alloca i16
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i32
 store i16 %0, i16* %3
 store i8* %1, i8** %4
 %7 = load i16, i16* %3
 %8 = zext i16 %7 to i64
 store i32 0, i32* %5
 br label %9
9:
 %10 = load i32, i32* %5
 %11 = icmp slt i32 %10, 4
 br i1 %11, label %12, label %45
12:
 store i32 0, i32* %6
 br label %13
13:
 %14 = load i32, i32* %6
 %15 = load i16, i16* %3
 %16 = sext i16 %15 to i32
 %17 = icmp slt i32 %14, %16
 br i1 %17, label %18, label %41
18:
 %19 = load i32, i32* %5
 %20 = sext i32 %19 to i64
 %21 = getelementptr [4 x [3 x i32]], i8* @bork, i64 0, i64 %20
 %22 = load i32, i32* %6
 %23 = sext i32 %22 to i64
 %24 = getelementptr [3 x i32], i8* %21, i64 0, i64 %23
 %25 = load i32, i32* %24
 %26 = load i8*, i8** %4
 %27 = load i32, i32* %5
 %28 = sext i32 %27 to i64
 %29 = mul i64 %28, %8
 %30 = getelementptr i32, i8* %26, i64 %29
 %31 = load i32, i32* %6
 %32 = sext i32 %31 to i64
 %33 = getelementptr i32, i8* %30, i64 %32
 %34 = load i32, i32* %33
 %35 = icmp ne i32 %25, %34
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 br label %38
38:
 %39 = load i32, i32* %6
 %40 = add i32 %39, 1
 store i32 %40, i32* %6
 br label %13
41:
 br label %42
42:
 %43 = load i32, i32* %5
 %44 = add i32 %43, 1
 store i32 %44, i32* %5
 br label %9
45:
 ret void
}

define void @test () {
 call void @function (i16 3, i8* @bork)
 ret void
}

define void @function2 (i16 %0, i16 %1, i8* %2) {
 %4 = alloca i16
 %5 = alloca i16
 %6 = alloca i8*
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 store i16 %0, i16* %4
 store i16 %1, i16* %5
 store i8* %2, i8** %6
 %10 = load i16, i16* %4
 %11 = zext i16 %10 to i64
 %12 = load i16, i16* %5
 %13 = zext i16 %12 to i64
 store i32 0, i32* %7
 br label %14
14:
 %15 = load i32, i32* %7
 %16 = icmp slt i32 %15, 2
 br i1 %16, label %17, label %68
17:
 store i32 0, i32* %8
 br label %18
18:
 %19 = load i32, i32* %8
 %20 = load i16, i16* %4
 %21 = sext i16 %20 to i32
 %22 = icmp slt i32 %19, %21
 br i1 %22, label %23, label %64
23:
 store i32 0, i32* %9
 br label %24
24:
 %25 = load i32, i32* %9
 %26 = load i16, i16* %5
 %27 = sext i16 %26 to i32
 %28 = icmp slt i32 %25, %27
 br i1 %28, label %29, label %60
29:
 %30 = load i32, i32* %7
 %31 = sext i32 %30 to i64
 %32 = getelementptr [2 x [3 x [4 x i32]]], i8* @bork2, i64 0, i64 %31
 %33 = load i32, i32* %8
 %34 = sext i32 %33 to i64
 %35 = getelementptr [3 x [4 x i32]], i8* %32, i64 0, i64 %34
 %36 = load i32, i32* %9
 %37 = sext i32 %36 to i64
 %38 = getelementptr [4 x i32], i8* %35, i64 0, i64 %37
 %39 = load i32, i32* %38
 %40 = load i8*, i8** %6
 %41 = load i32, i32* %7
 %42 = sext i32 %41 to i64
 %43 = mul i64 %11, %13
 %44 = mul i64 %42, %43
 %45 = getelementptr i32, i8* %40, i64 %44
 %46 = load i32, i32* %8
 %47 = sext i32 %46 to i64
 %48 = mul i64 %47, %13
 %49 = getelementptr i32, i8* %45, i64 %48
 %50 = load i32, i32* %9
 %51 = sext i32 %50 to i64
 %52 = getelementptr i32, i8* %49, i64 %51
 %53 = load i32, i32* %52
 %54 = icmp ne i32 %39, %53
 br i1 %54, label %55, label %56
55:
 call void @abort ()
 unreachable
56:
 br label %57
57:
 %58 = load i32, i32* %9
 %59 = add i32 %58, 1
 store i32 %59, i32* %9
 br label %24
60:
 br label %61
61:
 %62 = load i32, i32* %8
 %63 = add i32 %62, 1
 store i32 %63, i32* %8
 br label %18
64:
 br label %65
65:
 %66 = load i32, i32* %7
 %67 = add i32 %66, 1
 store i32 %67, i32* %7
 br label %14
68:
 ret void
}

define void @test2 () {
 call void @function2 (i16 3, i16 4, i8* @bork2)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test ()
 call void @test2 ()
 ret i32 0
}
