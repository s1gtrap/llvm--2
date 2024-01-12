@staticData = global [16 x i16] [i16 72, i16 69, i16 76, i16 76, i16 79, i16 32, i16 87, i16 79, i16 82, i16 76, i16 68, i16 33, i16 72, i16 69, i16 76, i16 76]
@.str = global [29 x i8] c"iterations (%ld characters)\0A\00"

declare i8* @malloc(i64)
declare i8* @__memcpy_chk(i8*, i8*, i64, i64)
declare i64 @llvm.objectsize.i64.p0(i8*, i1, i1, i1)
declare i32 @printf(i8*, ...)
declare i8* @__memset_chk(i8*, i32, i64, i64)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i64
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i64 0, i64* %6
 br label %7
7:
 %8 = load i64, i64* %6
 %9 = icmp ult i64 %8, 32
 br i1 %9, label %10, label %15
10:
 %11 = load i64, i64* %6
 call void @doTest (i64 %11)
 br label %12
12:
 %13 = load i64, i64* %6
 %14 = add i64 %13, 1
 store i64 %14, i64* %6
 br label %7
15:
 ret i32 0
}

define void @doTest (i64 %0) {
 %2 = alloca i64
 %3 = alloca i64
 %4 = alloca i64
 %5 = alloca i8*
 %6 = alloca i64
 %7 = alloca i8*
 store i64 %0, i64* %2
 %8 = load i64, i64* %2
 store i64 %8, i64* %3
 %9 = load i64, i64* %3
 %10 = add i64 %9, 16
 %11 = sub i64 %10, 1
 %12 = udiv i64 %11, 16
 %13 = mul i64 %12, 16
 store i64 %13, i64* %4
 %14 = load i64, i64* %4
 %15 = mul i64 2, %14
 %16 = call i8* @malloc (i64 %15)
 store i8* %16, i8** %5
 store i64 0, i64* %6
 br label %17
17:
 %18 = load i64, i64* %6
 %19 = load i64, i64* %4
 %20 = icmp ult i64 %18, %19
 br i1 %20, label %21, label %33
21:
 %22 = load i8*, i8** %5
 %23 = load i64, i64* %6
 %24 = getelementptr i16, i8* %22, i64 %23
 %25 = load i8*, i8** %5
 %26 = load i64, i64* %6
 %27 = getelementptr i16, i8* %25, i64 %26
 %28 = call i64 @llvm.objectsize.i64.p0 (i8* %27, i1 0, i1 1, i1 0)
 %29 = call i8* @__memcpy_chk (i8* %24, i8* @staticData, i64 32, i64 %28)
 br label %30
30:
 %31 = load i64, i64* %6
 %32 = add i64 %31, 16
 store i64 %32, i64* %6
 br label %17
33:
 %34 = load i64, i64* %4
 %35 = mul i64 2, %34
 %36 = call i8* @malloc (i64 %35)
 store i8* %36, i8** %7
 %37 = load i64, i64* %2
 %38 = load i64, i64* %3
 %39 = call i32 (i8*, ...) @printf (i8* @.str, i64 %37, i64 %38)
 %40 = load i8*, i8** %7
 %41 = load i64, i64* %4
 %42 = mul i64 2, %41
 %43 = load i8*, i8** %7
 %44 = call i64 @llvm.objectsize.i64.p0 (i8* %43, i1 0, i1 1, i1 0)
 %45 = call i8* @__memset_chk (i8* %40, i32 0, i64 %42, i64 %44)
 store i64 0, i64* %6
 br label %46
46:
 %47 = load i64, i64* %6
 %48 = icmp ult i64 %47, 10000000
 br i1 %48, label %49, label %57
49:
 %50 = load i8*, i8** %5
 %51 = load i64, i64* %3
 %52 = load i8*, i8** %7
 %53 = call i64 @lower_StringImpl (i8* %50, i64 %51, i8* %52)
 br label %54
54:
 %55 = load i64, i64* %6
 %56 = add i64 %55, 1
 store i64 %56, i64* %6
 br label %46
57:
 ret void
}

define i64 @lower_StringImpl (i8* %0, i64 %1, i8* %2) {
 %4 = alloca i64
 %5 = alloca i8*
 %6 = alloca i64
 %7 = alloca i8*
 %8 = alloca i16
 %9 = alloca i64
 %10 = alloca i16
 store i8* %0, i8** %5
 store i64 %1, i64* %6
 store i8* %2, i8** %7
 store i16 0, i16* %8
 store i64 0, i64* %9
 br label %11
11:
 %12 = load i64, i64* %9
 %13 = load i64, i64* %6
 %14 = icmp ult i64 %12, %13
 br i1 %14, label %15, label %34
15:
 %16 = load i8*, i8** %5
 %17 = load i64, i64* %9
 %18 = getelementptr i16, i8* %16, i64 %17
 %19 = load i16, i16* %18
 store i16 %19, i16* %10
 %20 = load i16, i16* %10
 %21 = zext i16 %20 to i32
 %22 = load i16, i16* %8
 %23 = zext i16 %22 to i32
 %24 = or i32 %23, %21
 %25 = trunc i32 %24 to i16
 store i16 %25, i16* %8
 %26 = load i16, i16* %10
 %27 = call i16 @toASCIILower (i16 %26)
 %28 = load i8*, i8** %7
 %29 = load i64, i64* %9
 %30 = getelementptr i16, i8* %28, i64 %29
 store i16 %27, i16* %30
 br label %31
31:
 %32 = load i64, i64* %9
 %33 = add i64 %32, 1
 store i64 %33, i64* %9
 br label %11
34:
 %35 = load i16, i16* %8
 %36 = zext i16 %35 to i32
 %37 = and i32 %36, -128
 %38 = icmp ne i32 %37, 0
 br i1 %38, label %40, label %39
39:
 store i64 1, i64* %4
 br label %41
40:
 store i64 0, i64* %4
 br label %41
41:
 %42 = load i64, i64* %4
 ret i64 %42
}

define i16 @toASCIILower (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = load i16, i16* %2
 %6 = zext i16 %5 to i32
 %7 = icmp sge i32 %6, 65
 br i1 %7, label %8, label %12
8:
 %9 = load i16, i16* %2
 %10 = zext i16 %9 to i32
 %11 = icmp sle i32 %10, 90
 br label %12
12:
 %13 = phi i1 [0, %1], [%11, %8]
 %14 = zext i1 %13 to i32
 %15 = shl i32 %14, 5
 %16 = or i32 %4, %15
 %17 = trunc i32 %16 to i16
 ret i16 %17
}
