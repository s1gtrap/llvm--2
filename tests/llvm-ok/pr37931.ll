declare void @abort()

define i32 @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = or i32 %5, 1
 %7 = load i32, i32* %4
 %8 = or i32 %7, 1
 %9 = and i32 %6, %8
 ret i32 %9
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 6, i32 198)
 %3 = icmp ne i32 %2, 7
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @foo (i32 128, i32 193)
 %7 = icmp ne i32 %6, 129
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @foo (i32 4, i32 4)
 %11 = icmp ne i32 %10, 5
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @foo (i32 5, i32 4)
 %15 = icmp ne i32 %14, 5
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 ret i32 0
}
