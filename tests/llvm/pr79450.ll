declare void @abort()

define i32 @foo (i8 %0, i64 %1) {
 %3 = alloca i8
 %4 = alloca i64
 store i8 %0, i8* %3
 store i64 %1, i64* %4
 br label %5
5:
 %6 = load i64, i64* %4
 %7 = icmp ne i64 %6, 0
 %8 = xor i1 %7, 1
 %9 = zext i1 %8 to i32
 %10 = load i8, i8* %3
 %11 = zext i8 %10 to i32
 %12 = and i32 %11, %9
 %13 = trunc i32 %12 to i8
 store i8 %13, i8* %3
 %14 = load i8, i8* %3
 %15 = zext i8 %14 to i32
 %16 = srem i32 %15, 24
 %17 = trunc i32 %16 to i8
 store i8 %17, i8* %3
 br label %18
18:
 %19 = load i8, i8* %3
 %20 = zext i8 %19 to i64
 %21 = load i64, i64* %4
 %22 = icmp ult i64 %20, %21
 br i1 %22, label %5, label %23
23:
 %24 = load i8, i8* %3
 %25 = zext i8 %24 to i64
 %26 = load i64, i64* %4
 %27 = add i64 %25, %26
 %28 = trunc i64 %27 to i32
 ret i32 %28
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = call i32 @foo (i8 1, i64 0)
 store i32 %3, i32* %2
 %4 = load i32, i32* %2
 %5 = icmp ne i32 %4, 1
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}
