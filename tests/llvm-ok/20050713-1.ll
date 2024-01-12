%struct.S = type { i32, i32, i32 }

@__const.main.a = global %struct.S {i32 3, i32 4, i32 5}
@__const.main.b = global %struct.S {i32 6, i32 7, i32 8}
@__const.main.c = global %struct.S {i32 9, i32 10, i32 11}

declare void @memcpy(i8*, i8*, i64, i1)
declare void @abort()

define i32 @foo2 (i64 %0, i32 %1, i64 %2, i32 %3) {
 %5 = alloca %struct.S
 %6 = alloca { i64, i32 }
 %7 = alloca %struct.S
 %8 = alloca { i64, i32 }
 %9 = getelementptr { i64, i32 }, i8* %6, i32 0, i32 0
 store i64 %0, i64* %9
 %10 = getelementptr { i64, i32 }, i8* %6, i32 0, i32 1
 store i32 %1, i32* %10
 call void @memcpy (i8* %5, i8* %6, i64 12, i1 0)
 %11 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 0
 store i64 %2, i64* %11
 %12 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 1
 store i32 %3, i32* %12
 call void @memcpy (i8* %7, i8* %8, i64 12, i1 0)
 %13 = getelementptr %struct.S, i8* %5, i32 0, i32 0
 %14 = load i32, i32* %13
 %15 = icmp ne i32 %14, 3
 br i1 %15, label %24, label %16
16:
 %17 = getelementptr %struct.S, i8* %5, i32 0, i32 1
 %18 = load i32, i32* %17
 %19 = icmp ne i32 %18, 4
 br i1 %19, label %24, label %20
20:
 %21 = getelementptr %struct.S, i8* %5, i32 0, i32 2
 %22 = load i32, i32* %21
 %23 = icmp ne i32 %22, 5
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 %26 = getelementptr %struct.S, i8* %7, i32 0, i32 0
 %27 = load i32, i32* %26
 %28 = icmp ne i32 %27, 6
 br i1 %28, label %37, label %29
29:
 %30 = getelementptr %struct.S, i8* %7, i32 0, i32 1
 %31 = load i32, i32* %30
 %32 = icmp ne i32 %31, 7
 br i1 %32, label %37, label %33
33:
 %34 = getelementptr %struct.S, i8* %7, i32 0, i32 2
 %35 = load i32, i32* %34
 %36 = icmp ne i32 %35, 8
 br i1 %36, label %37, label %38
37:
 call void @abort ()
 unreachable
38:
 ret i32 0
}

