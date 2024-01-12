declare void @abort()

define i16 @foo (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = trunc i64 %3 to i16
 ret i16 %4
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 store i32 0, i32* %1
 store i64 272170, i64* %2
 %3 = load i64, i64* %2
 %4 = call i16 @foo (i64 %3)
 %5 = sext i16 %4 to i64
 %6 = load i64, i64* %2
 %7 = icmp eq i64 %5, %6
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret i32 0
}
