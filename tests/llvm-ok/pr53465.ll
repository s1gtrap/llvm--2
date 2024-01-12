@a = global [2 x i32] [i32 1, i32 2]

declare void @abort()

define void @foo (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 store i32 0, i32* %6
 store i32 0, i32* %5
 br label %9
9:
 %10 = load i32, i32* %5
 %11 = load i32, i32* %4
 %12 = icmp slt i32 %10, %11
 br i1 %12, label %13, label %35
13:
 %14 = load i8*, i8** %3
 %15 = load i32, i32* %5
 %16 = sext i32 %15 to i64
 %17 = getelementptr i32, i8* %14, i64 %16
 %18 = load i32, i32* %17
 store i32 %18, i32* %8
 %19 = load i32, i32* %8
 %20 = icmp eq i32 %19, 0
 br i1 %20, label %21, label %22
21:
 br label %35
22:
 %23 = load i32, i32* %6
 %24 = icmp ne i32 %23, 0
 br i1 %24, label %25, label %30
25:
 %26 = load i32, i32* %8
 %27 = load i32, i32* %7
 %28 = icmp sle i32 %26, %27
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 %31 = load i32, i32* %8
 store i32 %31, i32* %7
 store i32 1, i32* %6
 br label %32
32:
 %33 = load i32, i32* %5
 %34 = add i32 %33, 1
 store i32 %34, i32* %5
 br label %9
35:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i8* @a, i32 2)
 ret i32 0
}
