@.str = global [22 x i8] c"uDivTest1(42,3) = %u\0A\00"
@.str.1 = global [22 x i8] c"uDivTest2(42,3) = %u\0A\00"
@.str.2 = global [22 x i8] c"uDivTest3(42,3) = %u\0A\00"
@.str.3 = global [22 x i8] c"uDivTest4(42,3) = %u\0A\00"
@.str.4 = global [22 x i8] c"uDivTest5(42,3) = %u\0A\00"
@.str.5 = global [22 x i8] c"uDivTest6(42,3) = %u\0A\00"
@.str.6 = global [22 x i8] c"uDivTest7(42,3) = %u\0A\00"
@.str.7 = global [22 x i8] c"uDivTest8(42,3) = %u\0A\00"
@.str.8 = global [22 x i8] c"uDivTest9(42,3) = %u\0A\00"
@.str.9 = global [23 x i8] c"uDivTest10(42,3) = %u\0A\00"
@.str.10 = global [23 x i8] c"uDivTest11(42,3) = %u\0A\00"
@.str.11 = global [23 x i8] c"uDivTest12(42,3) = %u\0A\00"
@.str.12 = global [23 x i8] c"uDivTest13(42,3) = %u\0A\00"
@.str.13 = global [23 x i8] c"uDivTest14(42,3) = %u\0A\00"
@.str.14 = global [23 x i8] c"uDivTest15(42,3) = %u\0A\00"
@.str.15 = global [23 x i8] c"uDivTest16(42,3) = %u\0A\00"
@.str.16 = global [23 x i8] c"uDivTest17(42,3) = %u\0A\00"

declare i32 @printf(i8*, ...)

define i32 @uDivTest1 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = udiv i32 0, %5
 ret i32 %6
}

define i32 @uDivTest2 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = udiv i32 %5, 1
 ret i32 %6
}

define i32 @uDivTest3 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = udiv i32 %5, -1
 ret i32 %6
}

define i32 @uDivTest4 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp eq i32 %5, %6
 br i1 %7, label %8, label %9
8:
 br label %11
9:
 %10 = load i32, i32* %4
 br label %11
11:
 %12 = phi i32 [0, %8], [%10, %9]
 ret i32 %12
}

define i32 @uDivTest5 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp eq i32 %5, %6
 br i1 %7, label %8, label %9
8:
 br label %11
9:
 %10 = load i32, i32* %4
 br label %11
11:
 %12 = phi i32 [0, %8], [%10, %9]
 ret i32 %12
}

define i32 @uDivTest6 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp ne i32 %5, %6
 br i1 %7, label %8, label %10
8:
 %9 = load i32, i32* %4
 br label %11
10:
 br label %11
11:
 %12 = phi i32 [%9, %8], [0, %10]
 ret i32 %12
}

define i32 @uDivTest7 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp ne i32 %5, %6
 br i1 %7, label %8, label %10
8:
 %9 = load i32, i32* %4
 br label %11
10:
 br label %11
11:
 %12 = phi i32 [%9, %8], [0, %10]
 ret i32 %12
}

define i32 @uDivTest8 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = udiv i32 %5, 2
 %7 = udiv i32 %6, 4
 ret i32 %7
}

define i32 @uDivTest9 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = udiv i32 %5, 2
 %7 = udiv i32 %6, 4
 ret i32 %7
}

define i32 @uDivTest10 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = udiv i32 %5, 4
 ret i32 %6
}

define i32 @uDivTest11 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = udiv i32 %5, 4
 ret i32 %6
}

define i32 @uDivTest12 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = shl i32 4, %6
 %8 = udiv i32 %5, %7
 ret i32 %8
}

define i32 @uDivTest13 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = shl i32 4, %6
 %8 = udiv i32 %5, %7
 ret i32 %8
}

define i32 @uDivTest14 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %3
 %7 = load i32, i32* %4
 %8 = icmp eq i32 %6, %7
 %9 = zext i1 %8 to i32
 %10 = udiv i32 %5, 4
 ret i32 %10
}

define i32 @uDivTest15 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %3
 %7 = load i32, i32* %4
 %8 = icmp eq i32 %6, %7
 %9 = zext i1 %8 to i32
 %10 = udiv i32 %5, 4
 ret i32 %10
}

define i32 @uDivTest16 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = sub i32 0, %5
 %7 = udiv i32 %6, 2
 ret i32 %7
}

define i32 @uDivTest17 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = sub i32 0, %5
 %7 = udiv i32 %6, 2
 ret i32 %7
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = call i32 @uDivTest1 (i32 42, i32 3)
 %7 = call i32 (i8*, ...) @printf (i8* @.str, i32 %6)
 %8 = call i32 @uDivTest2 (i32 42, i32 3)
 %9 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %8)
 %10 = call i32 @uDivTest3 (i32 42, i32 3)
 %11 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %10)
 %12 = call i32 @uDivTest4 (i32 42, i32 3)
 %13 = call i32 (i8*, ...) @printf (i8* @.str.3, i32 %12)
 %14 = call i32 @uDivTest5 (i32 42, i32 3)
 %15 = call i32 (i8*, ...) @printf (i8* @.str.4, i32 %14)
 %16 = call i32 @uDivTest6 (i32 42, i32 3)
 %17 = call i32 (i8*, ...) @printf (i8* @.str.5, i32 %16)
 %18 = call i32 @uDivTest7 (i32 42, i32 3)
 %19 = call i32 (i8*, ...) @printf (i8* @.str.6, i32 %18)
 %20 = call i32 @uDivTest8 (i32 42, i32 3)
 %21 = call i32 (i8*, ...) @printf (i8* @.str.7, i32 %20)
 %22 = call i32 @uDivTest9 (i32 42, i32 3)
 %23 = call i32 (i8*, ...) @printf (i8* @.str.8, i32 %22)
 %24 = call i32 @uDivTest10 (i32 42, i32 3)
 %25 = call i32 (i8*, ...) @printf (i8* @.str.9, i32 %24)
 %26 = call i32 @uDivTest11 (i32 42, i32 3)
 %27 = call i32 (i8*, ...) @printf (i8* @.str.10, i32 %26)
 %28 = call i32 @uDivTest12 (i32 42, i32 3)
 %29 = call i32 (i8*, ...) @printf (i8* @.str.11, i32 %28)
 %30 = call i32 @uDivTest13 (i32 42, i32 3)
 %31 = call i32 (i8*, ...) @printf (i8* @.str.12, i32 %30)
 %32 = call i32 @uDivTest14 (i32 42, i32 3)
 %33 = call i32 (i8*, ...) @printf (i8* @.str.13, i32 %32)
 %34 = call i32 @uDivTest15 (i32 42, i32 3)
 %35 = call i32 (i8*, ...) @printf (i8* @.str.14, i32 %34)
 %36 = call i32 @uDivTest16 (i32 42, i32 3)
 %37 = call i32 (i8*, ...) @printf (i8* @.str.15, i32 %36)
 %38 = call i32 @uDivTest17 (i32 42, i32 3)
 %39 = call i32 (i8*, ...) @printf (i8* @.str.16, i32 %38)
 ret i32 0
}
