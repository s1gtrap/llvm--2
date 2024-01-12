declare void @abort()

define i32 @test1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 31
 %5 = sub i32 0, %4
 ret i32 %5
}

define i32 @test2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 31
 %5 = sub i32 0, %4
 ret i32 %5
}

define i32 @test3 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 store i32 31, i32* %3
 %4 = load i32, i32* %2
 %5 = load i32, i32* %3
 %6 = ashr i32 %4, %5
 %7 = sub i32 0, %6
 ret i32 %7
}

define i32 @test4 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 store i32 31, i32* %3
 %4 = load i32, i32* %2
 %5 = load i32, i32* %3
 %6 = lshr i32 %4, %5
 %7 = sub i32 0, %6
 ret i32 %7
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test1 (i32 0)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @test1 (i32 1)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @test1 (i32 -1)
 %11 = icmp ne i32 %10, 1
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @test2 (i32 0)
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 %18 = call i32 @test2 (i32 1)
 %19 = icmp ne i32 %18, 0
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i32 @test2 (i32 -1)
 %23 = icmp ne i32 %22, -1
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 %26 = call i32 @test3 (i32 0)
 %27 = icmp ne i32 %26, 0
 br i1 %27, label %28, label %29
28:
 call void @abort ()
 unreachable
29:
 %30 = call i32 @test3 (i32 1)
 %31 = icmp ne i32 %30, 0
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 %34 = call i32 @test3 (i32 -1)
 %35 = icmp ne i32 %34, 1
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 %38 = call i32 @test4 (i32 0)
 %39 = icmp ne i32 %38, 0
 br i1 %39, label %40, label %41
40:
 call void @abort ()
 unreachable
41:
 %42 = call i32 @test4 (i32 1)
 %43 = icmp ne i32 %42, 0
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 %46 = call i32 @test4 (i32 -1)
 %47 = icmp ne i32 %46, -1
 br i1 %47, label %48, label %49
48:
 call void @abort ()
 unreachable
49:
 ret i32 0
}
