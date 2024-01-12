declare void @abort()

define i64 @foo (i64 %0, i64 %1) {
 %3 = alloca i64
 %4 = alloca i64
 %5 = alloca i64
 store i64 %0, i64* %4
 store i64 %1, i64* %5
 %6 = load i64, i64* %4
 %7 = trunc i64 %6 to i32
 %8 = load i64, i64* %5
 %9 = trunc i64 %8 to i32
 %10 = or i32 %7, %9
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %13
12:
 store i64 6, i64* %3
 br label %17
13:
 %14 = load i64, i64* %4
 %15 = load i64, i64* %5
 %16 = add i64 %14, %15
 store i64 %16, i64* %3
 br label %17
17:
 %18 = load i64, i64* %3
 ret i64 %18
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i64
 %4 = alloca i64
 %5 = alloca i64
 store i32 0, i32* %1
 store i32 16, i32* %2
 %6 = load i32, i32* %2
 %7 = zext i32 %6 to i64
 %8 = shl i64 3, %7
 %9 = load i32, i32* %2
 %10 = zext i32 %9 to i64
 %11 = shl i64 %8, %10
 store i64 %11, i64* %3
 %12 = load i32, i32* %2
 %13 = zext i32 %12 to i64
 %14 = shl i64 5, %13
 %15 = load i32, i32* %2
 %16 = zext i32 %15 to i64
 %17 = shl i64 %14, %16
 store i64 %17, i64* %4
 %18 = load i64, i64* %3
 %19 = load i64, i64* %4
 %20 = call i64 @foo (i64 %18, i64 %19)
 store i64 %20, i64* %5
 %21 = load i64, i64* %5
 %22 = load i32, i32* %2
 %23 = zext i32 %22 to i64
 %24 = shl i64 8, %23
 %25 = load i32, i32* %2
 %26 = zext i32 %25 to i64
 %27 = shl i64 %24, %26
 %28 = icmp ne i64 %21, %27
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 ret i32 0
}
