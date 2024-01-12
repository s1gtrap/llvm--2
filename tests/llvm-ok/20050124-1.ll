declare void @abort()

define i32 @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %6 = load i32, i32* %3
 %7 = add i32 %6, 1
 store i32 %7, i32* %5
 %8 = load i32, i32* %4
 %9 = icmp ne i32 %8, 0
 br i1 %9, label %10, label %24
10:
 %11 = load i32, i32* %5
 %12 = icmp sgt i32 %11, 0
 br i1 %12, label %13, label %16
13:
 %14 = load i32, i32* %5
 %15 = add i32 %14, 1
 store i32 %15, i32* %5
 br label %23
16:
 %17 = load i32, i32* %5
 %18 = icmp slt i32 %17, 0
 br i1 %18, label %19, label %22
19:
 %20 = load i32, i32* %5
 %21 = add i32 %20, -1
 store i32 %21, i32* %5
 br label %22
22:
 br label %23
23:
 br label %24
24:
 %25 = load i32, i32* %5
 ret i32 %25
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 -2, i32 0)
 %3 = icmp ne i32 %2, -1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @foo (i32 -1, i32 0)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @foo (i32 0, i32 0)
 %11 = icmp ne i32 %10, 1
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @foo (i32 1, i32 0)
 %15 = icmp ne i32 %14, 2
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 %18 = call i32 @foo (i32 -2, i32 1)
 %19 = icmp ne i32 %18, -2
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i32 @foo (i32 -1, i32 1)
 %23 = icmp ne i32 %22, 0
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 %26 = call i32 @foo (i32 0, i32 1)
 %27 = icmp ne i32 %26, 2
 br i1 %27, label %28, label %29
28:
 call void @abort ()
 unreachable
29:
 %30 = call i32 @foo (i32 1, i32 1)
 %31 = icmp ne i32 %30, 3
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 ret i32 0
}