define i32 @foo3 (i64 %0, i32 %1, i64 %2, i32 %3, i64 %4, i32 %5) {
 %7 = alloca %struct.S
 %8 = alloca { i64, i32 }
 %9 = alloca %struct.S
 %10 = alloca { i64, i32 }
 %11 = alloca %struct.S
 %12 = alloca { i64, i32 }
 %13 = alloca { i64, i32 }
 %14 = alloca { i64, i32 }
 %15 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 0
 store i64 %0, i64* %15
 %16 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 1
 store i32 %1, i32* %16
 call void @memcpy (i8* %7, i8* %8, i64 12, i1 0)
 %17 = getelementptr { i64, i32 }, i8* %10, i32 0, i32 0
 store i64 %2, i64* %17
 %18 = getelementptr { i64, i32 }, i8* %10, i32 0, i32 1
 store i32 %3, i32* %18
 call void @memcpy (i8* %9, i8* %10, i64 12, i1 0)
 %19 = getelementptr { i64, i32 }, i8* %12, i32 0, i32 0
 store i64 %4, i64* %19
 %20 = getelementptr { i64, i32 }, i8* %12, i32 0, i32 1
 store i32 %5, i32* %20
 call void @memcpy (i8* %11, i8* %12, i64 12, i1 0)
 call void @memcpy (i8* %13, i8* %7, i64 12, i1 0)
 %21 = getelementptr { i64, i32 }, i8* %13, i32 0, i32 0
 %22 = load i64, i64* %21
 %23 = getelementptr { i64, i32 }, i8* %13, i32 0, i32 1
 %24 = load i32, i32* %23
 call void @memcpy (i8* %14, i8* %9, i64 12, i1 0)
 %25 = getelementptr { i64, i32 }, i8* %14, i32 0, i32 0
 %26 = load i64, i64* %25
 %27 = getelementptr { i64, i32 }, i8* %14, i32 0, i32 1
 %28 = load i32, i32* %27
 %29 = call i32 @foo2 (i64 %22, i32 %24, i64 %26, i32 %28)
 %30 = getelementptr %struct.S, i8* %11, i32 0, i32 0
 %31 = load i32, i32* %30
 %32 = icmp ne i32 %31, 9
 br i1 %32, label %41, label %33
33:
 %34 = getelementptr %struct.S, i8* %11, i32 0, i32 1
 %35 = load i32, i32* %34
 %36 = icmp ne i32 %35, 10
 br i1 %36, label %41, label %37
37:
 %38 = getelementptr %struct.S, i8* %11, i32 0, i32 2
 %39 = load i32, i32* %38
 %40 = icmp ne i32 %39, 11
 br i1 %40, label %41, label %42
41:
 call void @abort ()
 unreachable
42:
 ret i32 0
}

define i32 @bar2 (i64 %0, i32 %1, i64 %2, i32 %3) {
 %5 = alloca %struct.S
 %6 = alloca { i64, i32 }
 %7 = alloca %struct.S
 %8 = alloca { i64, i32 }
 %9 = alloca { i64, i32 }
 %10 = alloca { i64, i32 }
 %11 = getelementptr { i64, i32 }, i8* %6, i32 0, i32 0
 store i64 %0, i64* %11
 %12 = getelementptr { i64, i32 }, i8* %6, i32 0, i32 1
 store i32 %1, i32* %12
 call void @memcpy (i8* %5, i8* %6, i64 12, i1 0)
 %13 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 0
 store i64 %2, i64* %13
 %14 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 1
 store i32 %3, i32* %14
 call void @memcpy (i8* %7, i8* %8, i64 12, i1 0)
 call void @memcpy (i8* %9, i8* %7, i64 12, i1 0)
 %15 = getelementptr { i64, i32 }, i8* %9, i32 0, i32 0
 %16 = load i64, i64* %15
 %17 = getelementptr { i64, i32 }, i8* %9, i32 0, i32 1
 %18 = load i32, i32* %17
 call void @memcpy (i8* %10, i8* %5, i64 12, i1 0)
 %19 = getelementptr { i64, i32 }, i8* %10, i32 0, i32 0
 %20 = load i64, i64* %19
 %21 = getelementptr { i64, i32 }, i8* %10, i32 0, i32 1
 %22 = load i32, i32* %21
 %23 = call i32 @foo2 (i64 %16, i32 %18, i64 %20, i32 %22)
 ret i32 %23
}

