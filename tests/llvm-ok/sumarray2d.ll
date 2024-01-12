@.str = global [23 x i8] c"Sum(Array[%d,%d] = %d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @SumArray (i8* %0, i32 %1, i32 %2) {
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 store i8* %0, i8** %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 store i32 0, i32* %9
 store i32 0, i32* %7
 br label %10
10:
 %11 = load i32, i32* %7
 %12 = load i32, i32* %5
 %13 = icmp ult i32 %11, %12
 br i1 %13, label %14, label %37
14:
 store i32 0, i32* %8
 br label %15
15:
 %16 = load i32, i32* %8
 %17 = load i32, i32* %6
 %18 = icmp ult i32 %16, %17
 br i1 %18, label %19, label %33
19:
 %20 = load i8*, i8** %4
 %21 = load i32, i32* %7
 %22 = zext i32 %21 to i64
 %23 = getelementptr [100 x i32], i8* %20, i64 %22
 %24 = load i32, i32* %8
 %25 = zext i32 %24 to i64
 %26 = getelementptr [100 x i32], i8* %23, i64 0, i64 %25
 %27 = load i32, i32* %26
 %28 = load i32, i32* %9
 %29 = add i32 %28, %27
 store i32 %29, i32* %9
 br label %30
30:
 %31 = load i32, i32* %8
 %32 = add i32 %31, 1
 store i32 %32, i32* %8
 br label %15
33:
 br label %34
34:
 %35 = load i32, i32* %7
 %36 = add i32 %35, 1
 store i32 %36, i32* %7
 br label %10
37:
 %38 = load i32, i32* %9
 ret i32 %38
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [100 x [100 x i32]]
 %3 = alloca i32
 %4 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %3
 br label %5
5:
 %6 = load i32, i32* %3
 %7 = icmp ult i32 %6, 100
 br i1 %7, label %8, label %20
8:
 %9 = load i32, i32* %3
 %10 = sub i32 0, %9
 %11 = load i32, i32* %3
 %12 = zext i32 %11 to i64
 %13 = getelementptr [100 x [100 x i32]], i8* %2, i64 0, i64 %12
 %14 = load i32, i32* %3
 %15 = zext i32 %14 to i64
 %16 = getelementptr [100 x i32], i8* %13, i64 0, i64 %15
 store i32 %10, i32* %16
 br label %17
17:
 %18 = load i32, i32* %3
 %19 = add i32 %18, 1
 store i32 %19, i32* %3
 br label %5
20:
 store i32 0, i32* %3
 br label %21
21:
 %22 = load i32, i32* %3
 %23 = icmp ult i32 %22, 100
 br i1 %23, label %24, label %50
24:
 store i32 0, i32* %4
 br label %25
25:
 %26 = load i32, i32* %4
 %27 = icmp ult i32 %26, 100
 br i1 %27, label %28, label %46
28:
 %29 = load i32, i32* %4
 %30 = load i32, i32* %3
 %31 = icmp ne i32 %29, %30
 br i1 %31, label %32, label %42
32:
 %33 = load i32, i32* %3
 %34 = load i32, i32* %4
 %35 = add i32 %33, %34
 %36 = load i32, i32* %3
 %37 = zext i32 %36 to i64
 %38 = getelementptr [100 x [100 x i32]], i8* %2, i64 0, i64 %37
 %39 = load i32, i32* %4
 %40 = zext i32 %39 to i64
 %41 = getelementptr [100 x i32], i8* %38, i64 0, i64 %40
 store i32 %35, i32* %41
 br label %42
42:
 br label %43
43:
 %44 = load i32, i32* %4
 %45 = add i32 %44, 1
 store i32 %45, i32* %4
 br label %25
46:
 br label %47
47:
 %48 = load i32, i32* %3
 %49 = add i32 %48, 1
 store i32 %49, i32* %3
 br label %21
50:
 %51 = getelementptr [100 x [100 x i32]], i8* %2, i64 0, i64 0
 %52 = call i32 @SumArray (i8* %51, i32 100, i32 100)
 %53 = call i32 (i8*, ...) @printf (i8* @.str, i32 100, i32 100, i32 %52)
 ret i32 0
}
