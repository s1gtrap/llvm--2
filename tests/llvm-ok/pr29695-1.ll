declare void @abort()

define i32 @f1 () {
 %1 = alloca i32
 store i32 128, i32* %1
 %2 = load i32, i32* %1
 %3 = and i32 %2, 128
 %4 = icmp ne i32 %3, 0
 %5 = zext i1 %4 to i64
 %6 = select i1 %4, i32 128, i32 0
 ret i32 %6
}

define i32 @f2 () {
 %1 = alloca i8
 store i8 -128, i8* %1
 %2 = load i8, i8* %1
 %3 = zext i8 %2 to i32
 %4 = and i32 %3, 128
 %5 = icmp ne i32 %4, 0
 %6 = zext i1 %5 to i64
 %7 = select i1 %5, i32 128, i32 0
 ret i32 %7
}

define i32 @f3 () {
 %1 = alloca i8
 store i8 -128, i8* %1
 %2 = load i8, i8* %1
 %3 = zext i8 %2 to i32
 %4 = and i32 %3, 128
 %5 = icmp ne i32 %4, 0
 %6 = zext i1 %5 to i64
 %7 = select i1 %5, i32 896, i32 0
 ret i32 %7
}

define i32 @f4 () {
 %1 = alloca i8
 store i8 -128, i8* %1
 %2 = load i8, i8* %1
 %3 = zext i8 %2 to i32
 %4 = and i32 %3, 128
 %5 = icmp ne i32 %4, 0
 %6 = zext i1 %5 to i64
 %7 = select i1 %5, i32 -128, i32 0
 ret i32 %7
}

define i64 @f5 () {
 %1 = alloca i64
 store i64 2147483648, i64* %1
 %2 = load i64, i64* %1
 %3 = and i64 %2, 2147483648
 %4 = icmp ne i64 %3, 0
 %5 = zext i1 %4 to i64
 %6 = select i1 %4, i64 2147483648, i64 0
 ret i64 %6
}

define i64 @f6 () {
 %1 = alloca i32
 store i32 -2147483648, i32* %1
 %2 = load i32, i32* %1
 %3 = and i32 %2, -2147483648
 %4 = icmp ne i32 %3, 0
 %5 = zext i1 %4 to i64
 %6 = select i1 %4, i64 2147483648, i64 0
 ret i64 %6
}

define i64 @f7 () {
 %1 = alloca i32
 store i32 -2147483648, i32* %1
 %2 = load i32, i32* %1
 %3 = and i32 %2, -2147483648
 %4 = icmp ne i32 %3, 0
 %5 = zext i1 %4 to i64
 %6 = select i1 %4, i64 15032385536, i64 0
 ret i64 %6
}

define i64 @f8 () {
 %1 = alloca i32
 store i32 -2147483648, i32* %1
 %2 = load i32, i32* %1
 %3 = and i32 %2, -2147483648
 %4 = icmp ne i32 %3, 0
 %5 = zext i1 %4 to i64
 %6 = select i1 %4, i64 -2147483648, i64 0
 ret i64 %6
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f1 ()
 %3 = icmp ne i32 %2, 128
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @f2 ()
 %7 = icmp ne i32 %6, 128
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @f3 ()
 %11 = icmp ne i32 %10, 896
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @f4 ()
 %15 = icmp ne i32 %14, -128
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 %18 = call i64 @f5 ()
 %19 = icmp ne i64 %18, 2147483648
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i64 @f6 ()
 %23 = icmp ne i64 %22, 2147483648
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 %26 = call i64 @f7 ()
 %27 = icmp ne i64 %26, 15032385536
 br i1 %27, label %28, label %29
28:
 call void @abort ()
 unreachable
29:
 %30 = call i64 @f8 ()
 %31 = icmp ne i64 %30, -2147483648
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 ret i32 0
}
