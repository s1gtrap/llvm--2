declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 store i32 0, i32* %3
 %4 = load i32, i32* %2
 %5 = icmp eq i32 %4, 1
 br i1 %5, label %6, label %7
6:
 store i32 1, i32* %3
 br label %7
7:
 %8 = load i32, i32* %2
 %9 = icmp eq i32 %8, 3
 br i1 %9, label %10, label %11
10:
 store i32 3, i32* %3
 br label %11
11:
 %12 = load i32, i32* %2
 %13 = icmp eq i32 %12, 4
 br i1 %13, label %14, label %15
14:
 store i32 4, i32* %3
 br label %15
15:
 %16 = load i32, i32* %3
 ret i32 %16
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 3)
 %3 = icmp ne i32 %2, 3
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
