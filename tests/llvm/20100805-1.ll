declare void @abort()

define i32 @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %6 = load i32, i32* %3
 %7 = and i32 %6, 1
 store i32 %7, i32* %3
 store i32 0, i32* %5
 br label %8
8:
 %9 = load i32, i32* %5
 %10 = load i32, i32* %4
 %11 = icmp ult i32 %9, %10
 br i1 %11, label %12, label %21
12:
 %13 = load i32, i32* %3
 %14 = shl i32 %13, 1
 %15 = load i32, i32* %3
 %16 = lshr i32 %15, 31
 %17 = or i32 %14, %16
 store i32 %17, i32* %3
 br label %18
18:
 %19 = load i32, i32* %5
 %20 = add i32 %19, 1
 store i32 %20, i32* %5
 br label %8
21:
 %22 = load i32, i32* %3
 ret i32 %22
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 1, i32 33)
 %3 = icmp ne i32 %2, 2
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
