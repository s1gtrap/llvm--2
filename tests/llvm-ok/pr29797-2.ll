declare void @abort()

define i64 @bar () {
 ret i64 32768
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 store i32 0, i32* %1
 %3 = call i64 @bar ()
 store i64 %3, i64* %2
 %4 = load i64, i64* %2
 %5 = and i64 %4, 32768
 %6 = icmp ne i64 %5, 0
 br i1 %6, label %7, label %10
7:
 %8 = load i64, i64* %2
 %9 = or i64 %8, 65536
 store i64 %9, i64* %2
 br label %10
10:
 %11 = load i64, i64* %2
 %12 = icmp ne i64 %11, 98304
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 ret i32 0
}
