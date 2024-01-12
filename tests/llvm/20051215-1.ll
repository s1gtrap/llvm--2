declare void @abort()

define i32 @foo (i32 %0, i32 %1, i8* %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i8*
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i8* %2, i8** %6
 store i32 0, i32* %8
 store i32 0, i32* %7
 store i32 0, i32* %10
 br label %11
11:
 %12 = load i32, i32* %10
 %13 = load i32, i32* %5
 %14 = icmp slt i32 %12, %13
 br i1 %14, label %15, label %39
15:
 %16 = load i8*, i8** %6
 %17 = icmp ne i8* %16, null
 br i1 %17, label %18, label %23
18:
 %19 = load i32, i32* %10
 %20 = load i8*, i8** %6
 %21 = load i32, i32* %20
 %22 = mul i32 %19, %21
 store i32 %22, i32* %8
 br label %23
23:
 store i32 0, i32* %9
 br label %24
24:
 %25 = load i32, i32* %9
 %26 = load i32, i32* %4
 %27 = icmp slt i32 %25, %26
 br i1 %27, label %28, label %35
28:
 %29 = load i32, i32* %8
 %30 = load i32, i32* %7
 %31 = add i32 %30, %29
 store i32 %31, i32* %7
 br label %32
32:
 %33 = load i32, i32* %9
 %34 = add i32 %33, 1
 store i32 %34, i32* %9
 br label %24
35:
 br label %36
36:
 %37 = load i32, i32* %10
 %38 = add i32 %37, 1
 store i32 %38, i32* %10
 br label %11
39:
 %40 = load i32, i32* %7
 ret i32 %40
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 3, i32 2, i8* null)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
