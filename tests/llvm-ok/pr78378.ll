declare void @abort()

define i64 @foo (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = shl i64 %3, 41
 store i64 %4, i64* %2
 %5 = load i64, i64* %2
 %6 = udiv i64 %5, 232
 store i64 %6, i64* %2
 %7 = load i64, i64* %2
 %8 = trunc i64 %7 to i16
 %9 = zext i16 %8 to i32
 %10 = add i32 1, %9
 %11 = sext i32 %10 to i64
 ret i64 %11
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 store i32 0, i32* %1
 %3 = call i64 @foo (i64 1)
 store i64 %3, i64* %2
 %4 = load i64, i64* %2
 %5 = icmp ne i64 %4, 11300
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}
