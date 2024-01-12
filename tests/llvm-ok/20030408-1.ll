%struct.foo = type { i8, i8, i8, i8, i8, i8, i8, i8, i8, i8 }

@__const.test1.X = global [8 x i8] c"ABCDEFGH"
@__const.test2.X = global [10 x i8] c"ABCDE\00\00\00\00\00"
@__const.test3.X = global %struct.foo {i8 65, i8 0, i8 67, i8 0, i8 69, i8 0, i8 71, i8 0, i8 73, i8 0}
@__const.test4.X = global %struct.foo {i8 0, i8 66, i8 0, i8 68, i8 0, i8 70, i8 0, i8 72, i8 0, i8 74}

declare void @memcpy(i8*, i8*, i64, i1)
declare void @abort()

define i32 @test1 () {
 %1 = alloca [8 x i8]
 %2 = alloca [8 x i8]
 call void @memcpy (i8* %1, i8* @__const.test1.X, i64 8, i1 0)
 %3 = getelementptr [8 x i8], i8* %2, i64 0, i64 0
 %4 = getelementptr [8 x i8], i8* %1, i64 0, i64 0
 call void @memcpy (i8* %3, i8* %4, i64 8, i1 0)
 %5 = getelementptr [8 x i8], i8* %2, i64 0, i64 0
 %6 = load i8, i8* %5
 %7 = sext i8 %6 to i32
 %8 = icmp ne i32 %7, 65
 br i1 %8, label %44, label %9
9:
 %10 = getelementptr [8 x i8], i8* %2, i64 0, i64 1
 %11 = load i8, i8* %10
 %12 = sext i8 %11 to i32
 %13 = icmp ne i32 %12, 66
 br i1 %13, label %44, label %14
14:
 %15 = getelementptr [8 x i8], i8* %2, i64 0, i64 2
 %16 = load i8, i8* %15
 %17 = sext i8 %16 to i32
 %18 = icmp ne i32 %17, 67
 br i1 %18, label %44, label %19
19:
 %20 = getelementptr [8 x i8], i8* %2, i64 0, i64 3
 %21 = load i8, i8* %20
 %22 = sext i8 %21 to i32
 %23 = icmp ne i32 %22, 68
 br i1 %23, label %44, label %24
24:
 %25 = getelementptr [8 x i8], i8* %2, i64 0, i64 4
 %26 = load i8, i8* %25
 %27 = sext i8 %26 to i32
 %28 = icmp ne i32 %27, 69
 br i1 %28, label %44, label %29
29:
 %30 = getelementptr [8 x i8], i8* %2, i64 0, i64 5
 %31 = load i8, i8* %30
 %32 = sext i8 %31 to i32
 %33 = icmp ne i32 %32, 70
 br i1 %33, label %44, label %34
34:
 %35 = getelementptr [8 x i8], i8* %2, i64 0, i64 6
 %36 = load i8, i8* %35
 %37 = sext i8 %36 to i32
 %38 = icmp ne i32 %37, 71
 br i1 %38, label %44, label %39
39:
 %40 = getelementptr [8 x i8], i8* %2, i64 0, i64 7
 %41 = load i8, i8* %40
 %42 = sext i8 %41 to i32
 %43 = icmp ne i32 %42, 72
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 ret i32 0
}

