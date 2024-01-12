declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i16
 %3 = alloca i16
 %4 = alloca i32
 store i32 0, i32* %1
 store i16 126, i16* %2
 store i16 -256, i16* %3
 %5 = load i16, i16* %2
 %6 = sext i16 %5 to i32
 %7 = load i16, i16* %3
 %8 = zext i16 %7 to i32
 %9 = icmp slt i32 %6, %8
 %10 = xor i1 %9, 1
 %11 = zext i1 %10 to i32
 store i32 %11, i32* %4
 %12 = load i32, i32* %4
 %13 = icmp ne i32 %12, 0
 br i1 %13, label %14, label %15
14:
 call void @abort ()
 unreachable
15:
 ret i32 0
}
