declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 %5 = load i32, i32* %3
 %6 = and i32 %5, 63
 store i32 %6, i32* %3
 %7 = load i32, i32* %3
 %8 = sub i32 %7, 50
 store i32 %8, i32* %3
 %9 = load i32, i32* %3
 %10 = or i32 %9, 1
 store i32 %10, i32* %3
 %11 = load i32, i32* %3
 %12 = icmp slt i32 %11, 0
 br i1 %12, label %13, label %14
13:
 store i32 1, i32* %2
 br label %22
14:
 %15 = load i32, i32* %3
 %16 = ashr i32 %15, 2
 store i32 %16, i32* %4
 %17 = load i32, i32* %3
 %18 = load i32, i32* %4
 %19 = icmp sge i32 %17, %18
 br i1 %19, label %20, label %21
20:
 store i32 1, i32* %2
 br label %22
21:
 store i32 0, i32* %2
 br label %22
22:
 %23 = load i32, i32* %2
 ret i32 %23
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = icmp slt i32 %4, 63
 br i1 %5, label %6, label %15
6:
 %7 = load i32, i32* %2
 %8 = call i32 @foo (i32 %7)
 %9 = icmp ne i32 %8, 1
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 br label %12
12:
 %13 = load i32, i32* %2
 %14 = add i32 %13, 1
 store i32 %14, i32* %2
 br label %3
15:
 ret i32 0
}