define i32 @test2 () {
 %1 = alloca [10 x i8]
 %2 = alloca [10 x i8]
 call void @memcpy (i8* %1, i8* @__const.test2.X, i64 10, i1 0)
 %3 = getelementptr [10 x i8], i8* %2, i64 0, i64 0
 %4 = getelementptr [10 x i8], i8* %1, i64 0, i64 0
 call void @memcpy (i8* %3, i8* %4, i64 10, i1 0)
 %5 = getelementptr [10 x i8], i8* %2, i64 0, i64 0
 %6 = load i8, i8* %5
 %7 = sext i8 %6 to i32
 %8 = icmp ne i32 %7, 65
 br i1 %8, label %54, label %9
9:
 %10 = getelementptr [10 x i8], i8* %2, i64 0, i64 1
 %11 = load i8, i8* %10
 %12 = sext i8 %11 to i32
 %13 = icmp ne i32 %12, 66
 br i1 %13, label %54, label %14
14:
 %15 = getelementptr [10 x i8], i8* %2, i64 0, i64 2
 %16 = load i8, i8* %15
 %17 = sext i8 %16 to i32
 %18 = icmp ne i32 %17, 67
 br i1 %18, label %54, label %19
19:
 %20 = getelementptr [10 x i8], i8* %2, i64 0, i64 3
 %21 = load i8, i8* %20
 %22 = sext i8 %21 to i32
 %23 = icmp ne i32 %22, 68
 br i1 %23, label %54, label %24
24:
 %25 = getelementptr [10 x i8], i8* %2, i64 0, i64 4
 %26 = load i8, i8* %25
 %27 = sext i8 %26 to i32
 %28 = icmp ne i32 %27, 69
 br i1 %28, label %54, label %29
29:
 %30 = getelementptr [10 x i8], i8* %2, i64 0, i64 5
 %31 = load i8, i8* %30
 %32 = sext i8 %31 to i32
 %33 = icmp ne i32 %32, 0
 br i1 %33, label %54, label %34
34:
 %35 = getelementptr [10 x i8], i8* %2, i64 0, i64 6
 %36 = load i8, i8* %35
 %37 = sext i8 %36 to i32
 %38 = icmp ne i32 %37, 0
 br i1 %38, label %54, label %39
39:
 %40 = getelementptr [10 x i8], i8* %2, i64 0, i64 7
 %41 = load i8, i8* %40
 %42 = sext i8 %41 to i32
 %43 = icmp ne i32 %42, 0
 br i1 %43, label %54, label %44
44:
 %45 = getelementptr [10 x i8], i8* %2, i64 0, i64 8
 %46 = load i8, i8* %45
 %47 = sext i8 %46 to i32
 %48 = icmp ne i32 %47, 0
 br i1 %48, label %54, label %49
49:
 %50 = getelementptr [10 x i8], i8* %2, i64 0, i64 9
 %51 = load i8, i8* %50
 %52 = sext i8 %51 to i32
 %53 = icmp ne i32 %52, 0
 br i1 %53, label %54, label %55
54:
 call void @abort ()
 unreachable
55:
 ret i32 0
}

define i32 @test3 () {
 %1 = alloca %struct.foo
 %2 = alloca [10 x i8]
 call void @memcpy (i8* %1, i8* @__const.test3.X, i64 10, i1 0)
 %3 = getelementptr [10 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %3, i8* %1, i64 10, i1 0)
 %4 = getelementptr [10 x i8], i8* %2, i64 0, i64 0
 %5 = load i8, i8* %4
 %6 = sext i8 %5 to i32
 %7 = icmp ne i32 %6, 65
 br i1 %7, label %53, label %8
8:
 %9 = getelementptr [10 x i8], i8* %2, i64 0, i64 1
 %10 = load i8, i8* %9
 %11 = sext i8 %10 to i32
 %12 = icmp ne i32 %11, 0
 br i1 %12, label %53, label %13
13:
 %14 = getelementptr [10 x i8], i8* %2, i64 0, i64 2
 %15 = load i8, i8* %14
 %16 = sext i8 %15 to i32
 %17 = icmp ne i32 %16, 67
 br i1 %17, label %53, label %18
18:
 %19 = getelementptr [10 x i8], i8* %2, i64 0, i64 3
 %20 = load i8, i8* %19
 %21 = sext i8 %20 to i32
 %22 = icmp ne i32 %21, 0
 br i1 %22, label %53, label %23
23:
 %24 = getelementptr [10 x i8], i8* %2, i64 0, i64 4
 %25 = load i8, i8* %24
 %26 = sext i8 %25 to i32
 %27 = icmp ne i32 %26, 69
 br i1 %27, label %53, label %28
28:
 %29 = getelementptr [10 x i8], i8* %2, i64 0, i64 5
 %30 = load i8, i8* %29
 %31 = sext i8 %30 to i32
 %32 = icmp ne i32 %31, 0
 br i1 %32, label %53, label %33
33:
 %34 = getelementptr [10 x i8], i8* %2, i64 0, i64 6
 %35 = load i8, i8* %34
 %36 = sext i8 %35 to i32
 %37 = icmp ne i32 %36, 71
 br i1 %37, label %53, label %38
38:
 %39 = getelementptr [10 x i8], i8* %2, i64 0, i64 7
 %40 = load i8, i8* %39
 %41 = sext i8 %40 to i32
 %42 = icmp ne i32 %41, 0
 br i1 %42, label %53, label %43
43:
 %44 = getelementptr [10 x i8], i8* %2, i64 0, i64 8
 %45 = load i8, i8* %44
 %46 = sext i8 %45 to i32
 %47 = icmp ne i32 %46, 73
 br i1 %47, label %53, label %48
48:
 %49 = getelementptr [10 x i8], i8* %2, i64 0, i64 9
 %50 = load i8, i8* %49
 %51 = sext i8 %50 to i32
 %52 = icmp ne i32 %51, 0
 br i1 %52, label %53, label %54
53:
 call void @abort ()
 unreachable
54:
 ret i32 0
}

