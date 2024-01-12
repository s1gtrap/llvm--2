declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = add i32 %3, 1
 %5 = add i32 %4, 1
 %6 = load i32, i32* %2
 %7 = icmp slt i32 %5, %6
 %8 = zext i1 %7 to i32
 ret i32 %8
}

define i32 @bar (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = add i32 %3, 1
 %5 = add i32 %4, 1
 ret i32 %5
}

define i32 @baz (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = add i32 %3, 1
 ret i32 %4
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 2147483647)
 %3 = call i32 @bar (i32 2147483647)
 %4 = icmp slt i32 %3, 2147483647
 %5 = zext i1 %4 to i32
 %6 = icmp ne i32 %2, %5
 br i1 %6, label %14, label %7
7:
 %8 = call i32 @foo (i32 2147483647)
 %9 = call i32 @baz (i32 2147483647)
 %10 = add i32 %9, 1
 %11 = icmp slt i32 %10, 2147483647
 %12 = zext i1 %11 to i32
 %13 = icmp ne i32 %8, %12
 br i1 %13, label %14, label %15
14:
 call void @abort ()
 unreachable
15:
 ret i32 0
}
