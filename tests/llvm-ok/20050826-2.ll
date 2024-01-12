%struct.rtattr = type { i16, i16 }

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define i32 @inet_check_attr (i8* %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i8*
 store i8* %0, i8** %4
 store i8* %1, i8** %5
 store i32 1, i32* %6
 br label %8
8:
 %9 = load i32, i32* %6
 %10 = icmp sle i32 %9, 14
 br i1 %10, label %11, label %47
11:
 %12 = load i8*, i8** %5
 %13 = load i32, i32* %6
 %14 = sub i32 %13, 1
 %15 = sext i32 %14 to i64
 %16 = getelementptr i8*, i8* %12, i64 %15
 %17 = load i8*, i8** %16
 store i8* %17, i8** %7
 %18 = load i8*, i8** %7
 %19 = icmp ne i8* %18, null
 br i1 %19, label %20, label %43
20:
 %21 = load i8*, i8** %7
 %22 = getelementptr %struct.rtattr, i8* %21, i32 0, i32 0
 %23 = load i16, i16* %22
 %24 = zext i16 %23 to i64
 %25 = sub i64 %24, 4
 %26 = icmp ult i64 %25, 4
 br i1 %26, label %27, label %28
27:
 store i32 -22, i32* %3
 br label %48
28:
 %29 = load i32, i32* %6
 %30 = icmp ne i32 %29, 9
 br i1 %30, label %31, label %42
31:
 %32 = load i32, i32* %6
 %33 = icmp ne i32 %32, 8
 br i1 %33, label %34, label %42
34:
 %35 = load i8*, i8** %7
 %36 = getelementptr %struct.rtattr, i8* %35, i64 1
 %37 = load i8*, i8** %5
 %38 = load i32, i32* %6
 %39 = sub i32 %38, 1
 %40 = sext i32 %39 to i64
 %41 = getelementptr i8*, i8* %37, i64 %40
 store i8* %36, i8** %41
 br label %42
42:
 br label %43
43:
 br label %44
44:
 %45 = load i32, i32* %6
 %46 = add i32 %45, 1
 store i32 %46, i32* %6
 br label %8
47:
 store i32 0, i32* %3
 br label %48
48:
 %49 = load i32, i32* %3
 ret i32 %49
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [2 x %struct.rtattr]
 %3 = alloca [14 x i8*]
 %4 = alloca i32
 store i32 0, i32* %1
 %5 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 0
 %6 = getelementptr %struct.rtattr, i8* %5, i32 0, i32 0
 store i16 12, i16* %6
 %7 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 0
 %8 = getelementptr %struct.rtattr, i8* %7, i32 0, i32 1
 store i16 0, i16* %8
 %9 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 1
 %10 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %9, i8* %10, i64 4, i1 0)
 store i32 0, i32* %4
 br label %11
11:
 %12 = load i32, i32* %4
 %13 = icmp slt i32 %12, 14
 br i1 %13, label %14, label %22
14:
 %15 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 0
 %16 = load i32, i32* %4
 %17 = sext i32 %16 to i64
 %18 = getelementptr [14 x i8*], i8* %3, i64 0, i64 %17
 store i8* %15, i8** %18
 br label %19
19:
 %20 = load i32, i32* %4
 %21 = add i32 %20, 1
 store i32 %21, i32* %4
 br label %11
22:
 %23 = getelementptr [14 x i8*], i8* %3, i64 0, i64 0
 %24 = call i32 @inet_check_attr (i8* null, i8* %23)
 %25 = icmp ne i32 %24, 0
 br i1 %25, label %26, label %27
26:
 call void @abort ()
 unreachable
27:
 store i32 0, i32* %4
 br label %28
28:
 %29 = load i32, i32* %4
 %30 = icmp slt i32 %29, 14
 br i1 %30, label %31, label %52
31:
 %32 = load i32, i32* %4
 %33 = sext i32 %32 to i64
 %34 = getelementptr [14 x i8*], i8* %3, i64 0, i64 %33
 %35 = load i8*, i8** %34
 %36 = load i32, i32* %4
 %37 = icmp ne i32 %36, 7
 br i1 %37, label %38, label %41
