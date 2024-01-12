@a = global i64 1311768466852950544
@b = global i64 1985229328

declare void @abort()

define i64 @f (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = shl i64 %3, 32
 %5 = ashr i64 %4, 32
 ret i64 %5
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i64, i64* @a
 %3 = call i64 @f (i64 %2)
 %4 = load i64, i64* @b
 %5 = icmp ne i64 %3, %4
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}
