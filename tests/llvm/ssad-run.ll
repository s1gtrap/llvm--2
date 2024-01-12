declare void @abort()
declare i32 @abs(i32)

define void @bar (i8* %0, i8* %1, i32 %2, i8* %3) {
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i32
 %8 = alloca i8*
 store i8* %0, i8** %5
 store i8* %1, i8** %6
 store i32 %2, i32* %7
 store i8* %3, i8** %8
 %9 = load i8*, i8** %5
 %10 = load i8*, i8** %6
 %11 = load i32, i32* %7
 %12 = call i32 @foo (i8* %9, i32 16, i8* %10, i32 %11)
 %13 = load i8*, i8** %8
 store i32 %12, i32* %13
 ret void
}

define i32 @foo (i8* %0, i32 %1, i8* %2, i32 %3) {
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i8*
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 store i8* %0, i8** %5
 store i32 %1, i32* %6
 store i8* %2, i8** %7
 store i32 %3, i32* %8
 store i32 0, i32* %9
 store i32 0, i32* %10
 br label %12
12:
 %13 = load i32, i32* %10
 %14 = icmp slt i32 %13, 16
 br i1 %14, label %15, label %51
15:
 store i32 0, i32* %11
 br label %16
16:
 %17 = load i32, i32* %11
 %18 = icmp slt i32 %17, 16
 br i1 %18, label %19, label %39
19:
 %20 = load i8*, i8** %5
 %21 = load i32, i32* %11
 %22 = sext i32 %21 to i64
 %23 = getelementptr i8, i8* %20, i64 %22
 %24 = load i8, i8* %23
 %25 = sext i8 %24 to i32
 %26 = load i8*, i8** %7
 %27 = load i32, i32* %11
 %28 = sext i32 %27 to i64
 %29 = getelementptr i8, i8* %26, i64 %28
 %30 = load i8, i8* %29
 %31 = sext i8 %30 to i32
 %32 = sub i32 %25, %31
 %33 = call i32 @abs (i32 %32)
 %34 = load i32, i32* %9
 %35 = add i32 %34, %33
 store i32 %35, i32* %9
 br label %36
36:
 %37 = load i32, i32* %11
 %38 = add i32 %37, 1
 store i32 %38, i32* %11
 br label %16
39:
 %40 = load i32, i32* %6
 %41 = load i8*, i8** %5
 %42 = sext i32 %40 to i64
 %43 = getelementptr i8, i8* %41, i64 %42
 store i8* %43, i8** %5
 %44 = load i32, i32* %8
 %45 = load i8*, i8** %7
 %46 = sext i32 %44 to i64
 %47 = getelementptr i8, i8* %45, i64 %46
 store i8* %47, i8** %7
 br label %48
48:
 %49 = load i32, i32* %10
 %50 = add i32 %49, 1
 store i32 %50, i32* %10
 br label %12
51:
 %52 = load i32, i32* %9
 ret i32 %52
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [256 x i8]
 %3 = alloca [256 x i8]
 %4 = alloca i32
 %5 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %5
 br label %6
6:
 %7 = load i32, i32* %5
 %8 = icmp slt i32 %7, 256
 br i1 %8, label %9, label %51
9:
 %10 = load i32, i32* %5
 %11 = srem i32 %10, 2
 %12 = icmp eq i32 %11, 0
 br i1 %12, label %13, label %29
13:
 %14 = load i32, i32* %5
 %15 = srem i32 %14, 8
 %16 = mul i32 %15, 2
 %17 = add i32 %16, 1
 %18 = trunc i32 %17 to i8
 %19 = load i32, i32* %5
 %20 = sext i32 %19 to i64
 %21 = getelementptr [256 x i8], i8* %2, i64 0, i64 %20
 store i8 %18, i8* %21
 %22 = load i32, i32* %5
 %23 = srem i32 %22, 8
 %24 = sub i32 0, %23
 %25 = trunc i32 %24 to i8
 %26 = load i32, i32* %5
 %27 = sext i32 %26 to i64
 %28 = getelementptr [256 x i8], i8* %3, i64 0, i64 %27
 store i8 %25, i8* %28
 br label %47
29:
 %30 = load i32, i32* %5
 %31 = srem i32 %30, 8
 %32 = mul i32 %31, 2
 %33 = add i32 %32, 2
 %34 = sub i32 0, %33
 %35 = trunc i32 %34 to i8
 %36 = load i32, i32* %5
 %37 = sext i32 %36 to i64
 %38 = getelementptr [256 x i8], i8* %2, i64 0, i64 %37
 store i8 %35, i8* %38
 %39 = load i32, i32* %5
 %40 = srem i32 %39, 8
 %41 = ashr i32 %40, 1
 %42 = sub i32 0, %41
 %43 = trunc i32 %42 to i8
 %44 = load i32, i32* %5
 %45 = sext i32 %44 to i64
 %46 = getelementptr [256 x i8], i8* %3, i64 0, i64 %45
 store i8 %43, i8* %46
 br label %47
47:
 br label %48
48:
 %49 = load i32, i32* %5
 %50 = add i32 %49, 1
 store i32 %50, i32* %5
 br label %6
51:
 %52 = getelementptr [256 x i8], i8* %2, i64 0, i64 0
 %53 = getelementptr [256 x i8], i8* %3, i64 0, i64 0
 call void @bar (i8* %52, i8* %53, i32 16, i8* %4)
 %54 = load i32, i32* %4
 %55 = icmp ne i32 %54, 2368
 br i1 %55, label %56, label %57
56:
 call void @abort ()
 unreachable
57:
 ret i32 0
}
