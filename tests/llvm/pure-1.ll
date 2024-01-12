@i = global i32 2

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [10 x i32]
 %3 = alloca i32
 store i32 0, i32* %1
 %4 = getelementptr [10 x i32], i8* %2, i64 0, i64 0
 store i32 0, i32* %4
 %5 = call i32 @func0 (i32 0)
 store i32 %5, i32* %3
 %6 = getelementptr [10 x i32], i8* %2, i64 0, i64 0
 %7 = load i32, i32* %6
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %10
9:
 call void @link_error0 ()
 br label %10
10:
 %11 = getelementptr [10 x i32], i8* %2, i64 0, i64 1
 store i32 0, i32* %11
 %12 = call i32 @func1 (i32 0)
 store i32 %12, i32* %3
 %13 = getelementptr [10 x i32], i8* %2, i64 0, i64 1
 %14 = load i32, i32* %13
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %16, label %17
16:
 call void @link_error1 ()
 br label %17
17:
 %18 = getelementptr [10 x i32], i8* %2, i64 0, i64 2
 store i32 0, i32* %18
 %19 = call i32 @func2 (i32 0)
 store i32 %19, i32* %3
 %20 = getelementptr [10 x i32], i8* %2, i64 0, i64 2
 %21 = load i32, i32* %20
 %22 = icmp ne i32 %21, 0
 br i1 %22, label %23, label %24
23:
 call void @link_error2 ()
 br label %24
24:
 %25 = getelementptr [10 x i32], i8* %2, i64 0, i64 3
 store i32 0, i32* %25
 %26 = call i32 @func3 (i32 0)
 store i32 %26, i32* %3
 %27 = getelementptr [10 x i32], i8* %2, i64 0, i64 3
 %28 = load i32, i32* %27
 %29 = icmp ne i32 %28, 0
 br i1 %29, label %30, label %31
30:
 call void @link_error3 ()
 br label %31
31:
 %32 = getelementptr [10 x i32], i8* %2, i64 0, i64 4
 store i32 0, i32* %32
 %33 = call i32 @func4 (i32 0)
 store i32 %33, i32* %3
 %34 = getelementptr [10 x i32], i8* %2, i64 0, i64 4
 %35 = load i32, i32* %34
 %36 = icmp ne i32 %35, 0
 br i1 %36, label %37, label %38
37:
 call void @link_error4 ()
 br label %38
38:
 %39 = getelementptr [10 x i32], i8* %2, i64 0, i64 5
 store i32 0, i32* %39
 %40 = call i32 @func5 (i32 0)
 store i32 %40, i32* %3
 %41 = getelementptr [10 x i32], i8* %2, i64 0, i64 5
 %42 = load i32, i32* %41
 %43 = icmp ne i32 %42, 0
 br i1 %43, label %44, label %45
44:
 call void @link_error5 ()
 br label %45
45:
 %46 = getelementptr [10 x i32], i8* %2, i64 0, i64 6
 store i32 0, i32* %46
 %47 = call i32 @func6 (i32 0)
 store i32 %47, i32* %3
 %48 = getelementptr [10 x i32], i8* %2, i64 0, i64 6
 %49 = load i32, i32* %48
 %50 = icmp ne i32 %49, 0
 br i1 %50, label %51, label %52
51:
 call void @link_error6 ()
 br label %52
52:
 %53 = getelementptr [10 x i32], i8* %2, i64 0, i64 7
 store i32 0, i32* %53
 %54 = call i32 @func7 (i32 0)
 store i32 %54, i32* %3
 %55 = getelementptr [10 x i32], i8* %2, i64 0, i64 7
 %56 = load i32, i32* %55
 %57 = icmp ne i32 %56, 0
 br i1 %57, label %58, label %59
58:
 call void @link_error7 ()
 br label %59
59:
 %60 = load i32, i32* %3
 ret i32 %60
}

define i32 @func0 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = load i32, i32* @i
 %5 = sub i32 %3, %4
 ret i32 %5
}

define void @link_error0 () {
 ret void
}

define i32 @func1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = load i32, i32* %2
 %5 = sub i32 %3, %4
 ret i32 %5
}

define void @link_error1 () {
 ret void
}

define i32 @func2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* @i
 %4 = load i32, i32* %2
 %5 = add i32 %3, %4
 ret i32 %5
}

define void @link_error2 () {
 ret void
}

define i32 @func3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = mul i32 %3, 3
 ret i32 %4
}

define void @link_error3 () {
 ret void
}

define i32 @func4 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = call i32 @func0 (i32 %3)
 %5 = load i32, i32* %2
 %6 = add i32 %4, %5
 ret i32 %6
}

define void @link_error4 () {
 ret void
}

define i32 @func5 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = load i32, i32* %2
 %5 = call i32 @func1 (i32 %4)
 %6 = add i32 %3, %5
 ret i32 %6
}

define void @link_error5 () {
 ret void
}

define i32 @func6 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = call i32 @func2 (i32 %3)
 %5 = load i32, i32* %2
 %6 = add i32 %4, %5
 ret i32 %6
}

define void @link_error6 () {
 ret void
}

define i32 @func7 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = load i32, i32* %2
 %5 = call i32 @func3 (i32 %4)
 %6 = add i32 %3, %5
 ret i32 %6
}

define void @link_error7 () {
 ret void
}
