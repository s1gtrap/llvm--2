declare void @abort()

define i32 @ieq (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 %8 = load i32, i32* %5
 %9 = load i32, i32* %6
 %10 = icmp sle i32 %8, %9
 br i1 %10, label %11, label %20
11:
 %12 = load i32, i32* %5
 %13 = load i32, i32* %6
 %14 = icmp sge i32 %12, %13
 br i1 %14, label %15, label %20
15:
 %16 = load i32, i32* %7
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %19, label %18
18:
 call void @abort ()
 unreachable
19:
 br label %25
20:
 %21 = load i32, i32* %7
 %22 = icmp ne i32 %21, 0
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 br label %25
25:
 %26 = load i32, i32* %5
 %27 = load i32, i32* %6
 %28 = icmp sle i32 %26, %27
 br i1 %28, label %29, label %38
29:
 %30 = load i32, i32* %5
 %31 = load i32, i32* %6
 %32 = icmp eq i32 %30, %31
 br i1 %32, label %33, label %38
33:
 %34 = load i32, i32* %7
 %35 = icmp ne i32 %34, 0
 br i1 %35, label %37, label %36
36:
 call void @abort ()
 unreachable
37:
 br label %43
38:
 %39 = load i32, i32* %7
 %40 = icmp ne i32 %39, 0
 br i1 %40, label %41, label %42
41:
 call void @abort ()
 unreachable
42:
 br label %43
43:
 %44 = load i32, i32* %5
 %45 = load i32, i32* %6
 %46 = icmp sle i32 %44, %45
 br i1 %46, label %47, label %56
47:
 %48 = load i32, i32* %6
 %49 = load i32, i32* %5
 %50 = icmp sle i32 %48, %49
 br i1 %50, label %51, label %56
51:
 %52 = load i32, i32* %7
 %53 = icmp ne i32 %52, 0
 br i1 %53, label %55, label %54
54:
 call void @abort ()
 unreachable
55:
 br label %61
56:
 %57 = load i32, i32* %7
 %58 = icmp ne i32 %57, 0
 br i1 %58, label %59, label %60
59:
 call void @abort ()
 unreachable
60:
 br label %61
61:
 %62 = load i32, i32* %6
 %63 = load i32, i32* %5
 %64 = icmp eq i32 %62, %63
 br i1 %64, label %65, label %74
65:
 %66 = load i32, i32* %5
 %67 = load i32, i32* %6
 %68 = icmp sle i32 %66, %67
 br i1 %68, label %69, label %74
69:
 %70 = load i32, i32* %7
 %71 = icmp ne i32 %70, 0
 br i1 %71, label %73, label %72
72:
 call void @abort ()
 unreachable
73:
 br label %79
74:
 %75 = load i32, i32* %7
 %76 = icmp ne i32 %75, 0
 br i1 %76, label %77, label %78
77:
 call void @abort ()
 unreachable
78:
 br label %79
79:
 %80 = load i32, i32* %4
 ret i32 %80
}

define i32 @ine (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 %8 = load i32, i32* %5
 %9 = load i32, i32* %6
 %10 = icmp slt i32 %8, %9
 br i1 %10, label %15, label %11
11:
 %12 = load i32, i32* %5
 %13 = load i32, i32* %6
 %14 = icmp sgt i32 %12, %13
 br i1 %14, label %15, label %20
15:
 %16 = load i32, i32* %7
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %19, label %18
18:
 call void @abort ()
 unreachable
19:
 br label %25
20:
 %21 = load i32, i32* %7
 %22 = icmp ne i32 %21, 0
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 br label %25
25:
 %26 = load i32, i32* %4
 ret i32 %26
}

define i32 @ilt (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 %8 = load i32, i32* %5
 %9 = load i32, i32* %6
 %10 = icmp slt i32 %8, %9
 br i1 %10, label %11, label %20
11:
 %12 = load i32, i32* %5
 %13 = load i32, i32* %6
 %14 = icmp ne i32 %12, %13
 br i1 %14, label %15, label %20
15:
 %16 = load i32, i32* %7
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %19, label %18
18:
 call void @abort ()
 unreachable
19:
 br label %25
20:
 %21 = load i32, i32* %7
 %22 = icmp ne i32 %21, 0
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 br label %25
25:
 %26 = load i32, i32* %4
 ret i32 %26
}

define i32 @ile (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 %8 = load i32, i32* %5
 %9 = load i32, i32* %6
 %10 = icmp slt i32 %8, %9
 br i1 %10, label %15, label %11
11:
 %12 = load i32, i32* %5
 %13 = load i32, i32* %6
 %14 = icmp eq i32 %12, %13
 br i1 %14, label %15, label %20
15:
 %16 = load i32, i32* %7
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %19, label %18
18:
 call void @abort ()
 unreachable
19:
 br label %25
20:
 %21 = load i32, i32* %7
 %22 = icmp ne i32 %21, 0
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 br label %25
25:
 %26 = load i32, i32* %4
 ret i32 %26
}

define i32 @igt (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 %8 = load i32, i32* %5
 %9 = load i32, i32* %6
 %10 = icmp sgt i32 %8, %9
 br i1 %10, label %11, label %20
11:
 %12 = load i32, i32* %5
 %13 = load i32, i32* %6
 %14 = icmp ne i32 %12, %13
 br i1 %14, label %15, label %20
15:
 %16 = load i32, i32* %7
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %19, label %18
18:
 call void @abort ()
 unreachable
19:
 br label %25
20:
 %21 = load i32, i32* %7
 %22 = icmp ne i32 %21, 0
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 br label %25
25:
 %26 = load i32, i32* %4
 ret i32 %26
}

define i32 @ige (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 %8 = load i32, i32* %5
 %9 = load i32, i32* %6
 %10 = icmp sgt i32 %8, %9
 br i1 %10, label %15, label %11
11:
 %12 = load i32, i32* %5
 %13 = load i32, i32* %6
 %14 = icmp eq i32 %12, %13
 br i1 %14, label %15, label %20
15:
 %16 = load i32, i32* %7
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %19, label %18
18:
 call void @abort ()
 unreachable
19:
 br label %25
20:
 %21 = load i32, i32* %7
 %22 = icmp ne i32 %21, 0
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 br label %25
25:
 %26 = load i32, i32* %4
 ret i32 %26
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @ieq (i32 1, i32 4, i32 0)
 %3 = call i32 @ieq (i32 3, i32 3, i32 1)
 %4 = call i32 @ieq (i32 5, i32 2, i32 0)
 %5 = call i32 @ine (i32 1, i32 4, i32 1)
 %6 = call i32 @ine (i32 3, i32 3, i32 0)
 %7 = call i32 @ine (i32 5, i32 2, i32 1)
 %8 = call i32 @ilt (i32 1, i32 4, i32 1)
 %9 = call i32 @ilt (i32 3, i32 3, i32 0)
 %10 = call i32 @ilt (i32 5, i32 2, i32 0)
 %11 = call i32 @ile (i32 1, i32 4, i32 1)
 %12 = call i32 @ile (i32 3, i32 3, i32 1)
 %13 = call i32 @ile (i32 5, i32 2, i32 0)
 %14 = call i32 @igt (i32 1, i32 4, i32 0)
 %15 = call i32 @igt (i32 3, i32 3, i32 0)
 %16 = call i32 @igt (i32 5, i32 2, i32 1)
 %17 = call i32 @ige (i32 1, i32 4, i32 0)
 %18 = call i32 @ige (i32 3, i32 3, i32 1)
 %19 = call i32 @ige (i32 5, i32 2, i32 1)
 ret i32 0
}
