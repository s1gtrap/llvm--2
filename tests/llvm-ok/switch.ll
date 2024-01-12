@zero = global i32 256
@seven = global i32 15
@.str = global [7 x i8] c"error\0A\00"
@.str.1 = global [23 x i8] c"error: i=%hhd, c=%hhd\0A\00"

declare i32 @printf(i8*, ...)

define i32 @test (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 switch i32 %4, label %29 [
    i32 0, label %5
    i32 1, label %8
    i32 2, label %11
    i32 3, label %15
    i32 4, label %18
    i32 5, label %21
    i32 6, label %24
    i32 7, label %27
  ]
5:
 %6 = load i32, i32* @seven
 %7 = lshr i32 %6, 3
 store i32 %7, i32* %2
 br label %31
8:
 %9 = load i32, i32* @seven
 %10 = lshr i32 %9, 2
 store i32 %10, i32* %2
 br label %31
11:
 %12 = load i32, i32* @seven
 %13 = lshr i32 %12, 1
 %14 = and i32 %13, 2
 store i32 %14, i32* %2
 br label %31
15:
 %16 = load i32, i32* @seven
 %17 = lshr i32 %16, 1
 store i32 %17, i32* %2
 br label %31
18:
 %19 = load i32, i32* @seven
 %20 = and i32 %19, 4
 store i32 %20, i32* %2
 br label %31
21:
 %22 = load i32, i32* @seven
 %23 = and i32 %22, 5
 store i32 %23, i32* %2
 br label %31
24:
 %25 = load i32, i32* @seven
 %26 = and i32 %25, 6
 store i32 %26, i32* %2
 br label %31
27:
 %28 = load i32, i32* @seven
 store i32 %28, i32* %2
 br label %31
29:
 %30 = call i32 (i8*, ...) @printf (i8* @.str)
 store i32 -1, i32* %2
 br label %31
31:
 %32 = load i32, i32* %2
 ret i32 %32
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8
 %3 = alloca i8
 store i32 0, i32* %1
 store i8 0, i8* %3
 br label %4
4:
 %5 = load i8, i8* %3
 %6 = zext i8 %5 to i32
 %7 = icmp slt i32 %6, 8
 br i1 %7, label %8, label %28
8:
 %9 = load i8, i8* %3
 %10 = zext i8 %9 to i32
 %11 = call i32 @test (i32 %10)
 %12 = trunc i32 %11 to i8
 store i8 %12, i8* %2
 %13 = load i8, i8* %2
 %14 = zext i8 %13 to i32
 %15 = load i8, i8* %3
 %16 = zext i8 %15 to i32
 %17 = icmp ne i32 %14, %16
 br i1 %17, label %18, label %24
18:
 %19 = load i8, i8* %3
 %20 = zext i8 %19 to i32
 %21 = load i8, i8* %2
 %22 = zext i8 %21 to i32
 %23 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %20, i32 %22)
 br label %24
24:
 br label %25
25:
 %26 = load i8, i8* %3
 %27 = add i8 %26, 1
 store i8 %27, i8* %3
 br label %4
28:
 ret i32 0
}
