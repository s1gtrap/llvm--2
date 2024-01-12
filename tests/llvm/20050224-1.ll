@a = global i64 3221225472
@b = global i64 3489660928
@c = global i64 3223042392
@d = global i64 3223732224
@e = global i64 3223879680
@f = global i64 3224191864

declare void @abort()

define void @foo (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i32, i32* %4
 %8 = icmp ne i32 %7, 245
 br i1 %8, label %15, label %9
9:
 %10 = load i32, i32* %5
 %11 = icmp ne i32 %10, 36
 br i1 %11, label %15, label %12
12:
 %13 = load i32, i32* %6
 %14 = icmp ne i32 %13, 444
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %3
 store i32 0, i32* %4
 store i32 0, i32* %5
 %6 = load i64, i64* @a
 store i64 %6, i64* %2
 br label %7
7:
 %8 = load i64, i64* %2
 %9 = load i64, i64* @b
 %10 = icmp ult i64 %8, %9
 br i1 %10, label %11, label %42
11:
 %12 = load i64, i64* %2
 %13 = load i64, i64* @c
 %14 = icmp ult i64 %12, %13
 br i1 %14, label %15, label %18
15:
 %16 = load i32, i32* %3
 %17 = add i32 %16, 1
 store i32 %17, i32* %3
 br label %38
18:
 %19 = load i64, i64* %2
 %20 = load i64, i64* @d
 %21 = icmp uge i64 %19, %20
 br i1 %21, label %22, label %29
22:
 %23 = load i64, i64* %2
 %24 = load i64, i64* @e
 %25 = icmp ult i64 %23, %24
 br i1 %25, label %26, label %29
26:
 %27 = load i32, i32* %5
 %28 = add i32 %27, 1
 store i32 %28, i32* %5
 br label %37
29:
 %30 = load i64, i64* %2
 %31 = load i64, i64* @f
 %32 = icmp ult i64 %30, %31
 br i1 %32, label %33, label %36
33:
 %34 = load i32, i32* %4
 %35 = add i32 %34, 1
 store i32 %35, i32* %4
 br label %36
36:
 br label %37
37:
 br label %38
38:
 br label %39
39:
 %40 = load i64, i64* %2
 %41 = add i64 %40, 4096
 store i64 %41, i64* %2
 br label %7
42:
 %43 = load i32, i32* %4
 %44 = load i32, i32* %5
 %45 = load i32, i32* %3
 call void @foo (i32 %43, i32 %44, i32 %45)
 ret i32 0
}
