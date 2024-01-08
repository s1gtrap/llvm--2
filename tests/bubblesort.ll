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
 %5 = alloca i32
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %6 = load i8*, i8** %3
 %7 = load i64, i64* %6
 %8 = trunc i64 %7 to i32
 store i32 %8, i32* %5
 %9 = load i8*, i8** %4
 %10 = load i64, i64* %9
 %11 = load i8*, i8** %3
 store i64 %10, i64* %11
 %12 = load i32, i32* %5
 %13 = sext i32 %12 to i64
 %14 = load i8*, i8** %4
 store i64 %13, i64* %14
 ret void
}

define void @sort (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 store i32 0, i32* %5
 br label %7
7:
 %8 = load i32, i32* %5
 %9 = load i32, i32* %4
 %10 = sub i32 %9, 1
 %11 = icmp slt i32 %8, %10
 br i1 %11, label %12, label %51
12:
 store i32 0, i32* %6
 br label %13
13:
 %14 = load i32, i32* %6
 %15 = load i32, i32* %4
 %16 = load i32, i32* %5
 %17 = sub i32 %15, %16
 %18 = sub i32 %17, 1
 %19 = icmp slt i32 %14, %18
 br i1 %19, label %20, label %47
20:
 %21 = load i8*, i8** %3
 %22 = load i32, i32* %6
 %23 = sext i32 %22 to i64
 %24 = getelementptr i64, i8* %21, i64 %23
 %25 = load i64, i64* %24
 %26 = load i8*, i8** %3
 %27 = load i32, i32* %6
 %28 = add i32 %27, 1
 %29 = sext i32 %28 to i64
 %30 = getelementptr i64, i8* %26, i64 %29
 %31 = load i64, i64* %30
 %32 = icmp sgt i64 %25, %31
 br i1 %32, label %33, label %43
33:
 %34 = load i8*, i8** %3
 %35 = load i32, i32* %6
 %36 = sext i32 %35 to i64
 %37 = getelementptr i64, i8* %34, i64 %36
 %38 = load i8*, i8** %3
 %39 = load i32, i32* %6
 %40 = add i32 %39, 1
 %41 = sext i32 %40 to i64
 %42 = getelementptr i64, i8* %38, i64 %41
 call void @swap (i8* %37, i8* %42)
 br label %43
43:
 br label %44
44:
 %45 = load i32, i32* %6
 %46 = add i32 %45, 1
 store i32 %46, i32* %6
 br label %13
47:
 br label %48
48:
 %49 = load i32, i32* %5
 %50 = add i32 %49, 1
 store i32 %50, i32* %5
 br label %7
51:
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
 %1 = alloca i8*
 %2 = alloca i32
 %3 = call i32 @read_ints (i8* %1)
 store i32 %3, i32* %2
 %4 = load i8*, i8** %1
 %5 = load i32, i32* %2
 call void @sort (i8* %4, i32 %5)
 %6 = load i8*, i8** %1
 %7 = load i32, i32* %2
 call void @print_ints (i8* %6, i32 %7)
 %8 = load i8*, i8** %1
 call void @free (i8* %8)
 ret i32 0
}
