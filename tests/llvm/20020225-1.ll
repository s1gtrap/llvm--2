declare void @abort()
declare void @exit(i32)

define i64 @foo (i64 %0, i32 %1) {
 %3 = alloca i64
 %4 = alloca i32
 store i64 %0, i64* %3
 store i32 %1, i32* %4
 %5 = load i64, i64* %3
 %6 = load i32, i32* %4
 %7 = and i32 %6, -2147483647
 %8 = zext i32 %7 to i64
 %9 = add i64 %5, %8
 ret i64 %9
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i64 @foo (i64 0, i32 268435440)
 %3 = icmp ne i64 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 call void @exit (i32 0)
 unreachable
}
