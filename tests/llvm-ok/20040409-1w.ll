declare void @abort()

define i32 @test2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = add i32 %3, -2147483648
 ret i32 %4
}

define i32 @test3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sub i32 %3, -2147483648
 ret i32 %4
}

define i32 @test5 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 store i32 -2147483648, i32* %3
 %4 = load i32, i32* %2
 %5 = load i32, i32* %3
 %6 = add i32 %4, %5
 ret i32 %6
}

define i32 @test6 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 store i32 -2147483648, i32* %3
 %4 = load i32, i32* %2
 %5 = load i32, i32* %3
 %6 = sub i32 %4, %5
 ret i32 %6
}

define void @test (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = call i32 @test2 (i32 %5)
 %7 = load i32, i32* %4
 %8 = icmp ne i32 %6, %7
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 %11 = load i32, i32* %3
 %12 = call i32 @test3 (i32 %11)
 %13 = load i32, i32* %4
 %14 = icmp ne i32 %12, %13
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 %17 = load i32, i32* %3
 %18 = call i32 @test5 (i32 %17)
 %19 = load i32, i32* %4
 %20 = icmp ne i32 %18, %19
 br i1 %20, label %21, label %22
21:
 call void @abort ()
 unreachable
22:
 %23 = load i32, i32* %3
 %24 = call i32 @test6 (i32 %23)
 %25 = load i32, i32* %4
 %26 = icmp ne i32 %24, %25
 br i1 %26, label %27, label %28
27:
 call void @abort ()
 unreachable
28:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test (i32 0, i32 -2147483648)
 call void @test (i32 -2147483648, i32 0)
 call void @test (i32 305419896, i32 -1842063752)
 call void @test (i32 -1842063752, i32 305419896)
 call void @test (i32 2147483647, i32 -1)
 call void @test (i32 -1, i32 2147483647)
 ret i32 0
}
