declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i64
 store i32 %0, i32* %2
 %4 = load i32, i32* %2
 %5 = zext i32 %4 to i64
 %6 = lshr i64 -1, %5
 store i64 %6, i64* %3
 %7 = load i64, i64* %3
 %8 = trunc i64 %7 to i32
 %9 = lshr i32 %8, 31
 ret i32 %9
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 15)
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %10, label %4
4:
 %5 = call i32 @foo (i32 32)
 %6 = icmp ne i32 %5, 1
 br i1 %6, label %10, label %7
7:
 %8 = call i32 @foo (i32 33)
 %9 = icmp ne i32 %8, 0
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret i32 0
}
