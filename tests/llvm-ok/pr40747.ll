declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp slt i32 %3, 4
 br i1 %4, label %5, label %10
5:
 %6 = load i32, i32* %2
 %7 = icmp sge i32 %6, 0
 br i1 %7, label %8, label %10
8:
 %9 = load i32, i32* %2
 br label %11
10:
 br label %11
11:
 %12 = phi i32 [%9, %8], [4, %10]
 ret i32 %12
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 -1)
 %3 = icmp ne i32 %2, 4
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @foo (i32 0)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @foo (i32 1)
 %11 = icmp ne i32 %10, 1
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @foo (i32 2)
 %15 = icmp ne i32 %14, 2
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 %18 = call i32 @foo (i32 3)
 %19 = icmp ne i32 %18, 3
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i32 @foo (i32 4)
 %23 = icmp ne i32 %22, 4
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 %26 = call i32 @foo (i32 5)
 %27 = icmp ne i32 %26, 4
 br i1 %27, label %28, label %29
28:
 call void @abort ()
 unreachable
29:
 ret i32 0
}
