declare void @abort()

define i64 @foo (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 br label %3
3:
 %4 = load i64, i64* %2
 %5 = icmp sgt i64 %4, -4
 br i1 %5, label %6, label %9
6:
 %7 = load i64, i64* %2
 %8 = sub i64 %7, 2
 store i64 %8, i64* %2
 br label %3
9:
 %10 = load i64, i64* %2
 ret i64 %10
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i64 @foo (i64 0)
 %3 = icmp ne i64 %2, -4
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
