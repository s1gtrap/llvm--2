declare void @abort()

define i32 @test1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp eq i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp eq i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp eq i32 %4, -2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test4 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp eq i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test5 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp eq i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test6 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp eq i32 %4, -2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test1 (i32 19)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @test1 (i32 20)
 %7 = icmp ne i32 %6, 1
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @test1 (i32 29)
 %11 = icmp ne i32 %10, 1
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @test1 (i32 30)
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 %18 = call i32 @test2 (i32 -10)
 %19 = icmp ne i32 %18, 0
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i32 @test2 (i32 -9)
 %23 = icmp ne i32 %22, 1
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 %26 = call i32 @test2 (i32 9)
 %27 = icmp ne i32 %26, 1
 br i1 %27, label %28, label %29
28:
 call void @abort ()
 unreachable
29:
 %30 = call i32 @test2 (i32 10)
 %31 = icmp ne i32 %30, 0
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 %34 = call i32 @test3 (i32 -30)
 %35 = icmp ne i32 %34, 0
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 %38 = call i32 @test3 (i32 -29)
 %39 = icmp ne i32 %38, 1
 br i1 %39, label %40, label %41
40:
 call void @abort ()
 unreachable
41:
 %42 = call i32 @test3 (i32 -20)
 %43 = icmp ne i32 %42, 1
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 %46 = call i32 @test3 (i32 -19)
 %47 = icmp ne i32 %46, 0
 br i1 %47, label %48, label %49
48:
 call void @abort ()
 unreachable
49:
 %50 = call i32 @test4 (i32 -30)
 %51 = icmp ne i32 %50, 0
 br i1 %51, label %52, label %53
52:
 call void @abort ()
 unreachable
53:
 %54 = call i32 @test4 (i32 -29)
 %55 = icmp ne i32 %54, 1
 br i1 %55, label %56, label %57
56:
 call void @abort ()
 unreachable
57:
 %58 = call i32 @test4 (i32 -20)
 %59 = icmp ne i32 %58, 1
 br i1 %59, label %60, label %61
60:
 call void @abort ()
 unreachable
61:
 %62 = call i32 @test4 (i32 -19)
 %63 = icmp ne i32 %62, 0
 br i1 %63, label %64, label %65
64:
 call void @abort ()
 unreachable
65:
 %66 = call i32 @test5 (i32 -10)
 %67 = icmp ne i32 %66, 0
 br i1 %67, label %68, label %69
68:
 call void @abort ()
 unreachable
69:
 %70 = call i32 @test5 (i32 -9)
 %71 = icmp ne i32 %70, 1
 br i1 %71, label %72, label %73
72:
 call void @abort ()
 unreachable
73:
 %74 = call i32 @test5 (i32 9)
 %75 = icmp ne i32 %74, 1
 br i1 %75, label %76, label %77
76:
 call void @abort ()
 unreachable
77:
 %78 = call i32 @test5 (i32 10)
 %79 = icmp ne i32 %78, 0
 br i1 %79, label %80, label %81
80:
 call void @abort ()
 unreachable
81:
 %82 = call i32 @test6 (i32 19)
 %83 = icmp ne i32 %82, 0
 br i1 %83, label %84, label %85
84:
 call void @abort ()
 unreachable
85:
 %86 = call i32 @test6 (i32 20)
 %87 = icmp ne i32 %86, 1
 br i1 %87, label %88, label %89
88:
 call void @abort ()
 unreachable
89:
 %90 = call i32 @test6 (i32 29)
 %91 = icmp ne i32 %90, 1
 br i1 %91, label %92, label %93
92:
 call void @abort ()
 unreachable
93:
 %94 = call i32 @test6 (i32 30)
 %95 = icmp ne i32 %94, 0
 br i1 %95, label %96, label %97
96:
 call void @abort ()
 unreachable
97:
 ret i32 0
}
