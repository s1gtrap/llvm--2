declare void @abort()

define i32 @f0a (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = icmp ugt i64 %3, -3
 %5 = zext i1 %4 to i32
 %6 = xor i32 %5, -1
 ret i32 %6
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = call i32 @f0a (i64 -6352373499721454287)
 store i32 %3, i32* %2
 %4 = load i32, i32* %2
 %5 = icmp ne i32 %4, -1
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}
