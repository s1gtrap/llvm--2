declare void @abort()

define void @DisplayNumber (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = icmp ne i64 %3, 154
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret void
}

define i64 @ReadNumber () {
 ret i64 10092544
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 store i32 0, i32* %1
 %3 = call i64 @ReadNumber ()
 %4 = and i64 %3, 16711680
 %5 = lshr i64 %4, 16
 store i64 %5, i64* %2
 %6 = load i64, i64* %2
 call void @DisplayNumber (i64 %6)
 ret i32 0
}
