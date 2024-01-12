declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 %5 = add i32 %4, 1
 %6 = mul i32 %5, 4
 %7 = icmp eq i32 %6, 0
 br i1 %7, label %8, label %9
8:
 store i32 1, i32* %2
 br label %10
9:
 store i32 0, i32* %2
 br label %10
10:
 %11 = load i32, i32* %2
 ret i32 %11
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 1073741823)
 %3 = icmp eq i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
