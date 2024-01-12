declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i64
 %5 = alloca i64
 %6 = alloca i64
 store i32 0, i32* %1
 store i32 -16, i32* %2
 store i32 1, i32* %3
 %7 = load i32, i32* %2
 %8 = load i32, i32* %3
 %9 = add i32 %7, %8
 %10 = sext i32 %9 to i64
 store i64 %10, i64* %4
 %11 = load i64, i64* %4
 %12 = lshr i64 %11, 1
 store i64 %12, i64* %5
 %13 = load i32, i32* %2
 %14 = load i32, i32* %3
 %15 = add i32 %13, %14
 %16 = sext i32 %15 to i64
 %17 = lshr i64 %16, 1
 store i64 %17, i64* %6
 %18 = load i64, i64* %5
 %19 = load i64, i64* %6
 %20 = icmp ne i64 %18, %19
 br i1 %20, label %21, label %22
21:
 call void @abort ()
 unreachable
22:
 ret i32 0
}
