@a = global i64 -1

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i64, i64* @a
 %3 = call i64 @llabs (i64 %2)
 %4 = icmp ne i64 %3, 1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret i32 0
}

define i64 @llabs (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 call void @abort ()
 unreachable
}
