declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 %5 = icmp ne i32 %4, 0
 br i1 %5, label %6, label %9
6:
 %7 = load i32, i32* %3
 %8 = icmp ne i32 %7, 13
 br i1 %8, label %15, label %9
9:
 %10 = load i32, i32* %3
 %11 = icmp eq i32 %10, 5
 br i1 %11, label %15, label %12
12:
 %13 = load i32, i32* %3
 %14 = icmp eq i32 %13, 20
 br i1 %14, label %15, label %16
15:
 store i32 1, i32* %2
 br label %17
16:
 store i32 -1, i32* %2
 br label %17
17:
 %18 = load i32, i32* %2
 ret i32 %18
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 -10, i32* %2
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = icmp slt i32 %4, 30
 br i1 %5, label %6, label %25
6:
 %7 = load i32, i32* %2
 %8 = call i32 @foo (i32 %7)
 %9 = load i32, i32* %2
 %10 = icmp eq i32 %9, 0
 %11 = zext i1 %10 to i32
 %12 = mul i32 2, %11
 %13 = sub i32 1, %12
 %14 = load i32, i32* %2
 %15 = icmp eq i32 %14, 13
 %16 = zext i1 %15 to i32
 %17 = mul i32 2, %16
 %18 = sub i32 %13, %17
 %19 = icmp ne i32 %8, %18
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 br label %22
22:
 %23 = load i32, i32* %2
 %24 = add i32 %23, 1
 store i32 %24, i32* %2
 br label %3
25:
 ret i32 0
}
