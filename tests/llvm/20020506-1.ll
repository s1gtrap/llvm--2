declare void @abort()

define void @test1 (i8 %0, i32 %1) {
 %3 = alloca i8
 %4 = alloca i32
 store i8 %0, i8* %3
 store i32 %1, i32* %4
 %5 = load i8, i8* %3
 %6 = sext i8 %5 to i32
 %7 = and i32 %6, 128
 %8 = icmp eq i32 %7, 0
 br i1 %8, label %9, label %14
9:
 %10 = load i32, i32* %4
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 br label %19
14:
 %15 = load i32, i32* %4
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %18, label %17
17:
 call void @abort ()
 unreachable
18:
 br label %19
19:
 %20 = load i8, i8* %3
 %21 = sext i8 %20 to i32
 %22 = and i32 %21, 128
 %23 = icmp ne i32 %22, 0
 br i1 %23, label %24, label %29
24:
 %25 = load i32, i32* %4
 %26 = icmp ne i32 %25, 0
 br i1 %26, label %28, label %27
27:
 call void @abort ()
 unreachable
28:
 br label %34
29:
 %30 = load i32, i32* %4
 %31 = icmp ne i32 %30, 0
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 br label %34
34:
 %35 = load i8, i8* %3
 %36 = sext i8 %35 to i32
 %37 = and i32 %36, 128
 %38 = icmp eq i32 %37, 128
 br i1 %38, label %39, label %44
39:
 %40 = load i32, i32* %4
 %41 = icmp ne i32 %40, 0
 br i1 %41, label %43, label %42
42:
 call void @abort ()
 unreachable
43:
 br label %49
44:
 %45 = load i32, i32* %4
 %46 = icmp ne i32 %45, 0
 br i1 %46, label %47, label %48
47:
 call void @abort ()
 unreachable
48:
 br label %49
49:
 %50 = load i8, i8* %3
 %51 = sext i8 %50 to i32
 %52 = and i32 %51, 128
 %53 = icmp ne i32 %52, 128
 br i1 %53, label %54, label %59
54:
 %55 = load i32, i32* %4
 %56 = icmp ne i32 %55, 0
 br i1 %56, label %57, label %58
57:
 call void @abort ()
 unreachable
58:
 br label %64
59:
 %60 = load i32, i32* %4
 %61 = icmp ne i32 %60, 0
 br i1 %61, label %63, label %62
62:
 call void @abort ()
 unreachable
63:
 br label %64
64:
 ret void
}

define void @test2 (i8 %0, i32 %1) {
 %3 = alloca i8
 %4 = alloca i32
 store i8 %0, i8* %3
 store i32 %1, i32* %4
 %5 = load i8, i8* %3
 %6 = zext i8 %5 to i32
 %7 = and i32 %6, 128
 %8 = icmp eq i32 %7, 0
 br i1 %8, label %9, label %14
9:
 %10 = load i32, i32* %4
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 br label %19
14:
 %15 = load i32, i32* %4
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %18, label %17
17:
 call void @abort ()
 unreachable
18:
 br label %19
19:
 %20 = load i8, i8* %3
 %21 = zext i8 %20 to i32
 %22 = and i32 %21, 128
 %23 = icmp ne i32 %22, 0
 br i1 %23, label %24, label %29
24:
 %25 = load i32, i32* %4
 %26 = icmp ne i32 %25, 0
 br i1 %26, label %28, label %27
27:
 call void @abort ()
 unreachable
28:
 br label %34
29:
 %30 = load i32, i32* %4
 %31 = icmp ne i32 %30, 0
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 br label %34
34:
 %35 = load i8, i8* %3
 %36 = zext i8 %35 to i32
 %37 = and i32 %36, 128
 %38 = icmp eq i32 %37, 128
 br i1 %38, label %39, label %44
39:
 %40 = load i32, i32* %4
 %41 = icmp ne i32 %40, 0
 br i1 %41, label %43, label %42
42:
 call void @abort ()
 unreachable
43:
 br label %49
44:
 %45 = load i32, i32* %4
 %46 = icmp ne i32 %45, 0
 br i1 %46, label %47, label %48
47:
 call void @abort ()
 unreachable
48:
 br label %49
49:
 %50 = load i8, i8* %3
 %51 = zext i8 %50 to i32
 %52 = and i32 %51, 128
 %53 = icmp ne i32 %52, 128
 br i1 %53, label %54, label %59
54:
 %55 = load i32, i32* %4
 %56 = icmp ne i32 %55, 0
 br i1 %56, label %57, label %58
57:
 call void @abort ()
 unreachable
58:
 br label %64
59:
 %60 = load i32, i32* %4
 %61 = icmp ne i32 %60, 0
 br i1 %61, label %63, label %62
62:
 call void @abort ()
 unreachable
63:
 br label %64
64:
 ret void
}

