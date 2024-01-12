@a = global i64 1311768464867721216

declare void @abort()

define void @f (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = and i64 %3, 4294967295
 %5 = icmp ne i64 %4, 0
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i64, i64* @a
 call void @f (i64 %2)
 ret i32 0
}
