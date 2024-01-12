@__const.main.top = global [2 x i32] [i32 -8750470, i32 -8750470]

declare void @memcpy(i8*, i8*, i64, i1)

define i32 @Predictor (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i32
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 %6 = load i8*, i8** %4
 %7 = getelementptr i32, i8* %6, i64 1
 %8 = load i32, i32* %7
 %9 = load i32, i32* %3
 %10 = load i8*, i8** %4
 %11 = getelementptr i32, i8* %10, i64 0
 %12 = load i32, i32* %11
 %13 = call i32 @Select (i32 %8, i32 %9, i32 %12)
 store i32 %13, i32* %5
 %14 = load i32, i32* %5
 ret i32 %14
}

define i32 @Select (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %8 = load i32, i32* %4
 %9 = lshr i32 %8, 8
 %10 = and i32 %9, 255
 %11 = load i32, i32* %5
 %12 = lshr i32 %11, 8
 %13 = and i32 %12, 255
 %14 = call i32 @Sub (i32 %10, i32 %13)
 %15 = load i32, i32* %4
 %16 = lshr i32 %15, 0
 %17 = and i32 %16, 255
 %18 = load i32, i32* %5
 %19 = lshr i32 %18, 0
 %20 = and i32 %19, 255
 %21 = call i32 @Sub (i32 %17, i32 %20)
 %22 = add i32 %14, %21
 store i32 %22, i32* %7
 %23 = load i32, i32* %7
 %24 = icmp sle i32 %23, 0
 br i1 %24, label %25, label %27
25:
 %26 = load i32, i32* %4
 br label %29
27:
 %28 = load i32, i32* %5
 br label %29
29:
 %30 = phi i32 [%26, %25], [%28, %27]
 ret i32 %30
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [2 x i32]
 %3 = alloca i32
 %4 = alloca i32
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.top, i64 8, i1 0)
 store i32 -8684677, i32* %3
 %5 = getelementptr [2 x i32], i8* %2, i64 0, i64 0
 %6 = call i32 @Predictor (i32 -8684677, i8* %5)
 store i32 %6, i32* %4
 %7 = load i32, i32* %4
 %8 = icmp eq i32 %7, -8684677
 br i1 %8, label %9, label %10
9:
 store i32 0, i32* %1
 br label %11
10:
 store i32 1, i32* %1
 br label %11
11:
 %12 = load i32, i32* %1
 ret i32 %12
}

define i32 @Sub (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %4
 %6 = load i32, i32* %3
 %7 = sub i32 %5, %6
 ret i32 %7
}
