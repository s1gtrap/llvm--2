declare void @abort()

define i32 @foo (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %6 = load i8*, i8** %3
 %7 = load i32, i32* %6
 store i32 %7, i32* %5
 %8 = load i32, i32* %4
 %9 = load i32, i32* %5
 %10 = icmp sgt i32 %8, %9
 br i1 %10, label %11, label %23
11:
 %12 = load i32, i32* %4
 %13 = icmp sle i32 %12, 16
 br i1 %13, label %14, label %23
14:
 br label %15
15:
 %16 = load i32, i32* %4
 %17 = load i32, i32* %5
 %18 = icmp sgt i32 %16, %17
 br i1 %18, label %19, label %22
19:
 %20 = load i32, i32* %5
 %21 = mul i32 %20, 2
 store i32 %21, i32* %5
 br label %15
22:
 br label %23
23:
 %24 = load i32, i32* %5
 ret i32 %24
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 0, i32* %1
 store i32 1, i32* %2
 br label %5
5:
 %6 = load i32, i32* %2
 %7 = icmp slt i32 %6, 17
 br i1 %7, label %8, label %73
8:
 %9 = call i32 @foo (i8* %2, i32 16)
 store i32 %9, i32* %3
 %10 = load i32, i32* %2
 %11 = icmp sge i32 %10, 8
 br i1 %11, label %12, label %20
12:
 %13 = load i32, i32* %2
 %14 = icmp sle i32 %13, 15
 br i1 %14, label %15, label %20
15:
 %16 = load i32, i32* %2
 %17 = sub i32 %16, 8
 %18 = mul i32 %17, 2
 %19 = add i32 16, %18
 store i32 %19, i32* %4
 br label %38
20:
 %21 = load i32, i32* %2
 %22 = icmp sge i32 %21, 4
 br i1 %22, label %23, label %31
23:
 %24 = load i32, i32* %2
 %25 = icmp sle i32 %24, 7
 br i1 %25, label %26, label %31
26:
 %27 = load i32, i32* %2
 %28 = sub i32 %27, 4
 %29 = mul i32 %28, 4
 %30 = add i32 16, %29
 store i32 %30, i32* %4
 br label %37
31:
 %32 = load i32, i32* %2
 %33 = icmp eq i32 %32, 3
 br i1 %33, label %34, label %35
34:
 store i32 24, i32* %4
 br label %36
35:
 store i32 16, i32* %4
 br label %36
36:
 br label %37
37:
 br label %38
38:
 %39 = load i32, i32* %3
 %40 = load i32, i32* %4
 %41 = icmp ne i32 %39, %40
 br i1 %41, label %42, label %43
42:
 call void @abort ()
 unreachable
43:
 %44 = call i32 @foo (i8* %2, i32 7)
 store i32 %44, i32* %3
 %45 = load i32, i32* %2
 %46 = icmp sge i32 %45, 7
 br i1 %46, label %47, label %49
47:
 %48 = load i32, i32* %2
 store i32 %48, i32* %4
 br label %64
49:
 %50 = load i32, i32* %2
 %51 = icmp sge i32 %50, 4
 br i1 %51, label %52, label %57
52:
 %53 = load i32, i32* %2
 %54 = sub i32 %53, 4
 %55 = mul i32 %54, 2
 %56 = add i32 8, %55
 store i32 %56, i32* %4
 br label %63
57:
 %58 = load i32, i32* %2
 %59 = icmp eq i32 %58, 3
 br i1 %59, label %60, label %61
60:
 store i32 12, i32* %4
 br label %62
61:
 store i32 8, i32* %4
 br label %62
62:
 br label %63
63:
 br label %64
64:
 %65 = load i32, i32* %3
 %66 = load i32, i32* %4
 %67 = icmp ne i32 %65, %66
 br i1 %67, label %68, label %69
68:
 call void @abort ()
 unreachable
69:
 br label %70
70:
 %71 = load i32, i32* %2
 %72 = add i32 %71, 1
 store i32 %72, i32* %2
 br label %5
73:
 ret i32 0
}
