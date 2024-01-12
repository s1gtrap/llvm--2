declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 0, i32* %1
 store i32 1, i32* %2
 br label %5
5:
 %6 = load i32, i32* %2
 %7 = icmp slt i32 %6, 17
 br i1 %7, label %8, label %38
8:
 %9 = call i32 @foo (i8* %2, i32 7)
 store i32 %9, i32* %3
 %10 = load i32, i32* %2
 %11 = icmp sge i32 %10, 7
 br i1 %11, label %12, label %14
12:
 %13 = load i32, i32* %2
 store i32 %13, i32* %4
 br label %29
14:
 %15 = load i32, i32* %2
 %16 = icmp sge i32 %15, 4
 br i1 %16, label %17, label %22
17:
 %18 = load i32, i32* %2
 %19 = sub i32 %18, 4
 %20 = mul i32 %19, 2
 %21 = add i32 8, %20
 store i32 %21, i32* %4
 br label %28
22:
 %23 = load i32, i32* %2
 %24 = icmp eq i32 %23, 3
 br i1 %24, label %25, label %26
25:
 store i32 12, i32* %4
 br label %27
26:
 store i32 8, i32* %4
 br label %27
27:
 br label %28
28:
 br label %29
29:
 %30 = load i32, i32* %3
 %31 = load i32, i32* %4
 %32 = icmp ne i32 %30, %31
 br i1 %32, label %33, label %34
33:
 call void @abort ()
 unreachable
34:
 br label %35
35:
 %36 = load i32, i32* %2
 %37 = add i32 %36, 1
 store i32 %37, i32* %2
 br label %5
38:
 ret i32 0
}

define i32 @foo (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %6 = load i8*, i8** %3
 %7 = load i32, i32* %6
 store i32 %7, i32* %5
 br label %8
8:
 %9 = load i32, i32* %4
 %10 = load i32, i32* %5
 %11 = icmp sgt i32 %9, %10
 br i1 %11, label %12, label %15
12:
 %13 = load i32, i32* %5
 %14 = mul i32 %13, 2
 store i32 %14, i32* %5
 br label %8
15:
 %16 = load i32, i32* %5
 ret i32 %16
}
