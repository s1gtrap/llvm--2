@.str = global [15 x i8] c"x = %d (0x%x)\0A\00"
@.str.1 = global [23 x i8] c"test_1(x) = %d (0x%x)\0A\00"
@.str.2 = global [23 x i8] c"test_2(x) = %d (0x%x)\0A\00"

declare i32 @printf(i8*, ...)

define i32 @test_1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sle i32 %3, -2147483648
 br i1 %4, label %5, label %6
5:
 store i32 -2147483647, i32* %2
 br label %6
6:
 %7 = load i32, i32* %2
 ret i32 %7
}

define i32 @test_2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sge i32 -2147483648, %3
 br i1 %4, label %5, label %6
5:
 store i32 -2147483647, i32* %2
 br label %6
6:
 %7 = load i32, i32* %2
 ret i32 %7
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 0, i32* %1
 store i32 37, i32* %2
 %5 = load i32, i32* %2
 %6 = load i32, i32* %2
 %7 = call i32 (i8*, ...) @printf (i8* @.str, i32 %5, i32 %6)
 %8 = load i32, i32* %2
 %9 = call i32 @test_1 (i32 %8)
 store i32 %9, i32* %3
 %10 = load i32, i32* %3
 %11 = load i32, i32* %3
 %12 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %10, i32 %11)
 %13 = load i32, i32* %2
 %14 = call i32 @test_2 (i32 %13)
 store i32 %14, i32* %4
 %15 = load i32, i32* %4
 %16 = load i32, i32* %4
 %17 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %15, i32 %16)
 ret i32 0
}