define void @test3 (i16 %0, i32 %1) {
 %3 = alloca i16
 %4 = alloca i32
 store i16 %0, i16* %3
 store i32 %1, i32* %4
 %5 = load i16, i16* %3
 %6 = sext i16 %5 to i32
 %7 = and i32 %6, 32768
 %8 = icmp eq i32 %7, 0
 br i1 %8, label %9, label %14
9:
 %10 = load i32, i32* %4
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 br label %19
14:
 %15 = load i32, i32* %4
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %18, label %17
17:
 call void @abort ()
 unreachable
18:
 br label %19
19:
 %20 = load i16, i16* %3
 %21 = sext i16 %20 to i32
 %22 = and i32 %21, 32768
 %23 = icmp ne i32 %22, 0
 br i1 %23, label %24, label %29
24:
 %25 = load i32, i32* %4
 %26 = icmp ne i32 %25, 0
 br i1 %26, label %28, label %27
27:
 call void @abort ()
 unreachable
28:
 br label %34
29:
 %30 = load i32, i32* %4
 %31 = icmp ne i32 %30, 0
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 br label %34
34:
 %35 = load i16, i16* %3
 %36 = sext i16 %35 to i32
 %37 = and i32 %36, 32768
 %38 = icmp eq i32 %37, 32768
 br i1 %38, label %39, label %44
39:
 %40 = load i32, i32* %4
 %41 = icmp ne i32 %40, 0
 br i1 %41, label %43, label %42
42:
 call void @abort ()
 unreachable
43:
 br label %49
44:
 %45 = load i32, i32* %4
 %46 = icmp ne i32 %45, 0
 br i1 %46, label %47, label %48
47:
 call void @abort ()
 unreachable
48:
 br label %49
49:
 %50 = load i16, i16* %3
 %51 = sext i16 %50 to i32
 %52 = and i32 %51, 32768
 %53 = icmp ne i32 %52, 32768
 br i1 %53, label %54, label %59
54:
 %55 = load i32, i32* %4
 %56 = icmp ne i32 %55, 0
 br i1 %56, label %57, label %58
57:
 call void @abort ()
 unreachable
58:
 br label %64
59:
 %60 = load i32, i32* %4
 %61 = icmp ne i32 %60, 0
 br i1 %61, label %63, label %62
62:
 call void @abort ()
 unreachable
63:
 br label %64
64:
 ret void
}

