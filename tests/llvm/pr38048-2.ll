declare void @abort()

define i32 @foo () {
 %1 = alloca [2 x [2 x i32]]
 %2 = getelementptr [2 x [2 x i32]], i8* %1, i64 0, i64 0
 %3 = getelementptr [2 x i32], i8* %2, i64 0, i64 0
 store i32 1, i32* %3
 %4 = getelementptr [2 x [2 x i32]], i8* %1, i64 0, i64 0
 %5 = getelementptr [2 x i32], i8* %4, i64 0, i64 1
 store i32 2, i32* %5
 %6 = getelementptr [2 x [2 x i32]], i8* %1, i64 0, i64 1
 %7 = getelementptr [2 x i32], i8* %6, i64 0, i64 0
 store i32 4, i32* %7
 %8 = getelementptr [2 x [2 x i32]], i8* %1, i64 0, i64 1
 %9 = getelementptr [2 x i32], i8* %8, i64 0, i64 1
 store i32 8, i32* %9
 %10 = getelementptr [2 x [2 x i32]], i8* %1, i64 0, i64 0
 %11 = call i32 @inv_J (i8* %10)
 ret i32 %11
}

define i32 @inv_J (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i8* %0, i8** %2
 store i32 0, i32* %5
 store i32 0, i32* %4
 br label %6
6:
 %7 = load i32, i32* %4
 %8 = icmp slt i32 %7, 2
 br i1 %8, label %9, label %28
9:
 %10 = load i8*, i8** %2
 %11 = load i32, i32* %4
 %12 = sext i32 %11 to i64
 %13 = getelementptr [2 x i32], i8* %10, i64 %12
 %14 = getelementptr [2 x i32], i8* %13, i64 0, i64 0
 %15 = load i32, i32* %14
 %16 = load i8*, i8** %2
 %17 = load i32, i32* %4
 %18 = sext i32 %17 to i64
 %19 = getelementptr [2 x i32], i8* %16, i64 %18
 %20 = getelementptr [2 x i32], i8* %19, i64 0, i64 1
 %21 = load i32, i32* %20
 %22 = add i32 %15, %21
 %23 = load i32, i32* %5
 %24 = add i32 %23, %22
 store i32 %24, i32* %5
 br label %25
25:
 %26 = load i32, i32* %4
 %27 = add i32 %26, 1
 store i32 %27, i32* %4
 br label %6
28:
 %29 = load i32, i32* %5
 ret i32 %29
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo ()
 %3 = icmp ne i32 %2, 15
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
