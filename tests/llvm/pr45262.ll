declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp slt i32 %3, 0
 br i1 %4, label %9, label %5
5:
 %6 = load i32, i32* %2
 %7 = sub i32 0, %6
 %8 = icmp slt i32 %7, 0
 br label %9
9:
 %10 = phi i1 [1, %1], [%8, %5]
 %11 = zext i1 %10 to i32
 ret i32 %11
}

define i32 @bar (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 31
 %5 = icmp ne i32 %4, 0
 br i1 %5, label %11, label %6
6:
 %7 = load i32, i32* %2
 %8 = sub i32 0, %7
 %9 = lshr i32 %8, 31
 %10 = icmp ne i32 %9, 0
 br label %11
11:
 %12 = phi i1 [1, %1], [%10, %6]
 %13 = zext i1 %12 to i32
 ret i32 %13
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 1)
 %3 = icmp ne i32 %2, 1
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
 %10 = call i32 @foo (i32 -1)
 %11 = icmp ne i32 %10, 1
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @bar (i32 1)
 %15 = icmp ne i32 %14, 1
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 %18 = call i32 @bar (i32 0)
 %19 = icmp ne i32 %18, 0
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i32 @bar (i32 -1)
 %23 = icmp ne i32 %22, 1
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 ret i32 0
}
