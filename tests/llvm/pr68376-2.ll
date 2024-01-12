declare void @abort()

define i32 @f1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp slt i32 %3, 0
 br i1 %4, label %5, label %8
5:
 %6 = load i32, i32* %2
 %7 = xor i32 %6, -1
 br label %10
8:
 %9 = load i32, i32* %2
 br label %10
10:
 %11 = phi i32 [%7, %5], [%9, %8]
 ret i32 %11
}

define i32 @f2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp slt i32 %3, 0
 br i1 %4, label %5, label %7
5:
 %6 = load i32, i32* %2
 br label %10
7:
 %8 = load i32, i32* %2
 %9 = xor i32 %8, -1
 br label %10
10:
 %11 = phi i32 [%6, %5], [%9, %7]
 ret i32 %11
}

define i32 @f3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sle i32 %3, 0
 br i1 %4, label %5, label %8
5:
 %6 = load i32, i32* %2
 %7 = xor i32 %6, -1
 br label %10
8:
 %9 = load i32, i32* %2
 br label %10
10:
 %11 = phi i32 [%7, %5], [%9, %8]
 ret i32 %11
}

define i32 @f4 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sle i32 %3, 0
 br i1 %4, label %5, label %7
5:
 %6 = load i32, i32* %2
 br label %10
7:
 %8 = load i32, i32* %2
 %9 = xor i32 %8, -1
 br label %10
10:
 %11 = phi i32 [%6, %5], [%9, %7]
 ret i32 %11
}

define i32 @f5 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sge i32 %3, 0
 br i1 %4, label %5, label %8
5:
 %6 = load i32, i32* %2
 %7 = xor i32 %6, -1
 br label %10
8:
 %9 = load i32, i32* %2
 br label %10
10:
 %11 = phi i32 [%7, %5], [%9, %8]
 ret i32 %11
}

define i32 @f6 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sge i32 %3, 0
 br i1 %4, label %5, label %7
5:
 %6 = load i32, i32* %2
 br label %10
7:
 %8 = load i32, i32* %2
 %9 = xor i32 %8, -1
 br label %10
10:
 %11 = phi i32 [%6, %5], [%9, %7]
 ret i32 %11
}

define i32 @f7 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sgt i32 %3, 0
 br i1 %4, label %5, label %8
5:
 %6 = load i32, i32* %2
 %7 = xor i32 %6, -1
 br label %10
8:
 %9 = load i32, i32* %2
 br label %10
10:
 %11 = phi i32 [%7, %5], [%9, %8]
 ret i32 %11
}

define i32 @f8 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sgt i32 %3, 0
 br i1 %4, label %5, label %7
5:
 %6 = load i32, i32* %2
 br label %10
7:
 %8 = load i32, i32* %2
 %9 = xor i32 %8, -1
 br label %10
10:
 %11 = phi i32 [%6, %5], [%9, %7]
 ret i32 %11
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f1 (i32 5)
 %3 = icmp ne i32 %2, 5
 br i1 %3, label %10, label %4
4:
 %5 = call i32 @f1 (i32 -5)
 %6 = icmp ne i32 %5, 4
 br i1 %6, label %10, label %7
7:
 %8 = call i32 @f1 (i32 0)
 %9 = icmp ne i32 %8, 0
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 %12 = call i32 @f2 (i32 5)
 %13 = icmp ne i32 %12, -6
 br i1 %13, label %20, label %14
14:
 %15 = call i32 @f2 (i32 -5)
 %16 = icmp ne i32 %15, -5
 br i1 %16, label %20, label %17
17:
 %18 = call i32 @f2 (i32 0)
 %19 = icmp ne i32 %18, -1
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i32 @f3 (i32 5)
 %23 = icmp ne i32 %22, 5
 br i1 %23, label %30, label %24
24:
 %25 = call i32 @f3 (i32 -5)
 %26 = icmp ne i32 %25, 4
 br i1 %26, label %30, label %27
27:
 %28 = call i32 @f3 (i32 0)
 %29 = icmp ne i32 %28, -1
 br i1 %29, label %30, label %31
30:
 call void @abort ()
 unreachable
31:
 %32 = call i32 @f4 (i32 5)
 %33 = icmp ne i32 %32, -6
 br i1 %33, label %40, label %34
34:
 %35 = call i32 @f4 (i32 -5)
 %36 = icmp ne i32 %35, -5
 br i1 %36, label %40, label %37
37:
 %38 = call i32 @f4 (i32 0)
 %39 = icmp ne i32 %38, 0
 br i1 %39, label %40, label %41
40:
 call void @abort ()
 unreachable
41:
 %42 = call i32 @f5 (i32 5)
 %43 = icmp ne i32 %42, -6
 br i1 %43, label %50, label %44
44:
 %45 = call i32 @f5 (i32 -5)
 %46 = icmp ne i32 %45, -5
 br i1 %46, label %50, label %47
47:
 %48 = call i32 @f5 (i32 0)
 %49 = icmp ne i32 %48, -1
 br i1 %49, label %50, label %51
50:
 call void @abort ()
 unreachable
51:
 %52 = call i32 @f6 (i32 5)
 %53 = icmp ne i32 %52, 5
 br i1 %53, label %60, label %54
54:
 %55 = call i32 @f6 (i32 -5)
 %56 = icmp ne i32 %55, 4
 br i1 %56, label %60, label %57
57:
 %58 = call i32 @f6 (i32 0)
 %59 = icmp ne i32 %58, 0
 br i1 %59, label %60, label %61
60:
 call void @abort ()
 unreachable
61:
 %62 = call i32 @f7 (i32 5)
 %63 = icmp ne i32 %62, -6
 br i1 %63, label %70, label %64
64:
 %65 = call i32 @f7 (i32 -5)
 %66 = icmp ne i32 %65, -5
 br i1 %66, label %70, label %67
67:
 %68 = call i32 @f7 (i32 0)
 %69 = icmp ne i32 %68, 0
 br i1 %69, label %70, label %71
70:
 call void @abort ()
 unreachable
71:
 %72 = call i32 @f8 (i32 5)
 %73 = icmp ne i32 %72, 5
 br i1 %73, label %80, label %74
74:
 %75 = call i32 @f8 (i32 -5)
 %76 = icmp ne i32 %75, 4
 br i1 %76, label %80, label %77
77:
 %78 = call i32 @f8 (i32 0)
 %79 = icmp ne i32 %78, -1
 br i1 %79, label %80, label %81
80:
 call void @abort ()
 unreachable
81:
 ret i32 0
}
