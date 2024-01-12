declare void @abort()

define i32 @fake_bswap32 (i32 %0) {
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
 %11 = and i32 %10, 16711680
 %12 = lshr i32 %11, 8
 %13 = or i32 %9, %12
 %14 = load i32, i32* %2
 %15 = and i32 %14, -16777216
 %16 = ashr i32 %15, 24
 %17 = or i32 %13, %16
 ret i32 %17
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @fake_bswap32 (i32 -2023406815)
 %3 = icmp ne i32 %2, -121
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
