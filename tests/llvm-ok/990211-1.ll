declare void @abort()

define void @func (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp slt i32 %3, 0
 br i1 %4, label %5, label %9
5:
 %6 = load i32, i32* %2
 %7 = icmp sge i32 %6, 0
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = load i32, i32* %2
 %11 = icmp sgt i32 %10, 0
 br i1 %11, label %12, label %16
12:
 %13 = load i32, i32* %2
 %14 = icmp sle i32 %13, 0
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 %17 = load i32, i32* %2
 %18 = icmp sge i32 %17, 0
 br i1 %18, label %19, label %23
19:
 %20 = load i32, i32* %2
 %21 = icmp slt i32 %20, 0
 br i1 %21, label %22, label %23
22:
 call void @abort ()
 unreachable
23:
 %24 = load i32, i32* %2
 %25 = icmp sle i32 %24, 0
 br i1 %25, label %26, label %30
26:
 %27 = load i32, i32* %2
 %28 = icmp sgt i32 %27, 0
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 %31 = load i32, i32* %2
 %32 = icmp slt i32 %31, 77
 br i1 %32, label %33, label %37
33:
 %34 = load i32, i32* %2
 %35 = icmp sge i32 %34, 77
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 %38 = load i32, i32* %2
 %39 = icmp sgt i32 %38, 77
 br i1 %39, label %40, label %44
40:
 %41 = load i32, i32* %2
 %42 = icmp sle i32 %41, 77
 br i1 %42, label %43, label %44
43:
 call void @abort ()
 unreachable
44:
 %45 = load i32, i32* %2
 %46 = icmp sge i32 %45, 77
 br i1 %46, label %47, label %51
47:
 %48 = load i32, i32* %2
 %49 = icmp slt i32 %48, 77
 br i1 %49, label %50, label %51
50:
 call void @abort ()
 unreachable
51:
 %52 = load i32, i32* %2
 %53 = icmp sle i32 %52, 77
 br i1 %53, label %54, label %58
54:
 %55 = load i32, i32* %2
 %56 = icmp sgt i32 %55, 77
 br i1 %56, label %57, label %58
57:
 call void @abort ()
 unreachable
58:
 %59 = load i32, i32* %2
 %60 = icmp slt i32 %59, 0
 br i1 %60, label %65, label %61
61:
 %62 = load i32, i32* %2
 %63 = icmp sge i32 %62, 0
 br i1 %63, label %65, label %64
64:
 call void @abort ()
 unreachable
65:
 %66 = load i32, i32* %2
 %67 = icmp sgt i32 %66, 0
 br i1 %67, label %72, label %68
68:
 %69 = load i32, i32* %2
 %70 = icmp sle i32 %69, 0
 br i1 %70, label %72, label %71
71:
 call void @abort ()
 unreachable
72:
 %73 = load i32, i32* %2
 %74 = icmp sge i32 %73, 0
 br i1 %74, label %79, label %75
75:
 %76 = load i32, i32* %2
 %77 = icmp slt i32 %76, 0
 br i1 %77, label %79, label %78
78:
 call void @abort ()
 unreachable
79:
 %80 = load i32, i32* %2
 %81 = icmp sle i32 %80, 0
 br i1 %81, label %86, label %82
82:
 %83 = load i32, i32* %2
 %84 = icmp sgt i32 %83, 0
 br i1 %84, label %86, label %85
85:
 call void @abort ()
 unreachable
86:
 %87 = load i32, i32* %2
 %88 = icmp slt i32 %87, 77
 br i1 %88, label %93, label %89
89:
 %90 = load i32, i32* %2
 %91 = icmp sge i32 %90, 77
 br i1 %91, label %93, label %92
92:
 call void @abort ()
 unreachable
93:
 %94 = load i32, i32* %2
 %95 = icmp sgt i32 %94, 77
 br i1 %95, label %100, label %96
96:
 %97 = load i32, i32* %2
 %98 = icmp sle i32 %97, 77
 br i1 %98, label %100, label %99
99:
 call void @abort ()
 unreachable
100:
 %101 = load i32, i32* %2
 %102 = icmp sge i32 %101, 77
 br i1 %102, label %107, label %103
103:
 %104 = load i32, i32* %2
 %105 = icmp slt i32 %104, 77
 br i1 %105, label %107, label %106
106:
 call void @abort ()
 unreachable
107:
 %108 = load i32, i32* %2
 %109 = icmp sle i32 %108, 77
 br i1 %109, label %114, label %110
110:
 %111 = load i32, i32* %2
 %112 = icmp sgt i32 %111, 77
 br i1 %112, label %114, label %113
113:
 call void @abort ()
 unreachable
114:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @func (i32 0)
 call void @func (i32 1)
 ret i32 0
}
