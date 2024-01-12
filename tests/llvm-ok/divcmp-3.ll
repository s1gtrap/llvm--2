declare void @abort()

define i32 @test1 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp eq i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test1u (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp eq i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test2 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp ne i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test2u (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp ne i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test3 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp slt i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test3u (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp slt i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test4 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp sle i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test4u (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp sle i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test5 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp sgt i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test5u (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp sgt i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test6 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp sge i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @test6u (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = sdiv i32 %4, 100
 %6 = icmp sge i32 %5, 3
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 -128, i32* %2
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = icmp slt i32 %4, 256
 br i1 %5, label %6, label %82
6:
 %7 = load i32, i32* %2
 %8 = trunc i32 %7 to i8
 %9 = call i32 @test1 (i8 %8)
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 %13 = load i32, i32* %2
 %14 = trunc i32 %13 to i8
 %15 = call i32 @test1u (i8 %14)
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %17, label %18
17:
 call void @abort ()
 unreachable
18:
 %19 = load i32, i32* %2
 %20 = trunc i32 %19 to i8
 %21 = call i32 @test2 (i8 %20)
 %22 = icmp ne i32 %21, 1
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 %25 = load i32, i32* %2
 %26 = trunc i32 %25 to i8
 %27 = call i32 @test2u (i8 %26)
 %28 = icmp ne i32 %27, 1
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 %31 = load i32, i32* %2
 %32 = trunc i32 %31 to i8
 %33 = call i32 @test3 (i8 %32)
 %34 = icmp ne i32 %33, 1
 br i1 %34, label %35, label %36
35:
 call void @abort ()
 unreachable
36:
 %37 = load i32, i32* %2
 %38 = trunc i32 %37 to i8
 %39 = call i32 @test3u (i8 %38)
 %40 = icmp ne i32 %39, 1
 br i1 %40, label %41, label %42
41:
 call void @abort ()
 unreachable
42:
 %43 = load i32, i32* %2
 %44 = trunc i32 %43 to i8
 %45 = call i32 @test4 (i8 %44)
 %46 = icmp ne i32 %45, 1
 br i1 %46, label %47, label %48
47:
 call void @abort ()
 unreachable
48:
 %49 = load i32, i32* %2
 %50 = trunc i32 %49 to i8
 %51 = call i32 @test4u (i8 %50)
 %52 = icmp ne i32 %51, 1
 br i1 %52, label %53, label %54
53:
 call void @abort ()
 unreachable
54:
 %55 = load i32, i32* %2
 %56 = trunc i32 %55 to i8
 %57 = call i32 @test5 (i8 %56)
 %58 = icmp ne i32 %57, 0
 br i1 %58, label %59, label %60
59:
 call void @abort ()
 unreachable
60:
 %61 = load i32, i32* %2
 %62 = trunc i32 %61 to i8
 %63 = call i32 @test5u (i8 %62)
 %64 = icmp ne i32 %63, 0
 br i1 %64, label %65, label %66
65:
 call void @abort ()
 unreachable
66:
 %67 = load i32, i32* %2
 %68 = trunc i32 %67 to i8
 %69 = call i32 @test6 (i8 %68)
 %70 = icmp ne i32 %69, 0
 br i1 %70, label %71, label %72
71:
 call void @abort ()
 unreachable
72:
 %73 = load i32, i32* %2
 %74 = trunc i32 %73 to i8
 %75 = call i32 @test6u (i8 %74)
 %76 = icmp ne i32 %75, 0
 br i1 %76, label %77, label %78
77:
 call void @abort ()
 unreachable
78:
 br label %79
79:
 %80 = load i32, i32* %2
 %81 = add i32 %80, 1
 store i32 %81, i32* %2
 br label %3
82:
 ret i32 0
}
