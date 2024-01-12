declare void @abort()

define i32 @foo () {
 %1 = alloca [2 x [1 x i32]]
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i32
 %5 = getelementptr [2 x [1 x i32]], i8* %1, i64 0, i64 0
 store i8* %5, i8** %2
 store i32 0, i32* %3
 %6 = getelementptr [2 x [1 x i32]], i8* %1, i64 0, i64 0
 %7 = getelementptr [1 x i32], i8* %6, i64 0, i64 0
 store i32 1, i32* %7
 %8 = getelementptr [2 x [1 x i32]], i8* %1, i64 0, i64 1
 %9 = getelementptr [1 x i32], i8* %8, i64 0, i64 0
 store i32 2, i32* %9
 store i32 0, i32* %4
 br label %10
10:
 %11 = load i32, i32* %4
 %12 = icmp slt i32 %11, 2
 br i1 %12, label %13, label %25
13:
 %14 = load i8*, i8** %2
 %15 = load i32, i32* %4
 %16 = sext i32 %15 to i64
 %17 = getelementptr [1 x i32], i8* %14, i64 %16
 %18 = getelementptr [1 x i32], i8* %17, i64 0, i64 0
 %19 = load i32, i32* %18
 %20 = load i32, i32* %3
 %21 = add i32 %20, %19
 store i32 %21, i32* %3
 br label %22
22:
 %23 = load i32, i32* %4
 %24 = add i32 %23, 1
 store i32 %24, i32* %4
 br label %10
25:
 %26 = load i32, i32* %3
 ret i32 %26
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo ()
 %3 = icmp ne i32 %2, 3
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
