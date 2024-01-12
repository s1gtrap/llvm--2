declare void @abort()

define i64 @f1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sext i32 %3 to i64
 %5 = shl i64 %4, 4
 ret i64 %5
}

define i64 @f2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = zext i32 %3 to i64
 %5 = shl i64 %4, 4
 ret i64 %5
}

define i64 @f3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = zext i32 %3 to i64
 %5 = shl i64 %4, 4
 ret i64 %5
}

define i64 @f4 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sext i32 %3 to i64
 %5 = shl i64 %4, 4
 ret i64 %5
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i64 @f1 (i32 -268435456)
 %3 = icmp ne i64 %2, -4294967296
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i64 @f2 (i32 -268435456)
 %7 = icmp ne i64 %6, 64424509440
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i64 @f3 (i32 -268435456)
 %11 = icmp ne i64 %10, 64424509440
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i64 @f4 (i32 -268435456)
 %15 = icmp ne i64 %14, -4294967296
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 ret i32 0
}
