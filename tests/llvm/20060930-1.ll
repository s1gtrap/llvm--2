declare void @abort()

define i32 @bar (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 %6 = load i32, i32* %5
 %7 = icmp ne i32 %6, 1
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = load i32, i32* %3
 ret i32 %10
}

define void @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %8 = load i32, i32* %3
 %9 = icmp sgt i32 %8, 0
 br i1 %9, label %10, label %13
10:
 %11 = load i32, i32* %3
 %12 = sub i32 0, %11
 store i32 %12, i32* %3
 br label %13
13:
 store i32 0, i32* %5
 br label %14
14:
 %15 = load i32, i32* %5
 %16 = load i32, i32* %4
 %17 = icmp slt i32 %15, %16
 br i1 %17, label %18, label %33
18:
 %19 = load i32, i32* %3
 %20 = icmp sge i32 %19, 0
 br i1 %20, label %21, label %22
21:
 store i32 0, i32* %6
 store i32 0, i32* %7
 br label %26
22:
 %23 = load i32, i32* %3
 %24 = sub i32 0, %23
 store i32 %24, i32* %7
 %25 = load i32, i32* %7
 store i32 %25, i32* %6
 br label %26
26:
 %27 = load i32, i32* %7
 %28 = load i32, i32* %6
 %29 = call i32 @bar (i32 %27, i32 %28)
 br label %30
30:
 %31 = load i32, i32* %5
 %32 = add i32 %31, 1
 store i32 %32, i32* %5
 br label %14
33:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i32 1, i32 1)
 ret i32 0
}
