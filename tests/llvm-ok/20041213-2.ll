declare void @abort()
declare void @exit(i32)

define void @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %2
 store i32 1, i32* %3
 store i32 0, i32* %4
 br label %6
6:
 %7 = load i32, i32* %2
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %30
9:
 %10 = load i32, i32* %3
 store i32 %10, i32* %5
 br label %11
11:
 %12 = load i32, i32* %4
 %13 = load i32, i32* %5
 %14 = icmp slt i32 %12, %13
 br i1 %14, label %15, label %21
15:
 %16 = load i32, i32* %3
 %17 = add i32 %16, 1
 store i32 %17, i32* %3
 br label %18
18:
 %19 = load i32, i32* %4
 %20 = add i32 %19, 1
 store i32 %20, i32* %4
 br label %11
21:
 %22 = load i32, i32* %4
 %23 = load i32, i32* %5
 %24 = icmp ne i32 %22, %23
 br i1 %24, label %25, label %26
25:
 call void @abort ()
 unreachable
26:
 br label %27
27:
 %28 = load i32, i32* %2
 %29 = add i32 %28, -1
 store i32 %29, i32* %2
 br label %6
30:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i32 2)
 call void @exit (i32 0)
 unreachable
}
