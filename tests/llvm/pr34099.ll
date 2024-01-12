declare void @abort()

define i32 @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 %7 = load i32, i32* %4
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %13
9:
 %10 = load i32, i32* %6
 %11 = load i32, i32* %5
 %12 = and i32 %10, %11
 store i32 %12, i32* %3
 br label %14
13:
 store i32 1, i32* %3
 br label %14
14:
 %15 = load i32, i32* %3
 ret i32 %15
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 1, i32 0)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
