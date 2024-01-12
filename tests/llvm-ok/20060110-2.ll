@a = global i64 1311768466852950544
@b = global i64 2541551395937657089
@c = global i64 -610839791

declare void @abort()

define i64 @f (i64 %0, i64 %1) {
 %3 = alloca i64
 %4 = alloca i64
 store i64 %0, i64* %3
 store i64 %1, i64* %4
 %5 = load i64, i64* %3
 %6 = load i64, i64* %4
 %7 = add i64 %5, %6
 %8 = shl i64 %7, 32
 %9 = ashr i64 %8, 32
 ret i64 %9
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i64, i64* @a
 %3 = load i64, i64* @b
 %4 = call i64 @f (i64 %2, i64 %3)
 %5 = load i64, i64* @c
 %6 = icmp ne i64 %4, %5
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
