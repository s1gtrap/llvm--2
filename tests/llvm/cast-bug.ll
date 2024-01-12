define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 1, i32* %7
 store i32 2, i32* %6
 br label %8
8:
 %9 = load i32, i32* %6
 %10 = load i32, i32* %4
 %11 = add i32 %10, 2
 %12 = icmp sle i32 %9, %11
 br i1 %12, label %13, label %24
13:
 %14 = load i32, i32* %6
 %15 = and i32 %14, 1
 %16 = icmp eq i32 %15, 0
 br i1 %16, label %17, label %20
17:
 %18 = load i32, i32* %7
 %19 = add i32 %18, 17
 store i32 %19, i32* %7
 br label %20
20:
 br label %21
21:
 %22 = load i32, i32* %6
 %23 = add i32 %22, 1
 store i32 %23, i32* %6
 br label %8
24:
 %25 = load i32, i32* %7
 %26 = icmp ne i32 %25, 35
 %27 = zext i1 %26 to i32
 ret i32 %27
}