38:
 %39 = load i32, i32* %4
 %40 = icmp ne i32 %39, 8
 br label %41
41:
 %42 = phi i1 [0, %31], [%40, %38]
 %43 = zext i1 %42 to i32
 %44 = sext i32 %43 to i64
 %45 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 %44
 %46 = icmp ne i8* %35, %45
 br i1 %46, label %47, label %48
47:
 call void @abort ()
 unreachable
48:
 br label %49
49:
 %50 = load i32, i32* %4
 %51 = add i32 %50, 1
 store i32 %51, i32* %4
 br label %28
52:
 store i32 0, i32* %4
 br label %53
53:
 %54 = load i32, i32* %4
 %55 = icmp slt i32 %54, 14
 br i1 %55, label %56, label %64
56:
 %57 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 0
 %58 = load i32, i32* %4
 %59 = sext i32 %58 to i64
 %60 = getelementptr [14 x i8*], i8* %3, i64 0, i64 %59
 store i8* %57, i8** %60
 br label %61
61:
 %62 = load i32, i32* %4
 %63 = add i32 %62, 1
 store i32 %63, i32* %4
 br label %53
64:
 %65 = getelementptr [14 x i8*], i8* %3, i64 0, i64 1
 store i8* null, i8** %65
 %66 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 1
 %67 = getelementptr %struct.rtattr, i8* %66, i32 0, i32 0
 %68 = load i16, i16* %67
 %69 = zext i16 %68 to i32
 %70 = sub i32 %69, 8
 %71 = trunc i32 %70 to i16
 store i16 %71, i16* %67
 %72 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 1
 %73 = getelementptr [14 x i8*], i8* %3, i64 0, i64 5
 store i8* %72, i8** %73
 %74 = getelementptr [14 x i8*], i8* %3, i64 0, i64 0
 %75 = call i32 @inet_check_attr (i8* null, i8* %74)
 %76 = icmp ne i32 %75, -22
 br i1 %76, label %77, label %78
77:
 call void @abort ()
 unreachable
78:
 store i32 0, i32* %4
 br label %79
79:
 %80 = load i32, i32* %4
 %81 = icmp slt i32 %80, 14
 br i1 %81, label %82, label %123
82:
 %83 = load i32, i32* %4
 %84 = icmp eq i32 %83, 1
 br i1 %84, label %85, label %92
85:
 %86 = load i32, i32* %4
 %87 = sext i32 %86 to i64
 %88 = getelementptr [14 x i8*], i8* %3, i64 0, i64 %87
 %89 = load i8*, i8** %88
 %90 = icmp ne i8* %89, null
 br i1 %90, label %91, label %92
91:
 call void @abort ()
 unreachable
92:
 %93 = load i32, i32* %4
 %94 = icmp ne i32 %93, 1
 br i1 %94, label %95, label %106
95:
 %96 = load i32, i32* %4
 %97 = icmp sle i32 %96, 5
 br i1 %97, label %98, label %106
98:
 %99 = load i32, i32* %4
 %100 = sext i32 %99 to i64
 %101 = getelementptr [14 x i8*], i8* %3, i64 0, i64 %100
 %102 = load i8*, i8** %101
 %103 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 1
 %104 = icmp ne i8* %102, %103
 br i1 %104, label %105, label %106
105:
 call void @abort ()
 unreachable
106:
 %107 = load i32, i32* %4
 %108 = icmp sgt i32 %107, 5
 br i1 %108, label %109, label %117
109:
 %110 = load i32, i32* %4
 %111 = sext i32 %110 to i64
 %112 = getelementptr [14 x i8*], i8* %3, i64 0, i64 %111
 %113 = load i8*, i8** %112
 %114 = getelementptr [2 x %struct.rtattr], i8* %2, i64 0, i64 0
 %115 = icmp ne i8* %113, %114
 br i1 %115, label %116, label %117
116:
 call void @abort ()
 unreachable
117:
 br label %118
118:
 br label %119
119:
 br label %120
120:
 %121 = load i32, i32* %4
 %122 = add i32 %121, 1
 store i32 %122, i32* %4
 br label %79
123:
 ret i32 0
}
