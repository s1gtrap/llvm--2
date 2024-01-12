declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = xor i32 %3, 5
 %5 = or i32 %4, 1
 %6 = xor i32 %5, 5
 %7 = or i32 %6, 1
 ret i32 %7
}

define i32 @bar (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = xor i32 %3, -6
 %5 = and i32 %4, -2
 %6 = xor i32 %5, -6
 %7 = and i32 %6, -2
 ret i32 %7
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = icmp slt i32 %4, 16
 br i1 %5, label %6, label %23
6:
 %7 = load i32, i32* %2
 %8 = call i32 @foo (i32 %7)
 %9 = load i32, i32* %2
 %10 = or i32 %9, 1
 %11 = icmp ne i32 %8, %10
 br i1 %11, label %18, label %12
12:
 %13 = load i32, i32* %2
 %14 = call i32 @bar (i32 %13)
 %15 = load i32, i32* %2
 %16 = and i32 %15, -2
 %17 = icmp ne i32 %14, %16
 br i1 %17, label %18, label %19
18:
 call void @abort ()
 unreachable
19:
 br label %20
20:
 %21 = load i32, i32* %2
 %22 = add i32 %21, 1
 store i32 %22, i32* %2
 br label %3
23:
 ret i32 0
}
