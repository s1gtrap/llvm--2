@.str = global [14 x i8] c"Produced: %d\0A\00"

declare i8* @malloc(i64)
declare i32 @printf(i8*, ...)

define i32 @SumArray (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 store i32 0, i32* %6
 %7 = load i8*, i8** %3
 %8 = getelementptr i32, i8* %7, i64 34
 store i32 1234, i32* %8
 store i32 0, i32* %5
 br label %9
9:
 %10 = load i32, i32* %5
 %11 = load i32, i32* %4
 %12 = icmp ult i32 %10, %11
 br i1 %12, label %13, label %24
13:
 %14 = load i8*, i8** %3
 %15 = load i32, i32* %5
 %16 = zext i32 %15 to i64
 %17 = getelementptr i32, i8* %14, i64 %16
 %18 = load i32, i32* %17
 %19 = load i32, i32* %6
 %20 = add i32 %19, %18
 store i32 %20, i32* %6
 br label %21
21:
 %22 = load i32, i32* %5
 %23 = add i32 %22, 1
 store i32 %23, i32* %5
 br label %9
24:
 %25 = load i32, i32* %6
 ret i32 %25
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 %3 = alloca i32
 store i32 0, i32* %1
 %4 = call i8* @malloc (i64 400)
 store i8* %4, i8** %2
 store i32 0, i32* %3
 br label %5
5:
 %6 = load i32, i32* %3
 %7 = icmp slt i32 %6, 100
 br i1 %7, label %8, label %18
8:
 %9 = load i32, i32* %3
 %10 = mul i32 %9, 4
 %11 = load i8*, i8** %2
 %12 = load i32, i32* %3
 %13 = sext i32 %12 to i64
 %14 = getelementptr i32, i8* %11, i64 %13
 store i32 %10, i32* %14
 br label %15
15:
 %16 = load i32, i32* %3
 %17 = add i32 %16, 2
 store i32 %17, i32* %3
 br label %5
18:
 store i32 1, i32* %3
 br label %19
19:
 %20 = load i32, i32* %3
 %21 = icmp slt i32 %20, 100
 br i1 %21, label %22, label %32
22:
 %23 = load i32, i32* %3
 %24 = mul i32 %23, 2
 %25 = load i8*, i8** %2
 %26 = load i32, i32* %3
 %27 = sext i32 %26 to i64
 %28 = getelementptr i32, i8* %25, i64 %27
 store i32 %24, i32* %28
 br label %29
29:
 %30 = load i32, i32* %3
 %31 = add i32 %30, 2
 store i32 %31, i32* %3
 br label %19
32:
 %33 = load i8*, i8** %2
 %34 = call i32 @SumArray (i8* %33, i32 100)
 %35 = call i32 (i8*, ...) @printf (i8* @.str, i32 %34)
 ret i32 0
}
