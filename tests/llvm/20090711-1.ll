declare void @abort()

define i64 @div (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = sdiv i64 %3, 32768
 ret i64 %4
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 %3 = alloca i64
 store i32 0, i32* %1
 store i64 -990000000, i64* %2
 %4 = load i64, i64* %2
 %5 = call i64 @div (i64 %4)
 store i64 %5, i64* %3
 %6 = load i64, i64* %3
 %7 = icmp ne i64 %6, -30212
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret i32 0
}
