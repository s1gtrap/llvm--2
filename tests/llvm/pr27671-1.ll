declare void @exit(i32)
declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 0, i32 1)
 call void @exit (i32 0)
 unreachable
}

define i32 @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 %7 = load i32, i32* %4
 %8 = load i32, i32* %5
 %9 = xor i32 %7, %8
 store i32 %9, i32* %6
 %10 = load i32, i32* %6
 %11 = load i32, i32* %4
 %12 = icmp eq i32 %10, %11
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 %15 = load i32, i32* %3
 ret i32 %15
}
