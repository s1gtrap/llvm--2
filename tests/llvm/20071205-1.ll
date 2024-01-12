declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 8
 %5 = and i32 %4, 65535
 %6 = or i32 %5, 255
 ret i32 %6
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 50)
 %3 = icmp ne i32 %2, 13055
 br i1 %3, label %7, label %4
4:
 %5 = call i32 @foo (i32 372)
 %6 = icmp ne i32 %5, 29951
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
