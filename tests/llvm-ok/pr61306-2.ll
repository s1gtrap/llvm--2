declare void @abort()

define i32 @fake_bswap32 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = and i32 %3, 255
 %5 = shl i32 %4, 24
 %6 = load i32, i32* %2
 %7 = trunc i32 %6 to i16
 %8 = sext i16 %7 to i32
 %9 = and i32 %8, 16776960
 %10 = shl i32 %9, 8
 %11 = or i32 %5, %10
 %12 = load i32, i32* %2
 %13 = and i32 %12, 16711680
 %14 = lshr i32 %13, 8
 %15 = or i32 %11, %14
 %16 = load i32, i32* %2
 %17 = and i32 %16, -16777216
 %18 = lshr i32 %17, 24
 %19 = or i32 %15, %18
 ret i32 %19
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @fake_bswap32 (i32 -2122153084)
 %3 = icmp ne i32 %2, -8158591
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
