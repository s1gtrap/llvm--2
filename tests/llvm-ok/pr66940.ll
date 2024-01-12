declare void @abort()

define i64 @foo (i64 %0) {
 %2 = alloca i64
 %3 = alloca i64
 store i64 %0, i64* %3
 %4 = load i64, i64* %3
 %5 = icmp sle i64 %4, 0
 br i1 %5, label %6, label %7
6:
 store i64 -9223372036854775808, i64* %2
 br label %8
7:
 store i64 9223372036854775807, i64* %2
 br label %8
8:
 %9 = load i64, i64* %2
 ret i64 %9
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i64 @foo (i64 -1)
 %3 = icmp ne i64 %2, -9223372036854775808
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i64 @foo (i64 1)
 %7 = icmp ne i64 %6, 9223372036854775807
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret i32 0
}
