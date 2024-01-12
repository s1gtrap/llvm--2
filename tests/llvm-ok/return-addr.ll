@.str = global [13 x i8] c"%p %p %p %p\0A\00"
@.str.1 = global [33 x i8] c"assertion failed on line %i: %s\0A\00"
@.str.2 = global [19 x i8] c"0 != test_max_2 ()\00"
@.str.3 = global [19 x i8] c"0 != test_max_3 ()\00"
@.str.4 = global [19 x i8] c"0 != test_min_2 ()\00"
@.str.5 = global [19 x i8] c"0 != test_min_3 ()\00"
@.str.6 = global [24 x i8] c"0 != test_min_3_phi (0)\00"

declare i32 @printf(i8*, ...)
declare void @abort()

define i8* @get_max_2 (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr i8, i8* %3, i64 1
 ret i8* %4
}

define i8* @get_max_3 (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %3
 %6 = load i8*, i8** %4
 %7 = icmp ult i8* %5, %6
 br i1 %7, label %8, label %11
8:
 %9 = load i8*, i8** %4
 %10 = getelementptr i8, i8* %9, i64 1
 br label %14
11:
 %12 = load i8*, i8** %3
 %13 = getelementptr i8, i8* %12, i64 1
 br label %14
14:
 %15 = phi i8* [%10, %8], [%13, %11]
 ret i8* %15
}

define i8* @get_min_2 (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr i8, i8* %3, i64 -1
 ret i8* %4
}

define i8* @get_min_3 (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %3
 %6 = load i8*, i8** %4
 %7 = icmp ult i8* %5, %6
 br i1 %7, label %8, label %11
8:
 %9 = load i8*, i8** %3
 %10 = getelementptr i8, i8* %9, i64 -1
 br label %14
11:
 %12 = load i8*, i8** %4
 %13 = getelementptr i8, i8* %12, i64 -1
 br label %14
14:
 %15 = phi i8* [%10, %8], [%13, %11]
 ret i8* %15
}

define i8* @test_max_2 () {
 %1 = alloca i8
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = call i8* @get_max_2 (i8* %1)
 store i8* %4, i8** %2
 %5 = load i8*, i8** %2
 %6 = icmp ugt i8* %5, %1
 br i1 %6, label %7, label %9
7:
 %8 = load i8*, i8** %2
 br label %10
9:
 br label %10
10:
 %11 = phi i8* [%8, %7], [%1, %9]
 store i8* %11, i8** %3
 %12 = load i8*, i8** %3
 ret i8* %12
}

define i8* @test_max_3 () {
 %1 = alloca i8
 %2 = alloca i8
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = call i8* @get_max_3 (i8* %1, i8* %2)
 store i8* %5, i8** %3
 %6 = load i8*, i8** %3
 %7 = icmp ult i8* %6, %1
 br i1 %7, label %8, label %14
8:
 %9 = icmp ult i8* %1, %2
 br i1 %9, label %10, label %11
10:
 br label %12
11:
 br label %12
12:
 %13 = phi i8* [%2, %10], [%1, %11]
 br label %16
14:
 %15 = load i8*, i8** %3
 br label %16
16:
 %17 = phi i8* [%13, %12], [%15, %14]
 store i8* %17, i8** %4
 %18 = load i8*, i8** %4
 ret i8* %18
}

define i8* @test_min_2 () {
 %1 = alloca i8
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = call i8* @get_min_2 (i8* %1)
 store i8* %4, i8** %2
 %5 = load i8*, i8** %2
 %6 = icmp ult i8* %5, %1
 br i1 %6, label %7, label %9
7:
 %8 = load i8*, i8** %2
 br label %10
9:
 br label %10
10:
 %11 = phi i8* [%8, %7], [%1, %9]
 store i8* %11, i8** %3
 %12 = load i8*, i8** %3
 ret i8* %12
}

