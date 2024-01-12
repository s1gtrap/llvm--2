declare void @abort()

define void @bar (i64 %0, i64 %1) {
 %3 = alloca i64
 %4 = alloca i64
 store i64 %0, i64* %3
 store i64 %1, i64* %4
 %5 = load i64, i64* %3
 %6 = icmp ne i64 %5, 1
 br i1 %6, label %10, label %7
7:
 %8 = load i64, i64* %4
 %9 = icmp ne i64 %8, 1
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret void
}

define void @foo (i64 %0) {
 %2 = alloca i64
 %3 = alloca i64
 store i64 %0, i64* %2
 %4 = load i64, i64* %2
 %5 = icmp ne i64 %4, 0
 br i1 %5, label %7, label %6
6:
 br label %32
7:
 %8 = load i64, i64* %2
 %9 = icmp sge i64 %8, 0
 br i1 %9, label %10, label %12
10:
 %11 = load i64, i64* %2
 br label %15
12:
 %13 = load i64, i64* %2
 %14 = sub i64 0, %13
 br label %15
15:
 %16 = phi i64 [%11, %10], [%14, %12]
 store i64 %16, i64* %3
 %17 = load i64, i64* %2
 %18 = icmp sge i64 %17, 0
 br i1 %18, label %19, label %21
19:
 %20 = load i64, i64* %2
 br label %24
21:
 %22 = load i64, i64* %2
 %23 = sub i64 0, %22
 br label %24
24:
 %25 = phi i64 [%20, %19], [%23, %21]
 %26 = load i64, i64* %3
 %27 = icmp ne i64 %25, %26
 br i1 %27, label %28, label %29
28:
 call void @abort ()
 unreachable
29:
 %30 = load i64, i64* %2
 %31 = load i64, i64* %3
 call void @bar (i64 %30, i64 %31)
 br label %32
32:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i64 1)
 ret i32 0
}
