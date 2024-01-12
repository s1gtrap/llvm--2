declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sub i32 %3, 2
 %5 = sub i32 0, %4
 %6 = icmp slt i32 %4, 0
 %7 = select i1 %6, i32 %5, i32 %4
 %8 = mul i32 -2, %7
 ret i32 %8
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 1)
 %3 = icmp ne i32 %2, -2
 br i1 %3, label %7, label %4
4:
 %5 = call i32 @foo (i32 3)
 %6 = icmp ne i32 %5, -2
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
