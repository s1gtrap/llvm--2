declare void @abort()

define i32 @test1 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i8
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 %7 = load i32, i32* %4
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %14
9:
 %10 = load i8, i8* %6
 %11 = sext i8 %10 to i32
 %12 = load i32, i32* %5
 %13 = sdiv i32 %11, %12
 store i32 %13, i32* %3
 br label %15
14:
 store i32 1, i32* %3
 br label %15
15:
 %16 = load i32, i32* %3
 ret i32 %16
}

define i32 @test2 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 %7 = load i32, i32* %4
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %13
9:
 %10 = load i32, i32* %6
 %11 = load i32, i32* %5
 %12 = mul i32 %10, %11
 store i32 %12, i32* %3
 br label %14
13:
 store i32 1, i32* %3
 br label %14
14:
 %15 = load i32, i32* %3
 ret i32 %15
}

define i32 @test3 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 %7 = load i32, i32* %4
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %13
9:
 %10 = load i32, i32* %6
 %11 = load i32, i32* %5
 %12 = srem i32 %10, %11
 store i32 %12, i32* %3
 br label %14
13:
 store i32 1, i32* %3
 br label %14
14:
 %15 = load i32, i32* %3
 ret i32 %15
}

define i32 @test4 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i8
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 %7 = load i32, i32* %4
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %15
9:
 %10 = load i8, i8* %6
 %11 = sext i8 %10 to i32
 %12 = load i32, i32* %5
 %13 = icmp eq i32 %11, %12
 %14 = zext i1 %13 to i32
 store i32 %14, i32* %3
 br label %16
15:
 store i32 1, i32* %3
 br label %16
16:
 %17 = load i32, i32* %3
 ret i32 %17
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test1 (i32 1, i32 1000)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @test2 (i32 1, i32 0)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @test3 (i32 1, i32 1)
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @test4 (i32 1, i32 1000)
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 ret i32 0
}
