declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 2
 %5 = or i32 %4, 4
 ret i32 %5
}

define i32 @bar (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 2
 %5 = or i32 %4, 3
 ret i32 %5
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 43)
 %3 = icmp ne i32 %2, 172
 br i1 %3, label %10, label %4
4:
 %5 = call i32 @foo (i32 1)
 %6 = icmp ne i32 %5, 4
 br i1 %6, label %10, label %7
7:
 %8 = call i32 @foo (i32 2)
 %9 = icmp ne i32 %8, 12
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 %12 = call i32 @bar (i32 43)
 %13 = icmp ne i32 %12, 175
 br i1 %13, label %20, label %14
14:
 %15 = call i32 @bar (i32 1)
 %16 = icmp ne i32 %15, 7
 br i1 %16, label %20, label %17
17:
 %18 = call i32 @bar (i32 2)
 %19 = icmp ne i32 %18, 11
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 ret i32 0
}
