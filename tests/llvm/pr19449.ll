@z = global i32 3
@y = global i32 0

declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 ret i32 3
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i32, i32* @y
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %10, label %4
4:
 %5 = load i32, i32* @z
 %6 = icmp ne i32 %5, 3
 br i1 %6, label %10, label %7
7:
 %8 = call i32 @foo (i32 4)
 %9 = icmp ne i32 %8, 3
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret i32 0
}
