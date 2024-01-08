@.str = global [5 x i8] c"%lld\00"
@.str.1 = global [6 x i8] c"%lld\0A\00"

declare i8* @malloc(i64)
declare i32 @scanf(i8*, ...)
declare i8* @realloc(i8*, i64)
declare i32 @printf(i8*, ...)
declare void @free(i8*)

define void @swap (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i64
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %6 = load i8*, i8** %3
 %7 = load i64, i64* %6
 store i64 %7, i64* %5
 %8 = load i8*, i8** %4
 %9 = load i64, i64* %8
 %10 = load i8*, i8** %3
 store i64 %9, i64* %10
 %11 = load i64, i64* %5
 %12 = load i8*, i8** %4
 store i64 %11, i64* %12
 ret void
}

define i32 @partition (i8* %0, i32 %1, i32 %2) {
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i64
 %8 = alloca i32
 %9 = alloca i32
 store i8* %0, i8** %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %10 = load i8*, i8** %4
 %11 = load i32, i32* %5
 %12 = sext i32 %11 to i64
 %13 = getelementptr i64, i8* %10, i64 %12
 %14 = load i64, i64* %13
 store i64 %14, i64* %7
 %15 = load i32, i32* %5
 store i32 %15, i32* %8
 %16 = load i32, i32* %6
 store i32 %16, i32* %9
 br label %17
17:
 %18 = load i32, i32* %8
 %19 = load i32, i32* %9
 %20 = icmp slt i32 %18, %19
 br i1 %20, label %21, label %73
21:
 br label %22
22:
 %23 = load i8*, i8** %4
 %24 = load i32, i32* %8
 %25 = sext i32 %24 to i64
 %26 = getelementptr i64, i8* %23, i64 %25
 %27 = load i64, i64* %26
 %28 = load i64, i64* %7
 %29 = icmp sle i64 %27, %28
 br i1 %29, label %30, label %35
30:
 %31 = load i32, i32* %8
 %32 = load i32, i32* %6
 %33 = sub i32 %32, 1
 %34 = icmp sle i32 %31, %33
 br label %35
35:
 %36 = phi i1 [0, %22], [%34, %30]
 br i1 %36, label %37, label %40
37:
 %38 = load i32, i32* %8
 %39 = add i32 %38, 1
 store i32 %39, i32* %8
 br label %22
40:
 br label %41
41:
 %42 = load i8*, i8** %4
 %43 = load i32, i32* %9
 %44 = sext i32 %43 to i64
 %45 = getelementptr i64, i8* %42, i64 %44
 %46 = load i64, i64* %45
 %47 = load i64, i64* %7
 %48 = icmp sgt i64 %46, %47
 br i1 %48, label %49, label %54
49:
 %50 = load i32, i32* %9
 %51 = load i32, i32* %5
 %52 = add i32 %51, 1
 %53 = icmp sge i32 %50, %52
 br label %54
54:
 %55 = phi i1 [0, %41], [%53, %49]
 br i1 %55, label %56, label %59
56:
 %57 = load i32, i32* %9
 %58 = add i32 %57, -1
 store i32 %58, i32* %9
 br label %41
59:
 %60 = load i32, i32* %8
 %61 = load i32, i32* %9
 %62 = icmp slt i32 %60, %61
 br i1 %62, label %63, label %72
63:
 %64 = load i8*, i8** %4
 %65 = load i32, i32* %8
 %66 = sext i32 %65 to i64
 %67 = getelementptr i64, i8* %64, i64 %66
 %68 = load i8*, i8** %4
 %69 = load i32, i32* %9
 %70 = sext i32 %69 to i64
 %71 = getelementptr i64, i8* %68, i64 %70
 call void @swap (i8* %67, i8* %71)
 br label %72
72:
 br label %17
73:
 %74 = load i8*, i8** %4
 %75 = load i32, i32* %5
 %76 = sext i32 %75 to i64
 %77 = getelementptr i64, i8* %74, i64 %76
 %78 = load i8*, i8** %4
 %79 = load i32, i32* %9
 %80 = sext i32 %79 to i64
 %81 = getelementptr i64, i8* %78, i64 %80
 call void @swap (i8* %77, i8* %81)
 %82 = load i32, i32* %9
 ret i32 %82
}

