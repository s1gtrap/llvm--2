@myConst = global i32 1
@myConst2 = global i32 32767
@.str = global [24 x i8] c"error1: x = %d, y = %d\0A\00"
@.str.1 = global [24 x i8] c"error2: x = %d, y = %d\0A\00"
@.str.2 = global [24 x i8] c"error3: x = %d, y = %d\0A\00"
@.str.3 = global [24 x i8] c"error4: x = %d, y = %d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 0, i32* %1
 store i32 8, i32* %2
 %6 = load i32, i32* %2
 %7 = add i32 %6, 1
 store i32 %7, i32* %3
 %8 = load i32, i32* %3
 %9 = load i32, i32* %2
 %10 = sub i32 %8, %9
 %11 = icmp ne i32 %10, 1
 br i1 %11, label %12, label %16
12:
 %13 = load i32, i32* %2
 %14 = load i32, i32* %3
 %15 = call i32 (i8*, ...) @printf (i8* @.str, i32 %13, i32 %14)
 br label %16
16:
 store i32 128, i32* %2
 %17 = load i32, i32* %3
 %18 = load i32, i32* %2
 %19 = sub i32 %17, %18
 %20 = icmp ne i32 %19, 9
 br i1 %20, label %21, label %25
21:
 %22 = load i32, i32* %2
 %23 = load i32, i32* %3
 %24 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %22, i32 %23)
 br label %25
25:
 %26 = load i32, i32* %3
 store i32 %26, i32* %4
 %27 = load i32, i32* %4
 %28 = and i32 %27, 32767
 store i32 %28, i32* %4
 %29 = load i32, i32* %4
 %30 = icmp ne i32 %29, 9
 br i1 %30, label %31, label %35
31:
 %32 = load i32, i32* %2
 %33 = load i32, i32* %3
 %34 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %32, i32 %33)
 br label %35
35:
 store i32 127, i32* %5
 %36 = load i32, i32* %5
 %37 = add i32 %36, 1
 store i32 %37, i32* %5
 %38 = load i32, i32* %5
 %39 = icmp ne i32 %38, 0
 br i1 %39, label %40, label %44
40:
 %41 = load i32, i32* %2
 %42 = load i32, i32* %3
 %43 = call i32 (i8*, ...) @printf (i8* @.str.3, i32 %41, i32 %42)
 br label %44
44:
 ret i32 0
}
