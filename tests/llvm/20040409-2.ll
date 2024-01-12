declare void @abort()

define i32 @test1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = xor i32 %3, -2147483648
 %5 = xor i32 %4, 4660
 ret i32 %5
}

define i32 @test1u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = xor i32 %3, -2147483648
 %5 = xor i32 %4, 4660
 ret i32 %5
}

define i32 @test2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = xor i32 %3, 4660
 %5 = xor i32 %4, -2147483648
 ret i32 %5
}

define i32 @test2u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = xor i32 %3, 4660
 %5 = xor i32 %4, -2147483648
 ret i32 %5
}

define i32 @test3u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = add i32 %3, -2147483648
 %5 = xor i32 %4, 4660
 ret i32 %5
}

define i32 @test4u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = xor i32 %3, 4660
 %5 = add i32 %4, -2147483648
 ret i32 %5
}

define i32 @test5u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sub i32 %3, -2147483648
 %5 = xor i32 %4, 4660
 ret i32 %5
}

define i32 @test6u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = xor i32 %3, 4660
 %5 = sub i32 %4, -2147483648
 ret i32 %5
}

define i32 @test7 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %2
 store i32 -2147483648, i32* %3
 store i32 4660, i32* %4
 %5 = load i32, i32* %2
 %6 = load i32, i32* %3
 %7 = xor i32 %5, %6
 %8 = load i32, i32* %4
 %9 = xor i32 %7, %8
 ret i32 %9
}

define i32 @test7u (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %2
 store i32 -2147483648, i32* %3
 store i32 4660, i32* %4
 %5 = load i32, i32* %2
 %6 = load i32, i32* %3
 %7 = xor i32 %5, %6
 %8 = load i32, i32* %4
 %9 = xor i32 %7, %8
 ret i32 %9
}

define i32 @test8 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %2
 store i32 4660, i32* %3
 store i32 -2147483648, i32* %4
 %5 = load i32, i32* %2
 %6 = load i32, i32* %3
 %7 = xor i32 %5, %6
 %8 = load i32, i32* %4
 %9 = xor i32 %7, %8
 ret i32 %9
}

define i32 @test8u (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %2
 store i32 4660, i32* %3
 store i32 -2147483648, i32* %4
 %5 = load i32, i32* %2
 %6 = load i32, i32* %3
 %7 = xor i32 %5, %6
 %8 = load i32, i32* %4
 %9 = xor i32 %7, %8
 ret i32 %9
}

define i32 @test9u (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %2
 store i32 -2147483648, i32* %3
 store i32 4660, i32* %4
 %5 = load i32, i32* %2
 %6 = load i32, i32* %3
 %7 = add i32 %5, %6
 %8 = load i32, i32* %4
 %9 = xor i32 %7, %8
 ret i32 %9
}

define i32 @test10u (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %2
 store i32 4660, i32* %3
 store i32 -2147483648, i32* %4
 %5 = load i32, i32* %2
 %6 = load i32, i32* %3
 %7 = xor i32 %5, %6
 %8 = load i32, i32* %4
 %9 = add i32 %7, %8
 ret i32 %9
}

define i32 @test11u (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %2
 store i32 -2147483648, i32* %3
 store i32 4660, i32* %4
 %5 = load i32, i32* %2
 %6 = load i32, i32* %3
 %7 = sub i32 %5, %6
 %8 = load i32, i32* %4
 %9 = xor i32 %7, %8
 ret i32 %9
}

define i32 @test12u (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %2
 store i32 4660, i32* %3
 store i32 -2147483648, i32* %4
 %5 = load i32, i32* %2
 %6 = load i32, i32* %3
 %7 = xor i32 %5, %6
 %8 = load i32, i32* %4
 %9 = sub i32 %7, %8
 ret i32 %9
}