define i32 @bar3 (i64 %0, i32 %1, i64 %2, i32 %3, i64 %4, i32 %5) {
 %7 = alloca %struct.S
 %8 = alloca { i64, i32 }
 %9 = alloca %struct.S
 %10 = alloca { i64, i32 }
 %11 = alloca %struct.S
 %12 = alloca { i64, i32 }
 %13 = alloca { i64, i32 }
 %14 = alloca { i64, i32 }
 %15 = alloca { i64, i32 }
 %16 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 0
 store i64 %0, i64* %16
 %17 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 1
 store i32 %1, i32* %17
 call void @memcpy (i8* %7, i8* %8, i64 12, i1 0)
 %18 = getelementptr { i64, i32 }, i8* %10, i32 0, i32 0
 store i64 %2, i64* %18
 %19 = getelementptr { i64, i32 }, i8* %10, i32 0, i32 1
 store i32 %3, i32* %19
 call void @memcpy (i8* %9, i8* %10, i64 12, i1 0)
 %20 = getelementptr { i64, i32 }, i8* %12, i32 0, i32 0
 store i64 %4, i64* %20
 %21 = getelementptr { i64, i32 }, i8* %12, i32 0, i32 1
 store i32 %5, i32* %21
 call void @memcpy (i8* %11, i8* %12, i64 12, i1 0)
 call void @memcpy (i8* %13, i8* %9, i64 12, i1 0)
 %22 = getelementptr { i64, i32 }, i8* %13, i32 0, i32 0
 %23 = load i64, i64* %22
 %24 = getelementptr { i64, i32 }, i8* %13, i32 0, i32 1
 %25 = load i32, i32* %24
 call void @memcpy (i8* %14, i8* %7, i64 12, i1 0)
 %26 = getelementptr { i64, i32 }, i8* %14, i32 0, i32 0
 %27 = load i64, i64* %26
 %28 = getelementptr { i64, i32 }, i8* %14, i32 0, i32 1
 %29 = load i32, i32* %28
 call void @memcpy (i8* %15, i8* %11, i64 12, i1 0)
 %30 = getelementptr { i64, i32 }, i8* %15, i32 0, i32 0
 %31 = load i64, i64* %30
 %32 = getelementptr { i64, i32 }, i8* %15, i32 0, i32 1
 %33 = load i32, i32* %32
 %34 = call i32 @foo3 (i64 %23, i32 %25, i64 %27, i32 %29, i64 %31, i32 %33)
 ret i32 %34
}

