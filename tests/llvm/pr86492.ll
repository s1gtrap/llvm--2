%union.U = type { i32 }

declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca %union.U
 store i32 %0, i32* %2
 store i32 0, i32* %3
 %4 = load i32, i32* %2
 %5 = load i32, i32* %3
 %6 = and i32 %4, 65535
 %7 = shl i32 %6, 16
 %8 = and i32 %5, 65535
 %9 = or i32 %8, %7
 store i32 %9, i32* %3
 %10 = load i32, i32* %3
 %11 = and i32 %10, -61441
 %12 = or i32 %11, 57344
 store i32 %12, i32* %3
 %13 = load i32, i32* %3
 ret i32 %13
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %union.U
 store i32 0, i32* %1
 %3 = call i32 @foo (i32 114)
 store i32 %3, i32* %2
 %4 = load i32, i32* %2
 %5 = and i32 %4, 4095
 %6 = icmp ne i32 %5, 0
 br i1 %6, label %16, label %7
7:
 %8 = load i32, i32* %2
 %9 = lshr i32 %8, 12
 %10 = and i32 %9, 15
 %11 = icmp ne i32 %10, 14
 br i1 %11, label %16, label %12
12:
 %13 = load i32, i32* %2
 %14 = lshr i32 %13, 16
 %15 = icmp ne i32 %14, 114
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 ret i32 0
}
