declare void @abort()

define i32 @f1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sub i32 %3, 1
 %5 = ashr i32 %4, 31
 %6 = or i32 2, %5
 ret i32 %6
}

define i64 @f2 (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = sub i64 %3, 1
 %5 = ashr i64 %4, 63
 %6 = or i64 2, %5
 ret i64 %6
}

define i32 @f3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = and i32 %3, 63
 store i32 %4, i32* %2
 %5 = load i32, i32* %2
 %6 = add i32 %5, 2
 %7 = ashr i32 %6, 5
 %8 = or i32 4, %7
 ret i32 %8
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f1 (i32 1)
 %3 = icmp ne i32 %2, 2
 br i1 %3, label %13, label %4
4:
 %5 = call i64 @f2 (i64 1)
 %6 = icmp ne i64 %5, 2
 br i1 %6, label %13, label %7
7:
 %8 = call i32 @f3 (i32 63)
 %9 = icmp ne i32 %8, 6
 br i1 %9, label %13, label %10
10:
 %11 = call i32 @f3 (i32 1)
 %12 = icmp ne i32 %11, 4
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 ret i32 0
}
