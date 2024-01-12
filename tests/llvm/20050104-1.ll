declare void @abort()

define void @foo (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = icmp sgt i64 %3, 10
 br i1 %4, label %9, label %5
5:
 %6 = load i64, i64* %2
 %7 = call i64 @min ()
 %8 = icmp slt i64 %6, %7
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i64 10)
 ret i32 0
}

define i64 @min () {
 ret i64 -9223372036854775808
}