define i8* @test_min_3 () {
 %1 = alloca i8
 %2 = alloca i8
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = call i8* @get_min_3 (i8* %1, i8* %2)
 store i8* %5, i8** %3
 %6 = load i8*, i8** %3
 %7 = icmp ugt i8* %6, %1
 br i1 %7, label %8, label %14
8:
 %9 = icmp ugt i8* %1, %2
 br i1 %9, label %10, label %11
10:
 br label %12
11:
 br label %12
12:
 %13 = phi i8* [%2, %10], [%1, %11]
 br label %16
14:
 %15 = load i8*, i8** %3
 br label %16
16:
 %17 = phi i8* [%13, %12], [%15, %14]
 store i8* %17, i8** %4
 %18 = load i8*, i8** %4
 ret i8* %18
}

define i8* @test_min_3_phi (i32 %0) {
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i8
 %5 = alloca i8
 %6 = alloca i8*
 %7 = alloca i8*
 %8 = alloca i8*
 %9 = alloca i8*
 %10 = alloca i8*
 %11 = alloca i8*
 store i32 %0, i32* %3
 store i8* %4, i8** %6
 store i8* %5, i8** %7
 %12 = call i8* @get_min_3 (i8* %4, i8* %5)
 store i8* %12, i8** %8
 %13 = call i8* @get_min_3 (i8* %4, i8* %5)
 store i8* %13, i8** %9
 %14 = load i8*, i8** %8
 %15 = load i8*, i8** %6
 %16 = icmp ult i8* %14, %15
 br i1 %16, label %17, label %19
17:
 %18 = load i8*, i8** %8
 br label %21
19:
 %20 = load i8*, i8** %6
 br label %21
21:
 %22 = phi i8* [%18, %17], [%20, %19]
 store i8* %22, i8** %10
 %23 = load i8*, i8** %9
 %24 = load i8*, i8** %7
 %25 = icmp ult i8* %23, %24
 br i1 %25, label %26, label %28
26:
 %27 = load i8*, i8** %9
 br label %30
28:
 %29 = load i8*, i8** %7
 br label %30
30:
 %31 = phi i8* [%27, %26], [%29, %28]
 store i8* %31, i8** %11
 %32 = load i8*, i8** %8
 %33 = load i8*, i8** %9
 %34 = load i8*, i8** %10
 %35 = load i8*, i8** %11
 %36 = call i32 (i8*, ...) @printf (i8* @.str, i8* %32, i8* %33, i8* %34, i8* %35)
 %37 = load i32, i32* %3
 %38 = icmp eq i32 %37, 1
 br i1 %38, label %39, label %41
39:
 %40 = load i8*, i8** %10
 store i8* %40, i8** %2
 br label %43
41:
 %42 = load i8*, i8** %11
 store i8* %42, i8** %2
 br label %43
43:
 %44 = load i8*, i8** %2
 ret i8* %44
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i8* @test_max_2 ()
 %3 = icmp ne i8* null, %2
 br i1 %3, label %4, label %5
4:
 br label %8
5:
 %6 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 115, i8* @.str.2)
 call void @abort ()
 unreachable
7:
 br label %8
8:
 %9 = call i8* @test_max_3 ()
 %10 = icmp ne i8* null, %9
 br i1 %10, label %11, label %12
11:
 br label %15
12:
 %13 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 116, i8* @.str.3)
 call void @abort ()
 unreachable
14:
 br label %15
15:
 %16 = call i8* @test_min_2 ()
 %17 = icmp ne i8* null, %16
 br i1 %17, label %18, label %19
18:
 br label %22
19:
 %20 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 118, i8* @.str.4)
 call void @abort ()
 unreachable
21:
 br label %22
22:
 %23 = call i8* @test_min_3 ()
 %24 = icmp ne i8* null, %23
 br i1 %24, label %25, label %26
25:
 br label %29
26:
 %27 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 119, i8* @.str.5)
 call void @abort ()
 unreachable
28:
 br label %29
29:
 %30 = call i8* @test_min_3_phi (i32 0)
 %31 = icmp ne i8* null, %30
 br i1 %31, label %32, label %33
32:
 br label %36
33:
 %34 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 121, i8* @.str.6)
 call void @abort ()
 unreachable
35:
 br label %36
36:
 %37 = load i32, i32* %1
 ret i32 %37
}
