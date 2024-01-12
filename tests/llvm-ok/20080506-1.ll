declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 store i32 0, i32* %1
 store i32 -1, i32* %3
 %4 = load i32, i32* %3
 %5 = icmp sgt i32 %4, 0
 br i1 %5, label %6, label %8
6:
 %7 = load i32, i32* %3
 br label %9
8:
 br label %9
9:
 %10 = phi i32 [%7, %6], [0, %8]
 %11 = icmp ugt i32 %10, 1
 br i1 %11, label %12, label %20
12:
 %13 = load i32, i32* %3
 %14 = icmp sgt i32 %13, 0
 br i1 %14, label %15, label %17
15:
 %16 = load i32, i32* %3
 br label %18
17:
 br label %18
18:
 %19 = phi i32 [%16, %15], [0, %17]
 br label %21
20:
 br label %21
21:
 %22 = phi i32 [%19, %18], [1, %20]
 store i32 %22, i32* %2
 %23 = load i32, i32* %2
 %24 = icmp ne i32 %23, 1
 br i1 %24, label %25, label %26
25:
 call void @abort ()
 unreachable
26:
 %27 = load i32, i32* %3
 %28 = icmp sgt i32 %27, 0
 br i1 %28, label %29, label %31
29:
 %30 = load i32, i32* %3
 br label %32
31:
 br label %32
32:
 %33 = phi i32 [%30, %29], [0, %31]
 %34 = load i32, i32* %3
 %35 = icmp ult i32 %33, %34
 br i1 %35, label %36, label %44
36:
 %37 = load i32, i32* %3
 %38 = icmp sgt i32 %37, 0
 br i1 %38, label %39, label %41
39:
 %40 = load i32, i32* %3
 br label %42
41:
 br label %42
42:
 %43 = phi i32 [%40, %39], [0, %41]
 br label %46
44:
 %45 = load i32, i32* %3
 br label %46
46:
 %47 = phi i32 [%43, %42], [%45, %44]
 store i32 %47, i32* %2
 %48 = load i32, i32* %2
 %49 = icmp ne i32 %48, 0
 br i1 %49, label %50, label %51
50:
 call void @abort ()
 unreachable
51:
 ret i32 0
}
