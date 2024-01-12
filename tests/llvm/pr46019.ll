declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 %3 = alloca i32
 store i32 0, i32* %1
 store i64 4398046511104, i64* %2
 store i32 0, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = icmp slt i32 %5, 8
 br i1 %6, label %7, label %22
7:
 %8 = load i64, i64* %2
 %9 = load i32, i32* %3
 %10 = zext i32 %9 to i64
 %11 = shl i64 8589934592, %10
 %12 = udiv i64 %8, %11
 %13 = load i32, i32* %3
 %14 = ashr i32 512, %13
 %15 = sext i32 %14 to i64
 %16 = icmp ne i64 %12, %15
 br i1 %16, label %17, label %18
17:
 call void @abort ()
 unreachable
18:
 br label %19
19:
 %20 = load i32, i32* %3
 %21 = add i32 %20, 1
 store i32 %21, i32* %3
 br label %4
22:
 ret i32 0
}
