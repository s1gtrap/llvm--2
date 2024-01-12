declare void @abort()

define void @check (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 store i8* %0, i8** %2
 store i32 0, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = icmp slt i32 %5, 288
 br i1 %6, label %7, label %37
7:
 %8 = load i8*, i8** %2
 %9 = load i32, i32* %3
 %10 = sext i32 %9 to i64
 %11 = getelementptr i32, i8* %8, i64 %10
 %12 = load i32, i32* %11
 %13 = load i32, i32* %3
 %14 = icmp slt i32 %13, 256
 br i1 %14, label %18, label %15
15:
 %16 = load i32, i32* %3
 %17 = icmp sge i32 %16, 280
 br label %18
18:
 %19 = phi i1 [1, %7], [%17, %15]
 %20 = zext i1 %19 to i32
 %21 = add i32 7, %20
 %22 = load i32, i32* %3
 %23 = icmp sge i32 %22, 144
 br i1 %23, label %24, label %27
24:
 %25 = load i32, i32* %3
 %26 = icmp slt i32 %25, 256
 br label %27
27:
 %28 = phi i1 [0, %18], [%26, %24]
 %29 = zext i1 %28 to i32
 %30 = add i32 %21, %29
 %31 = icmp ne i32 %12, %30
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 br label %34
34:
 %35 = load i32, i32* %3
 %36 = add i32 %35, 1
 store i32 %36, i32* %3
 br label %4
37:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca [288 x i32]
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %4
4:
 %5 = load i32, i32* %2
 %6 = icmp slt i32 %5, 144
 br i1 %6, label %7, label %14
7:
 %8 = load i32, i32* %2
 %9 = sext i32 %8 to i64
 %10 = getelementptr [288 x i32], i8* %3, i64 0, i64 %9
 store i32 8, i32* %10
 br label %11
11:
 %12 = load i32, i32* %2
 %13 = add i32 %12, 1
 store i32 %13, i32* %2
 br label %4
14:
 br label %15
15:
 %16 = load i32, i32* %2
 %17 = icmp slt i32 %16, 256
 br i1 %17, label %18, label %25
18:
 %19 = load i32, i32* %2
 %20 = sext i32 %19 to i64
 %21 = getelementptr [288 x i32], i8* %3, i64 0, i64 %20
 store i32 9, i32* %21
 br label %22
22:
 %23 = load i32, i32* %2
 %24 = add i32 %23, 1
 store i32 %24, i32* %2
 br label %15
25:
 br label %26
26:
 %27 = load i32, i32* %2
 %28 = icmp slt i32 %27, 280
 br i1 %28, label %29, label %36
29:
 %30 = load i32, i32* %2
 %31 = sext i32 %30 to i64
 %32 = getelementptr [288 x i32], i8* %3, i64 0, i64 %31
 store i32 7, i32* %32
 br label %33
33:
 %34 = load i32, i32* %2
 %35 = add i32 %34, 1
 store i32 %35, i32* %2
 br label %26
36:
 br label %37
37:
 %38 = load i32, i32* %2
 %39 = icmp slt i32 %38, 288
 br i1 %39, label %40, label %47
40:
 %41 = load i32, i32* %2
 %42 = sext i32 %41 to i64
 %43 = getelementptr [288 x i32], i8* %3, i64 0, i64 %42
 store i32 8, i32* %43
 br label %44
44:
 %45 = load i32, i32* %2
 %46 = add i32 %45, 1
 store i32 %46, i32* %2
 br label %37
47:
 %48 = getelementptr [288 x i32], i8* %3, i64 0, i64 0
 call void @check (i8* %48)
 ret i32 0
}
