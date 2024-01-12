declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = zext i32 %3 to i64
 %5 = ashr i64 1513049092259536159, %4
 %6 = trunc i64 %5 to i32
 %7 = ashr i32 %6, 4
 ret i32 %7
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 1)
 %3 = icmp ne i32 %2, 4119272
 br i1 %3, label %7, label %4
4:
 %5 = call i32 @foo (i32 2)
 %6 = icmp ne i32 %5, -132158092
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
