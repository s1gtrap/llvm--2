@data = global [81 x i8] c"12345678901234567890123456789012345678901234567890123456789012345678901234567890\00"

declare void @memset(i8*, i8, i64, i1)
declare void @memcpy(i8*, i8*, i64, i1)
declare i32 @memcmp(i8*, i8*, i64)
declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [97 x i8]
 store i32 0, i32* %1
 %3 = getelementptr [97 x i8], i8* %2, i64 0, i64 0
 call void @memset (i8* %3, i8 0, i64 97, i1 0)
 %4 = getelementptr [97 x i8], i8* %2, i64 0, i64 0
 %5 = getelementptr i8, i8* %4, i64 1
 call void @memcpy (i8* %5, i8* @data, i64 81, i1 0)
 %6 = getelementptr [97 x i8], i8* %2, i64 0, i64 0
 %7 = getelementptr i8, i8* %6, i64 1
 call void @bar (i8* %7)
 ret i32 0
}

define void @bar (i8* %0) {
 %2 = alloca i8*
 %3 = alloca [16 x i32]
 store i8* %0, i8** %2
 %4 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %5 = getelementptr i32, i8* %4, i64 0
 %6 = load i8*, i8** %2
 %7 = getelementptr i8, i8* %6, i64 0
 call void @memcpy (i8* %5, i8* %7, i64 4, i1 0)
 %8 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %9 = getelementptr i32, i8* %8, i64 1
 %10 = load i8*, i8** %2
 %11 = getelementptr i8, i8* %10, i64 4
 call void @memcpy (i8* %9, i8* %11, i64 4, i1 0)
 %12 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %13 = getelementptr i32, i8* %12, i64 2
 %14 = load i8*, i8** %2
 %15 = getelementptr i8, i8* %14, i64 8
 call void @memcpy (i8* %13, i8* %15, i64 4, i1 0)
 %16 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %17 = getelementptr i32, i8* %16, i64 3
 %18 = load i8*, i8** %2
 %19 = getelementptr i8, i8* %18, i64 12
 call void @memcpy (i8* %17, i8* %19, i64 4, i1 0)
 %20 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %21 = getelementptr i32, i8* %20, i64 4
 %22 = load i8*, i8** %2
 %23 = getelementptr i8, i8* %22, i64 16
 call void @memcpy (i8* %21, i8* %23, i64 4, i1 0)
 %24 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %25 = getelementptr i32, i8* %24, i64 5
 %26 = load i8*, i8** %2
 %27 = getelementptr i8, i8* %26, i64 20
 call void @memcpy (i8* %25, i8* %27, i64 4, i1 0)
 %28 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %29 = getelementptr i32, i8* %28, i64 6
 %30 = load i8*, i8** %2
 %31 = getelementptr i8, i8* %30, i64 24
 call void @memcpy (i8* %29, i8* %31, i64 4, i1 0)
 %32 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %33 = getelementptr i32, i8* %32, i64 7
 %34 = load i8*, i8** %2
 %35 = getelementptr i8, i8* %34, i64 28
 call void @memcpy (i8* %33, i8* %35, i64 4, i1 0)
 %36 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %37 = getelementptr i32, i8* %36, i64 8
 %38 = load i8*, i8** %2
 %39 = getelementptr i8, i8* %38, i64 32
 call void @memcpy (i8* %37, i8* %39, i64 4, i1 0)
 %40 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %41 = getelementptr i32, i8* %40, i64 9
 %42 = load i8*, i8** %2
 %43 = getelementptr i8, i8* %42, i64 36
 call void @memcpy (i8* %41, i8* %43, i64 4, i1 0)
 %44 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %45 = getelementptr i32, i8* %44, i64 10
 %46 = load i8*, i8** %2
 %47 = getelementptr i8, i8* %46, i64 40
 call void @memcpy (i8* %45, i8* %47, i64 4, i1 0)
 %48 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %49 = getelementptr i32, i8* %48, i64 11
 %50 = load i8*, i8** %2
 %51 = getelementptr i8, i8* %50, i64 44
 call void @memcpy (i8* %49, i8* %51, i64 4, i1 0)
 %52 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %53 = getelementptr i32, i8* %52, i64 12
 %54 = load i8*, i8** %2
 %55 = getelementptr i8, i8* %54, i64 48
 call void @memcpy (i8* %53, i8* %55, i64 4, i1 0)
 %56 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %57 = getelementptr i32, i8* %56, i64 13
 %58 = load i8*, i8** %2
 %59 = getelementptr i8, i8* %58, i64 52
 call void @memcpy (i8* %57, i8* %59, i64 4, i1 0)
 %60 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %61 = getelementptr i32, i8* %60, i64 14
 %62 = load i8*, i8** %2
 %63 = getelementptr i8, i8* %62, i64 56
 call void @memcpy (i8* %61, i8* %63, i64 4, i1 0)
 %64 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 %65 = getelementptr i32, i8* %64, i64 15
 %66 = load i8*, i8** %2
 %67 = getelementptr i8, i8* %66, i64 60
 call void @memcpy (i8* %65, i8* %67, i64 4, i1 0)
 %68 = getelementptr [16 x i32], i8* %3, i64 0, i64 0
 call void @foo (i8* %68)
 ret void
}

define void @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = call i32 @memcmp (i8* %3, i8* @data, i64 64)
 %5 = icmp ne i32 %4, 0
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret void
}
