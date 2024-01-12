declare void @abort()
declare void @exit(i32)

define i64 @foo (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = xor i64 %3, -1
 %5 = lshr i64 %4, 3
 %6 = and i64 %5, 1
 ret i64 %6
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i64 @foo (i64 8)
 %3 = icmp ne i64 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i64 @foo (i64 0)
 %7 = icmp ne i64 %6, 1
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 call void @exit (i32 0)
 unreachable
}
