%struct.one = type { i32, i8, i16, i8 }
%struct.two = type { i32, i8, i32, i8 }
%struct.three = type { i16, i16, i8 }
%struct.four = type { i16, [2 x i8], i8, [3 x i8] }
%struct.five = type { i8, i8, i8 }
%struct.six = type { i8, [3 x i8], i8, i8, [2 x i8] }
%struct.seven = type { i8, i8, i8 }
%struct.eight = type { i16, i8 }
%union.nine = type { i64 }
%struct.ten = type { i64, i8 }

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [16 x i8]
 %3 = alloca %struct.one
 %4 = alloca %struct.two
 %5 = alloca %struct.three
 %6 = alloca %struct.four
 %7 = alloca %struct.five
 %8 = alloca %struct.six
 %9 = alloca %struct.seven
 %10 = alloca %struct.eight
 %11 = alloca %union.nine
 %12 = alloca %struct.ten
 %13 = alloca i64
 %14 = alloca i64
 %15 = alloca i64
 %16 = alloca i64
 %17 = alloca i64
 %18 = alloca i64
 %19 = alloca i64
 %20 = alloca i64
 %21 = alloca i64
 %22 = alloca i64
 %23 = alloca i8
 %24 = alloca i8
 %25 = alloca i8
 %26 = alloca i8
 %27 = alloca i8
 %28 = alloca i8
 %29 = alloca i8
 %30 = alloca i8
 %31 = alloca i8
 %32 = alloca i8
 %33 = alloca i8
 store i32 0, i32* %1
 store i64 12, i64* %13
 store i64 16, i64* %14
 store i64 6, i64* %15
 store i64 8, i64* %16
 store i64 3, i64* %17
 store i64 8, i64* %18
 store i64 3, i64* %19
 store i64 4, i64* %20
 store i64 8, i64* %21
 store i64 16, i64* %22
 store i8 8, i8* %23
 store i8 12, i8* %24
 store i8 4, i8* %25
 store i8 4, i8* %26
 store i8 2, i8* %27
 store i8 5, i8* %28
 store i8 2, i8* %29
 store i8 2, i8* %30
 store i8 0, i8* %31
 store i8 8, i8* %32
 store i8 0, i8* %33
 br label %34
34:
 %35 = load i8, i8* %33
 %36 = zext i8 %35 to i32
 %37 = icmp slt i32 %36, 16
 br i1 %37, label %38, label %46
38:
 %39 = load i8, i8* %33
 %40 = load i8, i8* %33
 %41 = zext i8 %40 to i64
 %42 = getelementptr [16 x i8], i8* %2, i64 0, i64 %41
 store i8 %39, i8* %42
 br label %43
43:
 %44 = load i8, i8* %33
 %45 = add i8 %44, 1
 store i8 %45, i8* %33
 br label %34
46:
 %47 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %3, i8* %47, i64 12, i1 0)
 %48 = getelementptr %struct.one, i8* %3, i32 0, i32 3
 %49 = load i8, i8* %48
 %50 = sext i8 %49 to i32
 %51 = load i8, i8* %23
 %52 = zext i8 %51 to i32
 %53 = icmp ne i32 %50, %52
 br i1 %53, label %54, label %55
54:
 call void @abort ()
 unreachable
55:
 %56 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %4, i8* %56, i64 16, i1 0)
 %57 = getelementptr %struct.two, i8* %4, i32 0, i32 3
 %58 = load i8, i8* %57
 %59 = sext i8 %58 to i32
 %60 = load i8, i8* %24
 %61 = zext i8 %60 to i32
 %62 = icmp ne i32 %59, %61
 br i1 %62, label %63, label %64
63:
 call void @abort ()
 unreachable
64:
 %65 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %5, i8* %65, i64 6, i1 0)
 %66 = getelementptr %struct.three, i8* %5, i32 0, i32 2
 %67 = load i8, i8* %66
 %68 = and i8 %67, 127
 %69 = zext i8 %68 to i32
 %70 = load i8, i8* %25
 %71 = zext i8 %70 to i32
 %72 = icmp ne i32 %69, %71
 br i1 %72, label %73, label %74
73:
 call void @abort ()
 unreachable
74:
 %75 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %6, i8* %75, i64 8, i1 0)
 %76 = getelementptr %struct.four, i8* %6, i32 0, i32 2
 %77 = load i8, i8* %76
 %78 = and i8 %77, 127
 %79 = zext i8 %78 to i32
 %80 = load i8, i8* %26
 %81 = zext i8 %80 to i32
 %82 = icmp ne i32 %79, %81
 br i1 %82, label %83, label %84