define void @test (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = call i32 @test1 (i32 %5)
 %7 = load i32, i32* %4
 %8 = icmp ne i32 %6, %7
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 %11 = load i32, i32* %3
 %12 = call i32 @test2 (i32 %11)
 %13 = load i32, i32* %4
 %14 = icmp ne i32 %12, %13
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 %17 = load i32, i32* %3
 %18 = call i32 @test7 (i32 %17)
 %19 = load i32, i32* %4
 %20 = icmp ne i32 %18, %19
 br i1 %20, label %21, label %22
21:
 call void @abort ()
 unreachable
22:
 %23 = load i32, i32* %3
 %24 = call i32 @test8 (i32 %23)
 %25 = load i32, i32* %4
 %26 = icmp ne i32 %24, %25
 br i1 %26, label %27, label %28
27:
 call void @abort ()
 unreachable
28:
 ret void
}

define void @testu (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = call i32 @test1u (i32 %5)
 %7 = load i32, i32* %4
 %8 = icmp ne i32 %6, %7
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 %11 = load i32, i32* %3
 %12 = call i32 @test2u (i32 %11)
 %13 = load i32, i32* %4
 %14 = icmp ne i32 %12, %13
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 %17 = load i32, i32* %3
 %18 = call i32 @test3u (i32 %17)
 %19 = load i32, i32* %4
 %20 = icmp ne i32 %18, %19
 br i1 %20, label %21, label %22
21:
 call void @abort ()
 unreachable
22:
 %23 = load i32, i32* %3
 %24 = call i32 @test4u (i32 %23)
 %25 = load i32, i32* %4
 %26 = icmp ne i32 %24, %25
 br i1 %26, label %27, label %28
27:
 call void @abort ()
 unreachable
28:
 %29 = load i32, i32* %3
 %30 = call i32 @test5u (i32 %29)
 %31 = load i32, i32* %4
 %32 = icmp ne i32 %30, %31
 br i1 %32, label %33, label %34
33:
 call void @abort ()
 unreachable
34:
 %35 = load i32, i32* %3
 %36 = call i32 @test6u (i32 %35)
 %37 = load i32, i32* %4
 %38 = icmp ne i32 %36, %37
 br i1 %38, label %39, label %40
39:
 call void @abort ()
 unreachable
40:
 %41 = load i32, i32* %3
 %42 = call i32 @test7u (i32 %41)
 %43 = load i32, i32* %4
 %44 = icmp ne i32 %42, %43
 br i1 %44, label %45, label %46
45:
 call void @abort ()
 unreachable
46:
 %47 = load i32, i32* %3
 %48 = call i32 @test8u (i32 %47)
 %49 = load i32, i32* %4
 %50 = icmp ne i32 %48, %49
 br i1 %50, label %51, label %52
51:
 call void @abort ()
 unreachable
52:
 %53 = load i32, i32* %3
 %54 = call i32 @test9u (i32 %53)
 %55 = load i32, i32* %4
 %56 = icmp ne i32 %54, %55
 br i1 %56, label %57, label %58
57:
 call void @abort ()
 unreachable
58:
 %59 = load i32, i32* %3
 %60 = call i32 @test10u (i32 %59)
 %61 = load i32, i32* %4
 %62 = icmp ne i32 %60, %61
 br i1 %62, label %63, label %64
63:
 call void @abort ()
 unreachable
64:
 %65 = load i32, i32* %3
 %66 = call i32 @test11u (i32 %65)
 %67 = load i32, i32* %4
 %68 = icmp ne i32 %66, %67
 br i1 %68, label %69, label %70
69:
 call void @abort ()
 unreachable
70:
 %71 = load i32, i32* %3
 %72 = call i32 @test12u (i32 %71)
 %73 = load i32, i32* %4
 %74 = icmp ne i32 %72, %73
 br i1 %74, label %75, label %76
75:
 call void @abort ()
 unreachable
76:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test (i32 0, i32 -2147478988)
 call void @test (i32 4660, i32 -2147483648)
 call void @test (i32 -2147483648, i32 4660)
 call void @test (i32 -2147478988, i32 0)
 call void @test (i32 2147483647, i32 -4661)
 call void @test (i32 -1, i32 2147478987)
 call void @testu (i32 0, i32 -2147478988)
 call void @testu (i32 4660, i32 -2147483648)
 call void @testu (i32 -2147483648, i32 4660)
 call void @testu (i32 -2147478988, i32 0)
 call void @testu (i32 2147483647, i32 -4661)
 call void @testu (i32 -1, i32 2147478987)
 ret i32 0
}