define void @test4 (i16 %0, i32 %1) {
 %3 = alloca i16
 %4 = alloca i32
 store i16 %0, i16* %3
 store i32 %1, i32* %4
 %5 = load i16, i16* %3
 %6 = zext i16 %5 to i32
 %7 = and i32 %6, 32768
 %8 = icmp eq i32 %7, 0
 br i1 %8, label %9, label %14
9:
 %10 = load i32, i32* %4
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 br label %19
14:
 %15 = load i32, i32* %4
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %18, label %17
17:
 call void @abort ()
 unreachable
18:
 br label %19
19:
 %20 = load i16, i16* %3
 %21 = zext i16 %20 to i32
 %22 = and i32 %21, 32768
 %23 = icmp ne i32 %22, 0
 br i1 %23, label %24, label %29
24:
 %25 = load i32, i32* %4
 %26 = icmp ne i32 %25, 0
 br i1 %26, label %28, label %27
27:
 call void @abort ()
 unreachable
28:
 br label %34
29:
 %30 = load i32, i32* %4
 %31 = icmp ne i32 %30, 0
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 br label %34
34:
 %35 = load i16, i16* %3
 %36 = zext i16 %35 to i32
 %37 = and i32 %36, 32768
 %38 = icmp eq i32 %37, 32768
 br i1 %38, label %39, label %44
39:
 %40 = load i32, i32* %4
 %41 = icmp ne i32 %40, 0
 br i1 %41, label %43, label %42
42:
 call void @abort ()
 unreachable
43:
 br label %49
44:
 %45 = load i32, i32* %4
 %46 = icmp ne i32 %45, 0
 br i1 %46, label %47, label %48
47:
 call void @abort ()
 unreachable
48:
 br label %49
49:
 %50 = load i16, i16* %3
 %51 = zext i16 %50 to i32
 %52 = and i32 %51, 32768
 %53 = icmp ne i32 %52, 32768
 br i1 %53, label %54, label %59
54:
 %55 = load i32, i32* %4
 %56 = icmp ne i32 %55, 0
 br i1 %56, label %57, label %58
57:
 call void @abort ()
 unreachable
58:
 br label %64
59:
 %60 = load i32, i32* %4
 %61 = icmp ne i32 %60, 0
 br i1 %61, label %63, label %62
62:
 call void @abort ()
 unreachable
63:
 br label %64
64:
 ret void
}

define void @test5 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = and i32 %5, -2147483648
 %7 = icmp eq i32 %6, 0
 br i1 %7, label %8, label %13
8:
 %9 = load i32, i32* %4
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 br label %18
13:
 %14 = load i32, i32* %4
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %17, label %16
16:
 call void @abort ()
 unreachable
17:
 br label %18
18:
 %19 = load i32, i32* %3
 %20 = and i32 %19, -2147483648
 %21 = icmp ne i32 %20, 0
 br i1 %21, label %22, label %27
22:
 %23 = load i32, i32* %4
 %24 = icmp ne i32 %23, 0
 br i1 %24, label %26, label %25
25:
 call void @abort ()
 unreachable
26:
 br label %32
27:
 %28 = load i32, i32* %4
 %29 = icmp ne i32 %28, 0
 br i1 %29, label %30, label %31
30:
 call void @abort ()
 unreachable
31:
 br label %32
32:
 %33 = load i32, i32* %3
 %34 = and i32 %33, -2147483648
 %35 = icmp eq i32 %34, -2147483648
 br i1 %35, label %36, label %41
36:
 %37 = load i32, i32* %4
 %38 = icmp ne i32 %37, 0
 br i1 %38, label %40, label %39
39:
 call void @abort ()
 unreachable
40:
 br label %46
41:
 %42 = load i32, i32* %4
 %43 = icmp ne i32 %42, 0
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 br label %46
46:
 %47 = load i32, i32* %3
 %48 = and i32 %47, -2147483648
 %49 = icmp ne i32 %48, -2147483648
 br i1 %49, label %50, label %55
50:
 %51 = load i32, i32* %4
 %52 = icmp ne i32 %51, 0
 br i1 %52, label %53, label %54
53:
 call void @abort ()
 unreachable
54:
 br label %60
55:
 %56 = load i32, i32* %4
 %57 = icmp ne i32 %56, 0
 br i1 %57, label %59, label %58
58:
 call void @abort ()
 unreachable
59:
 br label %60
60:
 ret void
}

define void @test6 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = and i32 %5, -2147483648
 %7 = icmp eq i32 %6, 0
 br i1 %7, label %8, label %13
8:
 %9 = load i32, i32* %4
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 br label %18
13:
 %14 = load i32, i32* %4
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %17, label %16
16:
 call void @abort ()
 unreachable
