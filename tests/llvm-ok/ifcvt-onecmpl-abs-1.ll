declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp slt i32 %3, 0
 br i1 %4, label %5, label %8
5:
 %6 = load i32, i32* %2
 %7 = xor i32 %6, -1
 store i32 %7, i32* %2
 br label %8
8:
 %9 = load i32, i32* %2
 ret i32 %9
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 -1)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