define i32 @test4 () {
 %1 = alloca %struct.foo
 %2 = alloca [10 x i8]
 call void @memcpy (i8* %1, i8* @__const.test4.X, i64 10, i1 0)
 %3 = getelementptr [10 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %3, i8* %1, i64 10, i1 0)
 %4 = getelementptr [10 x i8], i8* %2, i64 0, i64 0
 %5 = load i8, i8* %4
 %6 = sext i8 %5 to i32
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %53, label %8
8:
 %9 = getelementptr [10 x i8], i8* %2, i64 0, i64 1
 %10 = load i8, i8* %9
 %11 = sext i8 %10 to i32
 %12 = icmp ne i32 %11, 66
 br i1 %12, label %53, label %13
13:
 %14 = getelementptr [10 x i8], i8* %2, i64 0, i64 2
 %15 = load i8, i8* %14
 %16 = sext i8 %15 to i32
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %53, label %18
18:
 %19 = getelementptr [10 x i8], i8* %2, i64 0, i64 3
 %20 = load i8, i8* %19
 %21 = sext i8 %20 to i32
 %22 = icmp ne i32 %21, 68
 br i1 %22, label %53, label %23
23:
 %24 = getelementptr [10 x i8], i8* %2, i64 0, i64 4
 %25 = load i8, i8* %24
 %26 = sext i8 %25 to i32
 %27 = icmp ne i32 %26, 0
 br i1 %27, label %53, label %28
28:
 %29 = getelementptr [10 x i8], i8* %2, i64 0, i64 5
 %30 = load i8, i8* %29
 %31 = sext i8 %30 to i32
 %32 = icmp ne i32 %31, 70
 br i1 %32, label %53, label %33
33:
 %34 = getelementptr [10 x i8], i8* %2, i64 0, i64 6
 %35 = load i8, i8* %34
 %36 = sext i8 %35 to i32
 %37 = icmp ne i32 %36, 0
 br i1 %37, label %53, label %38
38:
 %39 = getelementptr [10 x i8], i8* %2, i64 0, i64 7
 %40 = load i8, i8* %39
 %41 = sext i8 %40 to i32
 %42 = icmp ne i32 %41, 72
 br i1 %42, label %53, label %43
43:
 %44 = getelementptr [10 x i8], i8* %2, i64 0, i64 8
 %45 = load i8, i8* %44
 %46 = sext i8 %45 to i32
 %47 = icmp ne i32 %46, 0
 br i1 %47, label %53, label %48
48:
 %49 = getelementptr [10 x i8], i8* %2, i64 0, i64 9
 %50 = load i8, i8* %49
 %51 = sext i8 %50 to i32
 %52 = icmp ne i32 %51, 74
 br i1 %52, label %53, label %54
53:
 call void @abort ()
 unreachable
54:
 ret i32 0
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test1 ()
 %3 = call i32 @test2 ()
 %4 = call i32 @test3 ()
 %5 = call i32 @test4 ()
 ret i32 0
}
