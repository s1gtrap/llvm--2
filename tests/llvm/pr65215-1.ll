declare void @abort()

define i32 @bar (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = load i64, i64* %3
 %5 = trunc i64 %4 to i32
 %6 = call i32 @foo (i32 %5)
 ret i32 %6
}

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 24
 %5 = load i32, i32* %2
 %6 = lshr i32 %5, 8
 %7 = and i32 %6, 65280
 %8 = or i32 %4, %7
 %9 = load i32, i32* %2
 %10 = shl i32 %9, 8
 %11 = and i32 %10, 16711680
 %12 = or i32 %8, %11
 %13 = load i32, i32* %2
 %14 = shl i32 %13, 24
 %15 = or i32 %12, %14
 ret i32 %15
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 store i32 0, i32* %1
 %3 = call i32 @foo (i32 -559038737)
 %4 = zext i32 %3 to i64
 %5 = or i64 %4, -77195989831647232
 store i64 %5, i64* %2
 %6 = call i32 @bar (i8* %2)
 %7 = icmp ne i32 %6, -559038737
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret i32 0
}
