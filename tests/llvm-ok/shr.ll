@.str = global [35 x i8] c"ShrTest1(-1, 11, 0xFF000000) = %d\0A\00"
@.str.1 = global [27 x i8] c"ShrTest2(-73, 11, 1) = %d\0A\00"
@.str.2 = global [20 x i8] c"ShrTest3(-73) = %d\0A\00"
@.str.3 = global [20 x i8] c"ShrTest4(-73) = %d\0A\00"
@.str.4 = global [25 x i8] c"ShrTest5(7773, 11) = %d\0A\00"
@.str.5 = global [24 x i8] c"ShrTest6(-73, 11) = %d\0A\00"
@.str.6 = global [21 x i8] c"ShrTest7(-737) = %d\0A\00"
@.str.7 = global [19 x i8] c"ShrTest8(73) = %d\0A\00"
@.str.8 = global [29 x i8] c"ShrTest9(13, 7773, 11) = %d\0A\00"
@.str.9 = global [30 x i8] c"ShrTest10(13, 7773, 11) = %d\0A\00"
@.str.10 = global [30 x i8] c"ShrTest11(13, 7773, 11) = %d\0A\00"
@.str.11 = global [37 x i8] c"ShrTest12(7773, -73, 11, 3773) = %d\0A\00"
@.str.12 = global [37 x i8] c"ShrTest13(7773, -73, 11, 3773) = %d\0A\00"
@.str.13 = global [37 x i8] c"ShrTest14(7773, -73, 11, 3773) = %d\0A\00"
@.str.14 = global [30 x i8] c"ShrTest15(7773, 13, 11) = %d\0A\00"
@.str.15 = global [29 x i8] c"ShrTest16(-73, 11, 13) = %d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @ShrTest1 (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i32, i32* %4
 %8 = load i32, i32* %5
 %9 = lshr i32 %7, %8
 %10 = load i32, i32* %6
 %11 = and i32 %9, %10
 ret i32 %11
}

define i32 @ShrTest2 (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i32, i32* %4
 %8 = load i32, i32* %5
 %9 = ashr i32 %7, %8
 %10 = load i32, i32* %6
 %11 = and i32 %9, %10
 ret i32 %11
}

define i32 @ShrTest3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 31
 %5 = sub i32 0, %4
 ret i32 %5
}

define i32 @ShrTest4 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 31
 %5 = sub i32 0, %4
 ret i32 %5
}

define i32 @ShrTest5 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %6 = load i32, i32* %4
 %7 = lshr i32 -1, %6
 store i32 %7, i32* %5
 %8 = load i32, i32* %3
 %9 = load i32, i32* %4
 %10 = lshr i32 %8, %9
 %11 = load i32, i32* %5
 %12 = and i32 %10, %11
 ret i32 %12
}

define i32 @ShrTest6 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %6 = load i32, i32* %4
 %7 = lshr i32 -1, %6
 store i32 %7, i32* %5
 %8 = load i32, i32* %3
 %9 = load i32, i32* %4
 %10 = ashr i32 %8, %9
 %11 = load i32, i32* %5
 %12 = and i32 %10, %11
 ret i32 %12
}

define i32 @ShrTest7 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 0
 ret i32 %4
}

define i32 @ShrTest8 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 -1, %3
 ret i32 %4
}

define i32 @ShrTest9 (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i32, i32* %4
 %8 = load i32, i32* %5
 %9 = load i32, i32* %6
 %10 = ashr i32 %8, %9
 %11 = add i32 %7, %10
 %12 = load i32, i32* %6
 %13 = shl i32 %11, %12
 ret i32 %13
}

define i32 @ShrTest10 (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i32, i32* %4
 %8 = load i32, i32* %5
 %9 = load i32, i32* %6
 %10 = ashr i32 %8, %9
 %11 = and i32 %7, %10
 %12 = load i32, i32* %6
 %13 = shl i32 %11, %12
 ret i32 %13
}

define i32 @ShrTest11 (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i32, i32* %4
 %8 = load i32, i32* %5
 %9 = load i32, i32* %6
 %10 = ashr i32 %8, %9
 %11 = or i32 %7, %10
 %12 = load i32, i32* %6
 %13 = shl i32 %11, %12
 ret i32 %13
}