17:
 br label %18
18:
 %19 = load i32, i32* %3
 %20 = and i32 %19, -2147483648
 %21 = icmp ne i32 %20, 0
 br i1 %21, label %22, label %27
22:
 %23 = load i32, i32* %4
 %24 = icmp ne i32 %23, 0
 br i1 %24, label %26, label %25
25:
 call void @abort ()
 unreachable
26:
 br label %32
27:
 %28 = load i32, i32* %4
 %29 = icmp ne i32 %28, 0
 br i1 %29, label %30, label %31
30:
 call void @abort ()
 unreachable
31:
 br label %32
32:
 %33 = load i32, i32* %3
 %34 = and i32 %33, -2147483648
 %35 = icmp eq i32 %34, -2147483648
 br i1 %35, label %36, label %41
36:
 %37 = load i32, i32* %4
 %38 = icmp ne i32 %37, 0
 br i1 %38, label %40, label %39
39:
 call void @abort ()
 unreachable
40:
 br label %46
41:
 %42 = load i32, i32* %4
 %43 = icmp ne i32 %42, 0
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 br label %46
46:
 %47 = load i32, i32* %3
 %48 = and i32 %47, -2147483648
 %49 = icmp ne i32 %48, -2147483648
 br i1 %49, label %50, label %55
50:
 %51 = load i32, i32* %4
 %52 = icmp ne i32 %51, 0
 br i1 %52, label %53, label %54
53:
 call void @abort ()
 unreachable
54:
 br label %60
55:
 %56 = load i32, i32* %4
 %57 = icmp ne i32 %56, 0
 br i1 %57, label %59, label %58
58:
 call void @abort ()
 unreachable
59:
 br label %60
60:
 ret void
}

define void @test7 (i64 %0, i32 %1) {
 %3 = alloca i64
 %4 = alloca i32
 store i64 %0, i64* %3
 store i32 %1, i32* %4
 %5 = load i64, i64* %3
 %6 = and i64 %5, -9223372036854775808
 %7 = icmp eq i64 %6, 0
 br i1 %7, label %8, label %13
8:
 %9 = load i32, i32* %4
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 br label %18
13:
 %14 = load i32, i32* %4
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %17, label %16
16:
 call void @abort ()
 unreachable
17:
 br label %18
18:
 %19 = load i64, i64* %3
 %20 = and i64 %19, -9223372036854775808
 %21 = icmp ne i64 %20, 0
 br i1 %21, label %22, label %27
22:
 %23 = load i32, i32* %4
 %24 = icmp ne i32 %23, 0
 br i1 %24, label %26, label %25
25:
 call void @abort ()
 unreachable
26:
 br label %32
27:
 %28 = load i32, i32* %4
 %29 = icmp ne i32 %28, 0
 br i1 %29, label %30, label %31
30:
 call void @abort ()
 unreachable
31:
 br label %32
32:
 %33 = load i64, i64* %3
 %34 = and i64 %33, -9223372036854775808
 %35 = icmp eq i64 %34, -9223372036854775808
 br i1 %35, label %36, label %41
36:
 %37 = load i32, i32* %4
 %38 = icmp ne i32 %37, 0
 br i1 %38, label %40, label %39
39:
 call void @abort ()
 unreachable
40:
 br label %46
41:
 %42 = load i32, i32* %4
 %43 = icmp ne i32 %42, 0
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 br label %46
46:
 %47 = load i64, i64* %3
 %48 = and i64 %47, -9223372036854775808
 %49 = icmp ne i64 %48, -9223372036854775808
 br i1 %49, label %50, label %55
50:
 %51 = load i32, i32* %4
 %52 = icmp ne i32 %51, 0
 br i1 %52, label %53, label %54
53:
 call void @abort ()
 unreachable
54:
 br label %60
55:
 %56 = load i32, i32* %4
 %57 = icmp ne i32 %56, 0
 br i1 %57, label %59, label %58
58:
 call void @abort ()
 unreachable
59:
 br label %60
60:
 ret void
}

