declare void @abort()

define void @foo (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = icmp sge i64 %3, 1024
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i64 -9223372036854775808)
 call void @foo (i64 -9223372036854765808)
 ret i32 0
}