83:
 call void @abort ()
 unreachable
84:
 %85 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %7, i8* %85, i64 3, i1 0)
 %86 = getelementptr %struct.five, i8* %7, i32 0, i32 2
 %87 = load i8, i8* %86
 %88 = sext i8 %87 to i32
 %89 = load i8, i8* %27
 %90 = sext i8 %89 to i32
 %91 = icmp ne i32 %88, %90
 br i1 %91, label %92, label %93
92:
 call void @abort ()
 unreachable
93:
 %94 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %8, i8* %94, i64 8, i1 0)
 %95 = getelementptr %struct.six, i8* %8, i32 0, i32 3
 %96 = load i8, i8* %95
 %97 = sext i8 %96 to i32
 %98 = load i8, i8* %28
 %99 = sext i8 %98 to i32
 %100 = icmp ne i32 %97, %99
 br i1 %100, label %101, label %102
101:
 call void @abort ()
 unreachable
102:
 %103 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %9, i8* %103, i64 3, i1 0)
 %104 = getelementptr %struct.seven, i8* %9, i32 0, i32 2
 %105 = load i8, i8* %104
 %106 = sext i8 %105 to i32
 %107 = load i8, i8* %29
 %108 = sext i8 %107 to i32
 %109 = icmp ne i32 %106, %108
 br i1 %109, label %110, label %111
110:
 call void @abort ()
 unreachable
111:
 %112 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %10, i8* %112, i64 4, i1 0)
 %113 = getelementptr %struct.eight, i8* %10, i32 0, i32 1
 %114 = load i8, i8* %113
 %115 = sext i8 %114 to i32
 %116 = load i8, i8* %30
 %117 = sext i8 %116 to i32
 %118 = icmp ne i32 %115, %117
 br i1 %118, label %119, label %120
119:
 call void @abort ()
 unreachable
120:
 %121 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %11, i8* %121, i64 8, i1 0)
 %122 = load i8, i8* %11
 %123 = sext i8 %122 to i32
 %124 = load i8, i8* %31
 %125 = sext i8 %124 to i32
 %126 = icmp ne i32 %123, %125
 br i1 %126, label %127, label %128
127:
 call void @abort ()
 unreachable
128:
 %129 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 call void @memcpy (i8* %12, i8* %129, i64 16, i1 0)
 %130 = getelementptr %struct.ten, i8* %12, i32 0, i32 1
 %131 = load i8, i8* %130
 %132 = sext i8 %131 to i32
 %133 = load i8, i8* %32
 %134 = sext i8 %133 to i32
 %135 = icmp ne i32 %132, %134
 br i1 %135, label %136, label %137
136:
 call void @abort ()
 unreachable
137:
 %138 = load i64, i64* %13
 %139 = icmp ne i64 12, %138
 br i1 %139, label %140, label %141
140:
 call void @abort ()
 unreachable
141:
 %142 = load i64, i64* %14
 %143 = icmp ne i64 16, %142
 br i1 %143, label %144, label %145
144:
 call void @abort ()
 unreachable
145:
 %146 = load i64, i64* %15
 %147 = icmp ne i64 6, %146
 br i1 %147, label %148, label %149
148:
 call void @abort ()
 unreachable
149:
 %150 = load i64, i64* %16
 %151 = icmp ne i64 8, %150
 br i1 %151, label %152, label %153
152:
 call void @abort ()
 unreachable
153:
 %154 = load i64, i64* %17
 %155 = icmp ne i64 3, %154
 br i1 %155, label %156, label %157
156:
 call void @abort ()
 unreachable
157:
 %158 = load i64, i64* %18
 %159 = icmp ne i64 8, %158
 br i1 %159, label %160, label %161
160:
 call void @abort ()
 unreachable
161:
 %162 = load i64, i64* %19
 %163 = icmp ne i64 3, %162
 br i1 %163, label %164, label %165
164:
 call void @abort ()
 unreachable
165:
 %166 = load i64, i64* %20
 %167 = icmp ne i64 4, %166
 br i1 %167, label %168, label %169
168:
 call void @abort ()
 unreachable
169:
 %170 = load i64, i64* %21
 %171 = icmp ne i64 8, %170
 br i1 %171, label %172, label %173
172:
 call void @abort ()
 unreachable
173:
 %174 = load i64, i64* %22
 %175 = icmp ne i64 16, %174
 br i1 %175, label %176, label %177
176:
 call void @abort ()
 unreachable
177:
 ret i32 0
}
