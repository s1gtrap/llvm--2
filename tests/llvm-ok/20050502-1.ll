@.str = global [10 x i8] c"abcde'fgh\00"
@.str.1 = global [4 x i8] c"fgh\00"
@.str.2 = global [6 x i8] c"abcde\00"
@.str.3 = global [11 x i8] c"ABCDEFG\22HI\00"
@.str.4 = global [3 x i8] c"HI\00"
@.str.5 = global [8 x i8] c"ABCDEFG\00"
@.str.6 = global [11 x i8] c"abcd\22e'fgh\00"
@.str.7 = global [6 x i8] c"e'fgh\00"
@.str.8 = global [5 x i8] c"abcd\00"
@.str.9 = global [12 x i8] c"ABCDEF'G\22HI\00"
@.str.10 = global [5 x i8] c"G\22HI\00"
@.str.11 = global [7 x i8] c"ABCDEF\00"
@.str.12 = global [10 x i8] c"abcdef@gh\00"
@.str.13 = global [3 x i8] c"gh\00"
@.str.14 = global [7 x i8] c"abcdef\00"

declare i32 @strcmp(i8*, i8*)
declare void @abort()

define i32 @bar (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = load i8*, i8** %3
 %5 = getelementptr i8, i8* %4, i32 1
 store i8* %5, i8** %3
 %6 = load i8, i8* %4
 %7 = sext i8 %6 to i32
 ret i32 %7
}

define i32 @baz (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, 64
 %5 = zext i1 %4 to i32
 ret i32 %5
}

define void @foo (i8* %0, i8* %1, i1 %2, i1 %3) {
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i8
 %8 = alloca i8
 %9 = alloca i8
 %10 = alloca i32
 store i8* %0, i8** %5
 store i8* %1, i8** %6
 %11 = zext i1 %2 to i8
 store i8 %11, i8* %7
 %12 = zext i1 %3 to i8
 store i8 %12, i8* %8
 %13 = load i8*, i8** %5
 %14 = call i32 @bar (i8* %13)
 %15 = trunc i32 %14 to i8
 store i8 %15, i8* %9
 store i32 0, i32* %10
 br label %16
16:
 %17 = load i8, i8* %9
 %18 = load i8*, i8** %6
 %19 = load i32, i32* %10
 %20 = add i32 %19, 1
 store i32 %20, i32* %10
 %21 = sext i32 %19 to i64
 %22 = getelementptr i8, i8* %18, i64 %21
 store i8 %17, i8* %22
 %23 = load i8*, i8** %5
 %24 = call i32 @bar (i8* %23)
 %25 = trunc i32 %24 to i8
 store i8 %25, i8* %9
 %26 = load i8, i8* %7
 %27 = trunc i8 %26 to i1
 br i1 %27, label %28, label %33
28:
 %29 = load i8, i8* %9
 %30 = sext i8 %29 to i32
 %31 = icmp eq i32 %30, 39
 br i1 %31, label %32, label %33
32:
 br label %54
33:
 %34 = load i8, i8* %8
 %35 = trunc i8 %34 to i1
 br i1 %35, label %36, label %41
36:
 %37 = load i8, i8* %9
 %38 = sext i8 %37 to i32
 %39 = icmp eq i32 %38, 34
 br i1 %39, label %40, label %41
40:
 br label %54
41:
 %42 = load i8, i8* %7
 %43 = trunc i8 %42 to i1
 br i1 %43, label %53, label %44
44:
 %45 = load i8, i8* %8
 %46 = trunc i8 %45 to i1
 br i1 %46, label %53, label %47
47:
 %48 = load i8, i8* %9
 %49 = sext i8 %48 to i32
 %50 = call i32 @baz (i32 %49)
 %51 = icmp ne i32 %50, 0
 br i1 %51, label %53, label %52
52:
 br label %54
53:
 br label %16
54:
 %55 = load i8*, i8** %6
 %56 = load i32, i32* %10
 %57 = sext i32 %56 to i64
 %58 = getelementptr i8, i8* %55, i64 %57
 store i8 0, i8* %58
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [64 x i8]
 %3 = alloca i8*
 store i32 0, i32* %1
 store i8* @.str, i8** %3
 %4 = getelementptr [64 x i8], i8* %2, i64 0, i64 0
 call void @foo (i8* %3, i8* %4, i1 1, i1 0)
 %5 = load i8*, i8** %3
 %6 = call i32 @strcmp (i8* %5, i8* @.str.1)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %12, label %8
8:
 %9 = getelementptr [64 x i8], i8* %2, i64 0, i64 0
 %10 = call i32 @strcmp (i8* %9, i8* @.str.2)
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 store i8* @.str.3, i8** %3
 %14 = getelementptr [64 x i8], i8* %2, i64 0, i64 0
 call void @foo (i8* %3, i8* %14, i1 0, i1 1)
 %15 = load i8*, i8** %3
 %16 = call i32 @strcmp (i8* %15, i8* @.str.4)
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %22, label %18
18:
 %19 = getelementptr [64 x i8], i8* %2, i64 0, i64 0
 %20 = call i32 @strcmp (i8* %19, i8* @.str.5)
 %21 = icmp ne i32 %20, 0
 br i1 %21, label %22, label %23
22:
 call void @abort ()
 unreachable
23:
 store i8* @.str.6, i8** %3
 %24 = getelementptr [64 x i8], i8* %2, i64 0, i64 0
 call void @foo (i8* %3, i8* %24, i1 1, i1 1)
 %25 = load i8*, i8** %3
 %26 = call i32 @strcmp (i8* %25, i8* @.str.7)
 %27 = icmp ne i32 %26, 0
 br i1 %27, label %32, label %28
28:
 %29 = getelementptr [64 x i8], i8* %2, i64 0, i64 0
 %30 = call i32 @strcmp (i8* %29, i8* @.str.8)
 %31 = icmp ne i32 %30, 0
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 store i8* @.str.9, i8** %3
 %34 = getelementptr [64 x i8], i8* %2, i64 0, i64 0
 call void @foo (i8* %3, i8* %34, i1 1, i1 1)
 %35 = load i8*, i8** %3
 %36 = call i32 @strcmp (i8* %35, i8* @.str.10)
 %37 = icmp ne i32 %36, 0
 br i1 %37, label %42, label %38
38:
 %39 = getelementptr [64 x i8], i8* %2, i64 0, i64 0
 %40 = call i32 @strcmp (i8* %39, i8* @.str.11)
 %41 = icmp ne i32 %40, 0
 br i1 %41, label %42, label %43
42:
 call void @abort ()
 unreachable
43:
 store i8* @.str.12, i8** %3
 %44 = getelementptr [64 x i8], i8* %2, i64 0, i64 0
 call void @foo (i8* %3, i8* %44, i1 0, i1 0)
 %45 = load i8*, i8** %3
 %46 = call i32 @strcmp (i8* %45, i8* @.str.13)
 %47 = icmp ne i32 %46, 0
 br i1 %47, label %52, label %48
48:
 %49 = getelementptr [64 x i8], i8* %2, i64 0, i64 0
 %50 = call i32 @strcmp (i8* %49, i8* @.str.14)
 %51 = icmp ne i32 %50, 0
 br i1 %51, label %52, label %53
52:
 call void @abort ()
 unreachable
53:
 ret i32 0
}
