declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = xor i32 %3, -1
 %5 = sext i32 %4 to i64
 %6 = and i64 %5, 4102790424
 %7 = icmp sgt i64 %6, 0
 %8 = zext i1 %7 to i32
 %9 = or i32 %8, 6
 ret i32 %9
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 0)
 %3 = icmp ne i32 %2, 7
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
