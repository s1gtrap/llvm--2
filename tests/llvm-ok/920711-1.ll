declare void @abort()
declare void @exit(i32)

define i32 @f (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = add i64 %3, -1
 store i64 %4, i64* %2
 %5 = icmp sgt i64 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f (i64 2147483648)
 %3 = icmp eq i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 call void @exit (i32 0)
 unreachable
}
