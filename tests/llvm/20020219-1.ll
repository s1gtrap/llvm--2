declare void @abort()
declare void @exit(i32)

define i64 @foo () {
 %1 = alloca i64
 %2 = alloca i64
 %3 = alloca i32
 store i64 -9223372036854775808, i64* %1
 store i32 32, i32* %3
 %4 = load i64, i64* %1
 %5 = load i32, i32* %3
 %6 = and i32 %5, 31
 %7 = zext i32 %6 to i64
 %8 = ashr i64 %4, %7
 store i64 %8, i64* %2
 %9 = load i64, i64* %2
 ret i64 %9
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i64 @foo ()
 %3 = icmp ne i64 %2, -9223372036854775808
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 call void @exit (i32 0)
 unreachable
}
