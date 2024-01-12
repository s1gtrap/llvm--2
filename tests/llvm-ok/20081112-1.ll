declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i32 1)
 ret i32 0
}

define void @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 %4 = load i32, i32* %2
 %5 = sub i32 %4, 1
 %6 = add i32 %5, -2147483648
 store i32 %6, i32* %3
 %7 = load i32, i32* %3
 %8 = icmp ne i32 %7, -2147483648
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}
