declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 0, i32* %1
 store i32 32, i32* %3
 store i32 32, i32* %2
 store i32 0, i32* %5
 store i32 32, i32* %4
 %7 = load i32, i32* %3
 %8 = load i32, i32* %2
 %9 = add i32 %7, %8
 %10 = load i32, i32* %5
 %11 = load i32, i32* %4
 %12 = add i32 %10, %11
 %13 = icmp sgt i32 %9, %12
 br i1 %13, label %14, label %18
14:
 %15 = load i32, i32* %3
 %16 = load i32, i32* %2
 %17 = add i32 %15, %16
 br label %22
18:
 %19 = load i32, i32* %5
 %20 = load i32, i32* %4
 %21 = add i32 %19, %20
 br label %22
22:
 %23 = phi i32 [%17, %14], [%21, %18]
 store i32 %23, i32* %6
 %24 = load i32, i32* %6
 %25 = icmp ne i32 %24, 64
 br i1 %25, label %26, label %27
26:
 call void @abort ()
 unreachable
27:
 %28 = load i32, i32* %5
 %29 = load i32, i32* %4
 %30 = add i32 %28, %29
 %31 = load i32, i32* %3
 %32 = load i32, i32* %2
 %33 = add i32 %31, %32
 %34 = icmp sgt i32 %30, %33
 br i1 %34, label %35, label %39
35:
 %36 = load i32, i32* %5
 %37 = load i32, i32* %4
 %38 = add i32 %36, %37
 br label %43
39:
 %40 = load i32, i32* %3
 %41 = load i32, i32* %2
 %42 = add i32 %40, %41
 br label %43
43:
 %44 = phi i32 [%38, %35], [%42, %39]
 store i32 %44, i32* %6
 %45 = load i32, i32* %6
 %46 = icmp ne i32 %45, 64
 br i1 %46, label %47, label %48
47:
 call void @abort ()
 unreachable
48:
 %49 = load i32, i32* %3
 %50 = load i32, i32* %2
 %51 = add i32 %49, %50
 %52 = load i32, i32* %5
 %53 = load i32, i32* %4
 %54 = add i32 %52, %53
 %55 = icmp slt i32 %51, %54
 br i1 %55, label %56, label %60
56:
 %57 = load i32, i32* %3
 %58 = load i32, i32* %2
 %59 = add i32 %57, %58
 br label %64
60:
 %61 = load i32, i32* %5
 %62 = load i32, i32* %4
 %63 = add i32 %61, %62
 br label %64
64:
 %65 = phi i32 [%59, %56], [%63, %60]
 store i32 %65, i32* %6
 %66 = load i32, i32* %6
 %67 = icmp ne i32 %66, 32
 br i1 %67, label %68, label %69
68:
 call void @abort ()
 unreachable
69:
 %70 = load i32, i32* %5
 %71 = load i32, i32* %4
 %72 = add i32 %70, %71
 %73 = load i32, i32* %3
 %74 = load i32, i32* %2
 %75 = add i32 %73, %74
 %76 = icmp slt i32 %72, %75
 br i1 %76, label %77, label %81
77:
 %78 = load i32, i32* %5
 %79 = load i32, i32* %4
 %80 = add i32 %78, %79
 br label %85
81:
 %82 = load i32, i32* %3
 %83 = load i32, i32* %2
 %84 = add i32 %82, %83
 br label %85
85:
 %86 = phi i32 [%80, %77], [%84, %81]
 store i32 %86, i32* %6
 %87 = load i32, i32* %6
 %88 = icmp ne i32 %87, 32
 br i1 %88, label %89, label %90
89:
 call void @abort ()
 unreachable
90:
 ret i32 0
}
