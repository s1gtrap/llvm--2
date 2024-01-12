declare void @abort()

define void @foo (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %10 = load i32, i32* %4
 %11 = add i32 %10, 7
 store i32 %11, i32* %7
 %12 = load i32, i32* %5
 %13 = sub i32 %12, -2147483648
 %14 = icmp uge i32 %13, 2
 br i1 %14, label %15, label %16
15:
 unreachable
16:
 %17 = load i32, i32* %4
 %18 = load i32, i32* %6
 %19 = add i32 %17, %18
 store i32 %19, i32* %8
 %20 = load i32, i32* %4
 %21 = load i32, i32* %5
 %22 = add i32 %20, %21
 store i32 %22, i32* %9
 %23 = load i32, i32* %9
 %24 = load i32, i32* %8
 %25 = sub i32 %23, %24
 %26 = icmp ne i32 %25, 2147483647
 br i1 %26, label %27, label %28
27:
 call void @abort ()
 unreachable
28:
 ret void
}

define void @bar (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %8 = load i32, i32* %3
 %9 = add i32 %8, 7
 store i32 %9, i32* %5
 %10 = load i32, i32* %4
 %11 = sub i32 %10, -2147483648
 %12 = icmp uge i32 %11, 2
 br i1 %12, label %13, label %14
13:
 unreachable
14:
 %15 = load i32, i32* %3
 store i32 %15, i32* %6
 %16 = load i32, i32* %3
 %17 = load i32, i32* %4
 %18 = add i32 %16, %17
 store i32 %18, i32* %7
 %19 = load i32, i32* %6
 %20 = load i32, i32* %7
 %21 = sub i32 %19, %20
 %22 = icmp ne i32 %21, -2147483648
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i32 -1, i32 -2147483648, i32 1)
 call void @bar (i32 -1, i32 -2147483648)
 ret i32 0
}
