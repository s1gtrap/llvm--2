@.str = global [4 x i8] c"ok\0A\00"
@.str.1 = global [6 x i8] c"fail\0A\00"

declare i32 @printf(i8*, ...)

define i32 @my_test () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 1, i32* %1
 store i32 511, i32* %3
 store i32 511, i32* %4
 %6 = load i32, i32* %1
 store i32 %6, i32* %2
 %7 = load i32, i32* %2
 %8 = sub i32 %7, 1
 store i32 %8, i32* %2
 %9 = load i32, i32* %2
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %13, label %11
11:
 %12 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %15
13:
 %14 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %15
15:
 %16 = load i32, i32* %2
 %17 = load i32, i32* %1
 %18 = icmp ugt i32 %16, %17
 br i1 %18, label %19, label %21
19:
 %20 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %23
21:
 %22 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %23
23:
 %24 = load i32, i32* %3
 %25 = load i32, i32* %4
 %26 = icmp ne i32 %24, %25
 br i1 %26, label %27, label %29
27:
 %28 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %31
29:
 %30 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %31
31:
 %32 = load i32, i32* %3
 store i32 %32, i32* %5
 %33 = load i32, i32* %5
 %34 = load i32, i32* %4
 %35 = icmp ule i32 %33, %34
 br i1 %35, label %36, label %38
36:
 %37 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %40
38:
 %39 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %40
40:
 ret i32 0
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @my_test ()
 ret i32 0
}
