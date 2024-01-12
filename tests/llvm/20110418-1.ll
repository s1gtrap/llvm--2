declare void @abort()

define void @f (i8* %0, i64 %1) {
 %3 = alloca i8*
 %4 = alloca i64
 %5 = alloca i64
 %6 = alloca i64
 %7 = alloca i32
 %8 = alloca i64
 %9 = alloca i64
 store i8* %0, i8** %3
 store i64 %1, i64* %4
 %10 = load i64, i64* %4
 store i64 %10, i64* %5
 %11 = load i8*, i8** %3
 %12 = load i64, i64* %11
 store i64 %12, i64* %6
 store i32 32, i32* %7
 store i64 4294967295, i64* %8
 %13 = load i64, i64* %6
 %14 = load i64, i64* %8
 %15 = and i64 %13, %14
 store i64 %15, i64* %9
 %16 = load i64, i64* %8
 %17 = load i64, i64* %5
 %18 = and i64 %17, %16
 store i64 %18, i64* %5
 %19 = load i64, i64* %9
 %20 = load i64, i64* %5
 %21 = icmp ugt i64 %19, %20
 br i1 %21, label %22, label %28
22:
 %23 = load i32, i32* %7
 %24 = zext i32 %23 to i64
 %25 = shl i64 1, %24
 %26 = load i64, i64* %5
 %27 = add i64 %26, %25
 store i64 %27, i64* %5
 br label %28
28:
 %29 = load i64, i64* %6
 %30 = load i64, i64* %8
 %31 = xor i64 %30, -1
 %32 = and i64 %29, %31
 %33 = load i64, i64* %5
 %34 = add i64 %33, %32
 store i64 %34, i64* %5
 %35 = load i64, i64* %5
 %36 = load i8*, i8** %3
 store i64 %35, i64* %36
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 %3 = alloca i64
 %4 = alloca i64
 store i32 0, i32* %1
 store i64 4294967297, i64* %2
 %5 = load i64, i64* %2
 store i64 %5, i64* %4
 %6 = load i64, i64* %2
 %7 = add i64 %6, 1
 %8 = and i64 %7, 4294967295
 store i64 %8, i64* %3
 %9 = load i64, i64* %3
 call void @f (i8* %2, i64 %9)
 %10 = load i64, i64* %2
 %11 = load i64, i64* %4
 %12 = add i64 %11, 1
 %13 = icmp ne i64 %10, %12
 br i1 %13, label %14, label %15
14:
 call void @abort ()
 unreachable
15:
 ret i32 0
}