define void @quickSort (i8* %0, i32 %1, i32 %2) {
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i8* %0, i8** %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %8 = load i32, i32* %5
 %9 = load i32, i32* %6
 %10 = icmp slt i32 %8, %9
 br i1 %10, label %11, label %24
11:
 %12 = load i8*, i8** %4
 %13 = load i32, i32* %5
 %14 = load i32, i32* %6
 %15 = call i32 @partition (i8* %12, i32 %13, i32 %14)
 store i32 %15, i32* %7
 %16 = load i8*, i8** %4
 %17 = load i32, i32* %5
 %18 = load i32, i32* %7
 %19 = sub i32 %18, 1
 call void @quickSort (i8* %16, i32 %17, i32 %19)
 %20 = load i8*, i8** %4
 %21 = load i32, i32* %7
 %22 = add i32 %21, 1
 %23 = load i32, i32* %6
 call void @quickSort (i8* %20, i32 %22, i32 %23)
 br label %24
24:
 ret void
}

define i32 @read_ints (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i8* %0, i8** %2
 %6 = call i8* @malloc (i64 64)
 %7 = load i8*, i8** %2
 store i8* %6, i8** %7
 store i32 0, i32* %3
 store i32 0, i32* %4
 br label %8
8:
 %9 = load i32, i32* %4
 %10 = mul i32 %9, 8
 store i32 %10, i32* %5
 br label %11
11:
 %12 = load i32, i32* %5
 %13 = load i32, i32* %4
 %14 = add i32 %13, 1
 %15 = mul i32 %14, 8
 %16 = icmp slt i32 %12, %15
 br i1 %16, label %17, label %33
17:
 %18 = load i8*, i8** %2
 %19 = load i8*, i8** %18
 %20 = load i32, i32* %3
 %21 = sext i32 %20 to i64
 %22 = getelementptr i64, i8* %19, i64 %21
 %23 = call i32 (i8*, ...) @scanf (i8* @.str, i8* %22)
 %24 = icmp eq i32 %23, -1
 br i1 %24, label %25, label %27
25:
 %26 = load i32, i32* %3
 ret i32 %26
27:
 br label %28
28:
 %29 = load i32, i32* %5
 %30 = add i32 %29, 1
 store i32 %30, i32* %5
 %31 = load i32, i32* %3
 %32 = add i32 %31, 1
 store i32 %32, i32* %3
 br label %11
33:
 %34 = load i8*, i8** %2
 %35 = load i8*, i8** %34
 %36 = load i32, i32* %4
 %37 = add i32 %36, 2
 %38 = mul i32 %37, 8
 %39 = sext i32 %38 to i64
 %40 = mul i64 %39, 8
 %41 = call i8* @realloc (i8* %35, i64 %40)
 %42 = load i8*, i8** %2
 store i8* %41, i8** %42
 br label %43
43:
 %44 = load i32, i32* %4
 %45 = add i32 %44, 1
 store i32 %45, i32* %4
 br label %8
}

define void @print_ints (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 store i32 0, i32* %5
 br label %6
6:
 %7 = load i32, i32* %5
 %8 = load i32, i32* %4
 %9 = icmp slt i32 %7, %8
 br i1 %9, label %10, label %20
10:
 %11 = load i8*, i8** %3
 %12 = load i32, i32* %5
 %13 = sext i32 %12 to i64
 %14 = getelementptr i64, i8* %11, i64 %13
 %15 = load i64, i64* %14
 %16 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %15)
 br label %17
17:
 %18 = load i32, i32* %5
 %19 = add i32 %18, 1
 store i32 %19, i32* %5
 br label %6
20:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 %3 = alloca i32
 store i32 0, i32* %1
 %4 = call i32 @read_ints (i8* %2)
 store i32 %4, i32* %3
 %5 = load i8*, i8** %2
 %6 = load i32, i32* %3
 %7 = sub i32 %6, 1
 call void @quickSort (i8* %5, i32 0, i32 %7)
 %8 = load i8*, i8** %2
 %9 = load i32, i32* %3
 call void @print_ints (i8* %8, i32 %9)
 %10 = load i8*, i8** %2
 call void @free (i8* %10)
 ret i32 0
}
