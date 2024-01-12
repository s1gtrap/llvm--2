declare void @abort()

define void @foo (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i32, i32* %5
 %8 = icmp slt i32 %7, -128
 br i1 %8, label %12, label %9
9:
 %10 = load i32, i32* %5
 %11 = icmp sgt i32 %10, 127
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 ret void
}

define i32 @test_neg () {
 %1 = alloca i8
 %2 = alloca i8
 %3 = alloca i32
 %4 = alloca i32
 store i32 0, i32* %4
 store i8 -128, i8* %1
 br label %5
5:
 %6 = load i8, i8* %1
 call void @fixnum_neg (i8 %6, i8* %2, i8* %3)
 %7 = load i8, i8* %1
 %8 = sext i8 %7 to i32
 %9 = load i8, i8* %2
 %10 = sext i8 %9 to i32
 %11 = load i32, i32* %3
 call void @foo (i32 %8, i32 %10, i32 %11)
 %12 = load i32, i32* %3
 %13 = icmp ne i32 %12, 0
 br i1 %13, label %14, label %18
14:
 %15 = load i8, i8* %1
 %16 = sext i8 %15 to i32
 %17 = icmp ne i32 %16, -128
 br i1 %17, label %25, label %18
18:
 %19 = load i32, i32* %3
 %20 = icmp ne i32 %19, 0
 br i1 %20, label %28, label %21
21:
 %22 = load i8, i8* %1
 %23 = sext i8 %22 to i32
 %24 = icmp eq i32 %23, -128
 br i1 %24, label %25, label %28
25:
 %26 = load i32, i32* %4
 %27 = add i32 %26, 1
 store i32 %27, i32* %4
 br label %28
28:
 %29 = load i8, i8* %1
 %30 = sext i8 %29 to i32
 %31 = icmp eq i32 %30, 127
 br i1 %31, label %32, label %33
32:
 br label %36
33:
 %34 = load i8, i8* %1
 %35 = add i8 %34, 1
 store i8 %35, i8* %1
 br label %5
36:
 %37 = load i32, i32* %4
 ret i32 %37
}

define void @fixnum_neg (i8 %0, i8* %1, i8* %2) {
 %4 = alloca i8
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i8
 %8 = alloca i8
 store i8 %0, i8* %4
 store i8* %1, i8** %5
 store i8* %2, i8** %6
 %9 = load i8, i8* %4
 store i8 %9, i8* %7
 %10 = load i8, i8* %7
 %11 = zext i8 %10 to i32
 %12 = sub i32 0, %11
 %13 = trunc i32 %12 to i8
 store i8 %13, i8* %8
 %14 = load i8, i8* %8
 %15 = zext i8 %14 to i32
 %16 = icmp sle i32 %15, 127
 br i1 %16, label %17, label %20
17:
 %18 = load i8, i8* %8
 %19 = sext i8 %18 to i32
 br label %28
20:
 %21 = load i8, i8* %8
 %22 = zext i8 %21 to i32
 %23 = sub i32 255, %22
 %24 = trunc i32 %23 to i8
 %25 = sext i8 %24 to i32
 %26 = sub i32 0, %25
 %27 = sub i32 %26, 1
 br label %28
28:
 %29 = phi i32 [%19, %17], [%27, %20]
 %30 = trunc i32 %29 to i8
 %31 = load i8*, i8** %5
 store i8 %30, i8* %31
 %32 = load i8, i8* %4
 %33 = sext i8 %32 to i32
 %34 = icmp eq i32 %33, -128
 %35 = zext i1 %34 to i64
 %36 = select i1 %34, i32 1, i32 0
 %37 = load i8*, i8** %6
 store i32 %36, i32* %37
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test_neg ()
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
