declare void @abort()

define i32 @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = or i32 %5, %6
 %8 = icmp eq i32 %7, 1
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 %11 = load i32, i32* %3
 ret i32 %11
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 2, i32 0)
 %3 = icmp ne i32 %2, 2
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