define void @test8 (i64 %0, i32 %1) {
 %3 = alloca i64
 %4 = alloca i32
 store i64 %0, i64* %3
 store i32 %1, i32* %4
 %5 = load i64, i64* %3
 %6 = and i64 %5, -9223372036854775808
 %7 = icmp eq i64 %6, 0
 br i1 %7, label %8, label %13
8:
 %9 = load i32, i32* %4
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 br label %18
13:
 %14 = load i32, i32* %4
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %17, label %16
16:
 call void @abort ()
 unreachable
17:
 br label %18
18:
 %19 = load i64, i64* %3
 %20 = and i64 %19, -9223372036854775808
 %21 = icmp ne i64 %20, 0
 br i1 %21, label %22, label %27
22:
 %23 = load i32, i32* %4
 %24 = icmp ne i32 %23, 0
 br i1 %24, label %26, label %25
25:
 call void @abort ()
 unreachable
26:
 br label %32
27:
 %28 = load i32, i32* %4
 %29 = icmp ne i32 %28, 0
 br i1 %29, label %30, label %31
30:
 call void @abort ()
 unreachable
31:
 br label %32
32:
 %33 = load i64, i64* %3
 %34 = and i64 %33, -9223372036854775808
 %35 = icmp eq i64 %34, -9223372036854775808
 br i1 %35, label %36, label %41
36:
 %37 = load i32, i32* %4
 %38 = icmp ne i32 %37, 0
 br i1 %38, label %40, label %39
39:
 call void @abort ()
 unreachable
40:
 br label %46
41:
 %42 = load i32, i32* %4
 %43 = icmp ne i32 %42, 0
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 br label %46
46:
 %47 = load i64, i64* %3
 %48 = and i64 %47, -9223372036854775808
 %49 = icmp ne i64 %48, -9223372036854775808
 br i1 %49, label %50, label %55
50:
 %51 = load i32, i32* %4
 %52 = icmp ne i32 %51, 0
 br i1 %52, label %53, label %54
53:
 call void @abort ()
 unreachable
54:
 br label %60
55:
 %56 = load i32, i32* %4
 %57 = icmp ne i32 %56, 0
 br i1 %57, label %59, label %58
58:
 call void @abort ()
 unreachable
59:
 br label %60
60:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test1 (i8 0, i32 0)
 call void @test1 (i8 127, i32 0)
 call void @test1 (i8 -128, i32 1)
 call void @test1 (i8 -1, i32 1)
 call void @test2 (i8 0, i32 0)
 call void @test2 (i8 127, i32 0)
 call void @test2 (i8 -128, i32 1)
 call void @test2 (i8 -1, i32 1)
 call void @test3 (i16 0, i32 0)
 call void @test3 (i16 32767, i32 0)
 call void @test3 (i16 -32768, i32 1)
 call void @test3 (i16 -1, i32 1)
 call void @test4 (i16 0, i32 0)
 call void @test4 (i16 32767, i32 0)
 call void @test4 (i16 -32768, i32 1)
 call void @test4 (i16 -1, i32 1)
 call void @test5 (i32 0, i32 0)
 call void @test5 (i32 2147483647, i32 0)
 call void @test5 (i32 -2147483648, i32 1)
 call void @test5 (i32 -1, i32 1)
 call void @test6 (i32 0, i32 0)
 call void @test6 (i32 2147483647, i32 0)
 call void @test6 (i32 -2147483648, i32 1)
 call void @test6 (i32 -1, i32 1)
 call void @test7 (i64 0, i32 0)
 call void @test7 (i64 9223372036854775807, i32 0)
 call void @test7 (i64 -9223372036854775808, i32 1)
 call void @test7 (i64 -1, i32 1)
 call void @test8 (i64 0, i32 0)
 call void @test8 (i64 9223372036854775807, i32 0)
 call void @test8 (i64 -9223372036854775808, i32 1)
 call void @test8 (i64 -1, i32 1)
 ret i32 0
}
