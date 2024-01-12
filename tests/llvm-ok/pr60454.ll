declare void @abort()

define i32 @fake_swap32 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = and i32 %3, 255
 %5 = shl i32 %4, 24
 %6 = load i32, i32* %2
 %7 = and i32 %6, 65280
 %8 = shl i32 %7, 8
 %9 = or i32 %5, %8
 %10 = load i32, i32* %2
 %11 = and i32 %10, 255
 %12 = shl i32 %11, 8
 %13 = or i32 %9, %12
 %14 = load i32, i32* %2
 %15 = and i32 %14, 65280
 %16 = or i32 %13, %15
 %17 = load i32, i32* %2
 %18 = and i32 %17, -16777216
 %19 = lshr i32 %18, 24
 %20 = or i32 %16, %19
 ret i32 %20
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @fake_swap32 (i32 305419896)
 %3 = zext i32 %2 to i64
 %4 = icmp ne i64 %3, 2018934290
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret i32 0
}