define i32 @baz3 (i64 %0, i32 %1, i64 %2, i32 %3, i64 %4, i32 %5) {
 %7 = alloca %struct.S
 %8 = alloca { i64, i32 }
 %9 = alloca %struct.S
 %10 = alloca { i64, i32 }
 %11 = alloca %struct.S
 %12 = alloca { i64, i32 }
 %13 = alloca { i64, i32 }
 %14 = alloca { i64, i32 }
 %15 = alloca { i64, i32 }
 %16 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 0
 store i64 %0, i64* %16
 %17 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 1
 store i32 %1, i32* %17
 call void @memcpy (i8* %7, i8* %8, i64 12, i1 0)
 %18 = getelementptr { i64, i32 }, i8* %10, i32 0, i32 0
 store i64 %2, i64* %18
 %19 = getelementptr { i64, i32 }, i8* %10, i32 0, i32 1
 store i32 %3, i32* %19
 call void @memcpy (i8* %9, i8* %10, i64 12, i1 0)
 %20 = getelementptr { i64, i32 }, i8* %12, i32 0, i32 0
 store i64 %4, i64* %20
 %21 = getelementptr { i64, i32 }, i8* %12, i32 0, i32 1
 store i32 %5, i32* %21
 call void @memcpy (i8* %11, i8* %12, i64 12, i1 0)
 call void @memcpy (i8* %13, i8* %9, i64 12, i1 0)
 %22 = getelementptr { i64, i32 }, i8* %13, i32 0, i32 0
 %23 = load i64, i64* %22
 %24 = getelementptr { i64, i32 }, i8* %13, i32 0, i32 1
 %25 = load i32, i32* %24
 call void @memcpy (i8* %14, i8* %11, i64 12, i1 0)
 %26 = getelementptr { i64, i32 }, i8* %14, i32 0, i32 0
 %27 = load i64, i64* %26
 %28 = getelementptr { i64, i32 }, i8* %14, i32 0, i32 1
 %29 = load i32, i32* %28
 call void @memcpy (i8* %15, i8* %7, i64 12, i1 0)
 %30 = getelementptr { i64, i32 }, i8* %15, i32 0, i32 0
 %31 = load i64, i64* %30
 %32 = getelementptr { i64, i32 }, i8* %15, i32 0, i32 1
 %33 = load i32, i32* %32
 %34 = call i32 @foo3 (i64 %23, i32 %25, i64 %27, i32 %29, i64 %31, i32 %33)
 ret i32 %34
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.S
 %3 = alloca %struct.S
 %4 = alloca %struct.S
 %5 = alloca { i64, i32 }
 %6 = alloca { i64, i32 }
 %7 = alloca { i64, i32 }
 %8 = alloca { i64, i32 }
 %9 = alloca { i64, i32 }
 %10 = alloca { i64, i32 }
 %11 = alloca { i64, i32 }
 %12 = alloca { i64, i32 }
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.a, i64 12, i1 0)
 call void @memcpy (i8* %3, i8* @__const.main.b, i64 12, i1 0)
 call void @memcpy (i8* %4, i8* @__const.main.c, i64 12, i1 0)
 call void @memcpy (i8* %5, i8* %3, i64 12, i1 0)
 %13 = getelementptr { i64, i32 }, i8* %5, i32 0, i32 0
 %14 = load i64, i64* %13
 %15 = getelementptr { i64, i32 }, i8* %5, i32 0, i32 1
 %16 = load i32, i32* %15
 call void @memcpy (i8* %6, i8* %2, i64 12, i1 0)
 %17 = getelementptr { i64, i32 }, i8* %6, i32 0, i32 0
 %18 = load i64, i64* %17
 %19 = getelementptr { i64, i32 }, i8* %6, i32 0, i32 1
 %20 = load i32, i32* %19
 %21 = call i32 @bar2 (i64 %14, i32 %16, i64 %18, i32 %20)
 call void @memcpy (i8* %7, i8* %3, i64 12, i1 0)
 %22 = getelementptr { i64, i32 }, i8* %7, i32 0, i32 0
 %23 = load i64, i64* %22
 %24 = getelementptr { i64, i32 }, i8* %7, i32 0, i32 1
 %25 = load i32, i32* %24
 call void @memcpy (i8* %8, i8* %2, i64 12, i1 0)
 %26 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 0
 %27 = load i64, i64* %26
 %28 = getelementptr { i64, i32 }, i8* %8, i32 0, i32 1
 %29 = load i32, i32* %28
 call void @memcpy (i8* %9, i8* %4, i64 12, i1 0)
 %30 = getelementptr { i64, i32 }, i8* %9, i32 0, i32 0
 %31 = load i64, i64* %30
 %32 = getelementptr { i64, i32 }, i8* %9, i32 0, i32 1
 %33 = load i32, i32* %32
 %34 = call i32 @bar3 (i64 %23, i32 %25, i64 %27, i32 %29, i64 %31, i32 %33)
 call void @memcpy (i8* %10, i8* %4, i64 12, i1 0)
 %35 = getelementptr { i64, i32 }, i8* %10, i32 0, i32 0
 %36 = load i64, i64* %35
 %37 = getelementptr { i64, i32 }, i8* %10, i32 0, i32 1
 %38 = load i32, i32* %37
 call void @memcpy (i8* %11, i8* %2, i64 12, i1 0)
 %39 = getelementptr { i64, i32 }, i8* %11, i32 0, i32 0
 %40 = load i64, i64* %39
 %41 = getelementptr { i64, i32 }, i8* %11, i32 0, i32 1
 %42 = load i32, i32* %41
 call void @memcpy (i8* %12, i8* %3, i64 12, i1 0)
 %43 = getelementptr { i64, i32 }, i8* %12, i32 0, i32 0
 %44 = load i64, i64* %43
 %45 = getelementptr { i64, i32 }, i8* %12, i32 0, i32 1
 %46 = load i32, i32* %45
 %47 = call i32 @baz3 (i64 %36, i32 %38, i64 %40, i32 %42, i64 %44, i32 %46)
 ret i32 0
}