define i32 @ShrTest12 (i32 %0, i32 %1, i32 %2, i32 %3) {
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 store i32 %3, i32* %8
 %9 = load i32, i32* %5
 %10 = load i32, i32* %6
 %11 = load i32, i32* %7
 %12 = ashr i32 %10, %11
 %13 = load i32, i32* %8
 %14 = and i32 %12, %13
 %15 = add i32 %9, %14
 %16 = load i32, i32* %7
 %17 = shl i32 %15, %16
 ret i32 %17
}

define i32 @ShrTest13 (i32 %0, i32 %1, i32 %2, i32 %3) {
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 store i32 %3, i32* %8
 %9 = load i32, i32* %5
 %10 = load i32, i32* %6
 %11 = load i32, i32* %7
 %12 = ashr i32 %10, %11
 %13 = load i32, i32* %8
 %14 = and i32 %12, %13
 %15 = and i32 %9, %14
 %16 = load i32, i32* %7
 %17 = shl i32 %15, %16
 ret i32 %17
}

define i32 @ShrTest14 (i32 %0, i32 %1, i32 %2, i32 %3) {
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 store i32 %3, i32* %8
 %9 = load i32, i32* %5
 %10 = load i32, i32* %6
 %11 = load i32, i32* %7
 %12 = ashr i32 %10, %11
 %13 = load i32, i32* %8
 %14 = and i32 %12, %13
 %15 = or i32 %9, %14
 %16 = load i32, i32* %7
 %17 = shl i32 %15, %16
 ret i32 %17
}

define i32 @ShrTest15 (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i32, i32* %4
 %8 = load i32, i32* %5
 %9 = shl i32 %7, %8
 %10 = load i32, i32* %6
 %11 = lshr i32 %9, %10
 ret i32 %11
}

define i32 @ShrTest16 (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i32, i32* %4
 %8 = load i32, i32* %5
 %9 = ashr i32 %7, %8
 %10 = load i32, i32* %6
 %11 = shl i32 %9, %10
 ret i32 %11
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = call i32 @ShrTest1 (i32 -1, i32 11, i32 -16777216)
 %7 = call i32 (i8*, ...) @printf (i8* @.str, i32 %6)
 %8 = call i32 @ShrTest2 (i32 -73, i32 11, i32 1)
 %9 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %8)
 %10 = call i32 @ShrTest3 (i32 -73)
 %11 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %10)
 %12 = call i32 @ShrTest4 (i32 -73)
 %13 = call i32 (i8*, ...) @printf (i8* @.str.3, i32 %12)
 %14 = call i32 @ShrTest5 (i32 7773, i32 11)
 %15 = call i32 (i8*, ...) @printf (i8* @.str.4, i32 %14)
 %16 = call i32 @ShrTest6 (i32 -73, i32 11)
 %17 = call i32 (i8*, ...) @printf (i8* @.str.5, i32 %16)
 %18 = call i32 @ShrTest7 (i32 -737)
 %19 = call i32 (i8*, ...) @printf (i8* @.str.6, i32 %18)
 %20 = call i32 @ShrTest8 (i32 73)
 %21 = call i32 (i8*, ...) @printf (i8* @.str.7, i32 %20)
 %22 = call i32 @ShrTest9 (i32 13, i32 7773, i32 11)
 %23 = call i32 (i8*, ...) @printf (i8* @.str.8, i32 %22)
 %24 = call i32 @ShrTest10 (i32 13, i32 7773, i32 11)
 %25 = call i32 (i8*, ...) @printf (i8* @.str.9, i32 %24)
 %26 = call i32 @ShrTest11 (i32 13, i32 7773, i32 11)
 %27 = call i32 (i8*, ...) @printf (i8* @.str.10, i32 %26)
 %28 = call i32 @ShrTest12 (i32 7773, i32 -73, i32 11, i32 3773)
 %29 = call i32 (i8*, ...) @printf (i8* @.str.11, i32 %28)
 %30 = call i32 @ShrTest13 (i32 7773, i32 -73, i32 11, i32 3773)
 %31 = call i32 (i8*, ...) @printf (i8* @.str.12, i32 %30)
 %32 = call i32 @ShrTest14 (i32 7773, i32 -73, i32 11, i32 3773)
 %33 = call i32 (i8*, ...) @printf (i8* @.str.13, i32 %32)
 %34 = call i32 @ShrTest15 (i32 7773, i32 13, i32 11)
 %35 = call i32 (i8*, ...) @printf (i8* @.str.14, i32 %34)
 %36 = call i32 @ShrTest16 (i32 -73, i32 11, i32 13)
 %37 = call i32 (i8*, ...) @printf (i8* @.str.15, i32 %36)
 ret i32 0
}
