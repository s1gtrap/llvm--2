@.str = global [3 x i8] c"+-\00"
@.str.1 = global [3 x i8] c"--\00"
@.str.2 = global [3 x i8] c"+\0A\00"
@.str.3 = global [4 x i8] c"|%c\00"
@.str.4 = global [3 x i8] c"| \00"
@.str.5 = global [4 x i8] c" %c\00"
@.str.6 = global [3 x i8] c"  \00"
@.str.7 = global [3 x i8] c"|\0A\00"

declare i32 @printf(i8*, ...)
declare i8* @llvm.stacksave()
declare i32 @getchar()
declare void @llvm.stackrestore(i8*)
declare i32 @atoi(i8*)

define void @add_edge (i32 %0, i32 %1, i32 %2, i8* %3) {
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 store i8* %3, i8** %8
 %9 = load i8*, i8** %8
 %10 = load i32, i32* %6
 %11 = load i32, i32* %7
 %12 = load i32, i32* %5
 %13 = mul i32 %11, %12
 %14 = load i32, i32* %5
 %15 = mul i32 %13, %14
 %16 = load i32, i32* %5
 %17 = mul i32 %15, %16
 %18 = load i32, i32* %5
 %19 = mul i32 %17, %18
 %20 = add i32 %10, %19
 %21 = sext i32 %20 to i64
 %22 = getelementptr i8, i8* %9, i64 %21
 store i8 1, i8* %22
 %23 = load i8*, i8** %8
 %24 = load i32, i32* %7
 %25 = load i32, i32* %6
 %26 = load i32, i32* %5
 %27 = mul i32 %25, %26
 %28 = load i32, i32* %5
 %29 = mul i32 %27, %28
 %30 = load i32, i32* %5
 %31 = mul i32 %29, %30
 %32 = load i32, i32* %5
 %33 = mul i32 %31, %32
 %34 = add i32 %24, %33
 %35 = sext i32 %34 to i64
 %36 = getelementptr i8, i8* %23, i64 %35
 store i8 1, i8* %36
 ret void
}

define void @init_sudoku (i32 %0, i8* %1, i8* %2) {
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 %12 = alloca i32
 %13 = alloca i32
 %14 = alloca i32
 %15 = alloca i32
 %16 = alloca i32
 %17 = alloca i32
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i8* %2, i8** %6
 store i32 0, i32* %7
 br label %18
18:
 %19 = load i32, i32* %7
 %20 = load i32, i32* %4
 %21 = load i32, i32* %4
 %22 = mul i32 %20, %21
 %23 = load i32, i32* %4
 %24 = mul i32 %22, %23
 %25 = load i32, i32* %4
 %26 = mul i32 %24, %25
 %27 = icmp slt i32 %19, %26
 br i1 %27, label %28, label %36
28:
 %29 = load i8*, i8** %5
 %30 = load i32, i32* %7
 %31 = sext i32 %30 to i64
 %32 = getelementptr i32, i32* %29, i64 %31
 store i32 0, i32* %32
 br label %33
33:
 %34 = load i32, i32* %7
 %35 = add i32 %34, 1
 store i32 %35, i32* %7
 br label %18
36:
 store i32 0, i32* %8
 br label %37
37:
 %38 = load i32, i32* %8
 %39 = load i32, i32* %4
 %40 = load i32, i32* %4
 %41 = mul i32 %39, %40
 %42 = load i32, i32* %4
 %43 = mul i32 %41, %42
 %44 = load i32, i32* %4
 %45 = mul i32 %43, %44
 %46 = load i32, i32* %4
 %47 = mul i32 %45, %46
 %48 = load i32, i32* %4
 %49 = mul i32 %47, %48
 %50 = load i32, i32* %4
 %51 = mul i32 %49, %50
 %52 = load i32, i32* %4
 %53 = mul i32 %51, %52
 %54 = icmp slt i32 %38, %53
 br i1 %54, label %55, label %63
55:
 %56 = load i8*, i8** %6
 %57 = load i32, i32* %8
 %58 = sext i32 %57 to i64
 %59 = getelementptr i8, i8* %56, i64 %58
 store i8 0, i8* %59
 br label %60
60:
 %61 = load i32, i32* %8
 %62 = add i32 %61, 1
 store i32 %62, i32* %8
 br label %37
63:
 store i32 0, i32* %9
 br label %64
64:
 %65 = load i32, i32* %9
 %66 = load i32, i32* %4
 %67 = load i32, i32* %4
 %68 = mul i32 %66, %67
 %69 = icmp slt i32 %65, %68
 br i1 %69, label %70, label %197
70:
 store i32 0, i32* %10
 br label %71
71:
 %72 = load i32, i32* %10
 %73 = load i32, i32* %4
 %74 = load i32, i32* %4
 %75 = mul i32 %73, %74
 %76 = icmp slt i32 %72, %75
 br i1 %76, label %77, label %193
77:
 store i32 0, i32* %11
 br label %78
78:
 %79 = load i32, i32* %11
 %80 = load i32, i32* %4
 %81 = load i32, i32* %4
 %82 = mul i32 %80, %81
 %83 = icmp slt i32 %79, %82
 br i1 %83, label %84, label %189
84:
 %85 = load i32, i32* %11
 %86 = load i32, i32* %9
 %87 = icmp ne i32 %85, %86
 br i1 %87, label %88, label %105
88:
 %89 = load i32, i32* %4
 %90 = load i32, i32* %9
 %91 = load i32, i32* %10
 %92 = load i32, i32* %4
 %93 = mul i32 %91, %92
 %94 = load i32, i32* %4
 %95 = mul i32 %93, %94
 %96 = add i32 %90, %95
 %97 = load i32, i32* %11
 %98 = load i32, i32* %10
 %99 = load i32, i32* %4
 %100 = mul i32 %98, %99
 %101 = load i32, i32* %4
 %102 = mul i32 %100, %101
 %103 = add i32 %97, %102
 %104 = load i8*, i8** %6
 call void @add_edge (i32 %89, i32 %96, i32 %103, i8* %104)
 br label %105
105:
 %106 = load i32, i32* %11
 %107 = load i32, i32* %10
 %108 = icmp ne i32 %106, %107
 br i1 %108, label %109, label %126
109:
 %110 = load i32, i32* %4
 %111 = load i32, i32* %9
 %112 = load i32, i32* %10
 %113 = load i32, i32* %4
 %114 = mul i32 %112, %113
 %115 = load i32, i32* %4
 %116 = mul i32 %114, %115
 %117 = add i32 %111, %116
 %118 = load i32, i32* %9
 %119 = load i32, i32* %11
 %120 = load i32, i32* %4
 %121 = mul i32 %119, %120
 %122 = load i32, i32* %4
 %123 = mul i32 %121, %122
 %124 = add i32 %118, %123
 %125 = load i8*, i8** %6
 call void @add_edge (i32 %110, i32 %117, i32 %124, i8* %125)
 br label %126
126:
 %127 = load i32, i32* %9
 %128 = load i32, i32* %4
 %129 = sdiv i32 %127, %128
 %130 = load i32, i32* %4
 %131 = mul i32 %129, %130
 store i32 %131, i32* %12
 %132 = load i32, i32* %10
 %133 = load i32, i32* %4
 %134 = sdiv i32 %132, %133
 %135 = load i32, i32* %4
 %136 = mul i32 %134, %135
 store i32 %136, i32* %13
 store i32 0, i32* %14
 br label %137
137:
 %138 = load i32, i32* %14
 %139 = load i32, i32* %4
 %140 = icmp slt i32 %138, %139
 br i1 %140, label %141, label %185
141:
 store i32 0, i32* %15
 br label %142
142:
 %143 = load i32, i32* %15
 %144 = load i32, i32* %4
 %145 = icmp slt i32 %143, %144
 br i1 %145, label %146, label %181
146:
 %147 = load i32, i32* %12
 %148 = load i32, i32* %14
 %149 = add i32 %147, %148
 store i32 %149, i32* %16
 %150 = load i32, i32* %13
 %151 = load i32, i32* %15
 %152 = add i32 %150, %151
 store i32 %152, i32* %17
 %153 = load i32, i32* %16
 %154 = load i32, i32* %9
 %155 = icmp ne i32 %153, %154
 br i1 %155, label %160, label %156
156:
 %157 = load i32, i32* %17
 %158 = load i32, i32* %10
 %159 = icmp ne i32 %157, %158
 br i1 %159, label %160, label %177
160:
 %161 = load i32, i32* %4
 %162 = load i32, i32* %9
 %163 = load i32, i32* %10
 %164 = load i32, i32* %4
 %165 = mul i32 %163, %164
 %166 = load i32, i32* %4
 %167 = mul i32 %165, %166
 %168 = add i32 %162, %167
 %169 = load i32, i32* %16
 %170 = load i32, i32* %17
 %171 = load i32, i32* %4
 %172 = mul i32 %170, %171
 %173 = load i32, i32* %4
 %174 = mul i32 %172, %173
 %175 = add i32 %169, %174
 %176 = load i8*, i8** %6
 call void @add_edge (i32 %161, i32 %168, i32 %175, i8* %176)
 br label %177
177:
 br label %178
178:
 %179 = load i32, i32* %15
 %180 = add i32 %179, 1
 store i32 %180, i32* %15
 br label %142
181:
 br label %182
182:
 %183 = load i32, i32* %14
 %184 = add i32 %183, 1
 store i32 %184, i32* %14
 br label %137
185:
 br label %186
186:
 %187 = load i32, i32* %11
 %188 = add i32 %187, 1
 store i32 %188, i32* %11
 br label %78
189:
 br label %190
190:
 %191 = load i32, i32* %10
 %192 = add i32 %191, 1
 store i32 %192, i32* %10
 br label %71
193:
 br label %194
194:
 %195 = load i32, i32* %9
 %196 = add i32 %195, 1
 store i32 %196, i32* %9
 br label %64
197:
 ret void
}

define i8 @toc (i32 %0) {
 %2 = alloca i8
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 %5 = icmp slt i32 %4, 10
 br i1 %5, label %6, label %10
6:
 %7 = load i32, i32* %3
 %8 = add i32 48, %7
 %9 = trunc i32 %8 to i8
 store i8 %9, i8* %2
 br label %19
10:
 %11 = load i32, i32* %3
 %12 = icmp slt i32 %11, 46
 br i1 %12, label %13, label %18
13:
 %14 = load i32, i32* %3
 %15 = add i32 65, %14
 %16 = sub i32 %15, 10
 %17 = trunc i32 %16 to i8
 store i8 %17, i8* %2
 br label %19
18:
 br label %19
19:
 %20 = load i8, i8* %2
 ret i8 %20
}

define void @print_sudoku (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 store i32 0, i32* %5
 br label %9
9:
 %10 = load i32, i32* %5
 %11 = load i32, i32* %3
 %12 = load i32, i32* %3
 %13 = mul i32 %11, %12
 %14 = icmp slt i32 %10, %13
 br i1 %14, label %15, label %30
15:
 %16 = load i32, i32* %3
 %17 = load i32, i32* %5
 %18 = mul i32 %16, %17
 %19 = load i32, i32* %3
 %20 = load i32, i32* %3
 %21 = mul i32 %19, %20
 %22 = srem i32 %18, %21
 %23 = icmp eq i32 %22, 0
 %24 = zext i1 %23 to i64
 %25 = select i1 %23, i8* @.str, i8* @.str.1
 %26 = call i32 (i8*, ...) @printf (i8* %25)
 br label %27
27:
 %28 = load i32, i32* %5
 %29 = add i32 %28, 1
 store i32 %29, i32* %5
 br label %9
30:
 %31 = call i32 (i8*, ...) @printf (i8* @.str.2)
 store i32 0, i32* %6
 br label %32
32:
 %33 = load i32, i32* %6
 %34 = load i32, i32* %3
 %35 = load i32, i32* %3
 %36 = mul i32 %34, %35
 %37 = sub i32 %36, 1
 %38 = icmp sle i32 %33, %37
 br i1 %38, label %39, label %154
39:
 store i32 0, i32* %7
 br label %40
40:
 %41 = load i32, i32* %7
 %42 = load i32, i32* %3
 %43 = load i32, i32* %3
 %44 = mul i32 %42, %43
 %45 = sub i32 %44, 1
 %46 = icmp sle i32 %41, %45
 br i1 %46, label %47, label %118
47:
 %48 = load i32, i32* %7
 %49 = load i32, i32* %3
 %50 = srem i32 %48, %49
 %51 = icmp eq i32 %50, 0
 br i1 %51, label %52, label %83
52:
 %53 = load i8*, i8** %4
 %54 = load i32, i32* %7
 %55 = load i32, i32* %6
 %56 = load i32, i32* %3
 %57 = mul i32 %55, %56
 %58 = load i32, i32* %3
 %59 = mul i32 %57, %58
 %60 = add i32 %54, %59
 %61 = sext i32 %60 to i64
 %62 = getelementptr i32, i32* %53, i64 %61
 %63 = load i32, i32* %62
 %64 = icmp sgt i32 %63, 0
 br i1 %64, label %65, label %80
65:
 %66 = load i8*, i8** %4
 %67 = load i32, i32* %7
 %68 = load i32, i32* %6
 %69 = load i32, i32* %3
 %70 = mul i32 %68, %69
 %71 = load i32, i32* %3
 %72 = mul i32 %70, %71
 %73 = add i32 %67, %72
 %74 = sext i32 %73 to i64
 %75 = getelementptr i32, i32* %66, i64 %74
 %76 = load i32, i32* %75
 %77 = call i8 @toc (i32 %76)
 %78 = sext i8 %77 to i32
 %79 = call i32 (i8*, ...) @printf (i8* @.str.3, i32 %78)
 br label %82
80:
 %81 = call i32 (i8*, ...) @printf (i8* @.str.4)
 br label %82
82:
 br label %114
83:
 %84 = load i8*, i8** %4
 %85 = load i32, i32* %7
 %86 = load i32, i32* %6
 %87 = load i32, i32* %3
 %88 = mul i32 %86, %87
 %89 = load i32, i32* %3
 %90 = mul i32 %88, %89
 %91 = add i32 %85, %90
 %92 = sext i32 %91 to i64
 %93 = getelementptr i32, i32* %84, i64 %92
 %94 = load i32, i32* %93
 %95 = icmp sgt i32 %94, 0
 br i1 %95, label %96, label %111
96:
 %97 = load i8*, i8** %4
 %98 = load i32, i32* %7
 %99 = load i32, i32* %6
 %100 = load i32, i32* %3
 %101 = mul i32 %99, %100
 %102 = load i32, i32* %3
 %103 = mul i32 %101, %102
 %104 = add i32 %98, %103
 %105 = sext i32 %104 to i64
 %106 = getelementptr i32, i32* %97, i64 %105
 %107 = load i32, i32* %106
 %108 = call i8 @toc (i32 %107)
 %109 = sext i8 %108 to i32
 %110 = call i32 (i8*, ...) @printf (i8* @.str.5, i32 %109)
 br label %113
111:
 %112 = call i32 (i8*, ...) @printf (i8* @.str.6)
 br label %113
113:
 br label %114
114:
 br label %115
115:
 %116 = load i32, i32* %7
 %117 = add i32 %116, 1
 store i32 %117, i32* %7
 br label %40
118:
 %119 = call i32 (i8*, ...) @printf (i8* @.str.7)
 %120 = load i32, i32* %6
 %121 = load i32, i32* %3
 %122 = srem i32 %120, %121
 %123 = load i32, i32* %3
 %124 = sub i32 %123, 1
 %125 = icmp eq i32 %122, %124
 br i1 %125, label %126, label %150
126:
 store i32 0, i32* %8
 br label %127
127:
 %128 = load i32, i32* %8
 %129 = load i32, i32* %3
 %130 = load i32, i32* %3
 %131 = mul i32 %129, %130
 %132 = icmp slt i32 %128, %131
 br i1 %132, label %133, label %148
133:
 %134 = load i32, i32* %3
 %135 = load i32, i32* %8
 %136 = mul i32 %134, %135
 %137 = load i32, i32* %3
 %138 = load i32, i32* %3
 %139 = mul i32 %137, %138
 %140 = srem i32 %136, %139
 %141 = icmp eq i32 %140, 0
 %142 = zext i1 %141 to i64
 %143 = select i1 %141, i8* @.str, i8* @.str.1
 %144 = call i32 (i8*, ...) @printf (i8* %143)
 br label %145
145:
 %146 = load i32, i32* %8
 %147 = add i32 %146, 1
 store i32 %147, i32* %8
 br label %127
148:
 %149 = call i32 (i8*, ...) @printf (i8* @.str.2)
 br label %150
150:
 br label %151
151:
 %152 = load i32, i32* %6
 %153 = add i32 %152, 1
 store i32 %153, i32* %6
 br label %32
154:
 ret void
}

define i32 @degree (i32 %0, i32 %1, i8* %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i8*
 %7 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i8* %2, i8** %6
 store i32 0, i32* %7
 br label %8
8:
 %9 = load i32, i32* %5
 %10 = load i32, i32* %4
 %11 = load i32, i32* %4
 %12 = mul i32 %10, %11
 %13 = load i32, i32* %4
 %14 = mul i32 %12, %13
 %15 = load i32, i32* %4
 %16 = mul i32 %14, %15
 %17 = load i32, i32* %4
 %18 = mul i32 %16, %17
 %19 = load i32, i32* %4
 %20 = mul i32 %18, %19
 %21 = load i32, i32* %4
 %22 = mul i32 %20, %21
 %23 = load i32, i32* %4
 %24 = mul i32 %22, %23
 %25 = icmp slt i32 %9, %24
 br i1 %25, label %26, label %46
26:
 %27 = load i8*, i8** %6
 %28 = load i32, i32* %5
 %29 = sext i32 %28 to i64
 %30 = getelementptr i8, i8* %27, i64 %29
 %31 = load i8, i8* %30
 %32 = trunc i8 %31 to i1
 %33 = zext i1 %32 to i32
 %34 = load i32, i32* %7
 %35 = add i32 %34, %33
 store i32 %35, i32* %7
 br label %36
36:
 %37 = load i32, i32* %4
 %38 = load i32, i32* %4
 %39 = mul i32 %37, %38
 %40 = load i32, i32* %4
 %41 = mul i32 %39, %40
 %42 = load i32, i32* %4
 %43 = mul i32 %41, %42
 %44 = load i32, i32* %5
 %45 = add i32 %44, %43
 store i32 %45, i32* %5
 br label %8
46:
 %47 = load i32, i32* %7
 ret i32 %47
}

define i1 @coloring (i32 %0, i32 %1, i8* %2, i8* %3) {
 %5 = alloca i1
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
 %9 = alloca i8*
 %10 = alloca i32
 %11 = alloca i32
 %12 = alloca i32
 %13 = alloca i32
 store i32 %0, i32* %6
 store i32 %1, i32* %7
 store i8* %2, i8** %8
 store i8* %3, i8** %9
 store i32 0, i32* %10
 br label %14
14:
 %15 = load i32, i32* %10
 %16 = load i32, i32* %6
 %17 = load i32, i32* %6
 %18 = mul i32 %16, %17
 %19 = load i32, i32* %6
 %20 = mul i32 %18, %19
 %21 = load i32, i32* %6
 %22 = mul i32 %20, %21
 %23 = icmp slt i32 %15, %22
 br i1 %23, label %24, label %127
24:
 %25 = load i8*, i8** %8
 %26 = load i32, i32* %10
 %27 = sext i32 %26 to i64
 %28 = getelementptr i32, i32* %25, i64 %27
 %29 = load i32, i32* %28
 %30 = icmp eq i32 %29, 0
 br i1 %30, label %31, label %123
31:
 store i32 1, i32* %11
 br label %32
32:
 %33 = load i32, i32* %11
 %34 = load i32, i32* %7
 %35 = icmp sle i32 %33, %34
 br i1 %35, label %36, label %122
36:
 %37 = load i32, i32* %10
 store i32 %37, i32* %12
 br label %38
38:
 %39 = load i32, i32* %12
 %40 = load i32, i32* %6
 %41 = load i32, i32* %6
 %42 = mul i32 %40, %41
 %43 = load i32, i32* %6
 %44 = mul i32 %42, %43
 %45 = load i32, i32* %6
 %46 = mul i32 %44, %45
 %47 = load i32, i32* %6
 %48 = mul i32 %46, %47
 %49 = load i32, i32* %6
 %50 = mul i32 %48, %49
 %51 = load i32, i32* %6
 %52 = mul i32 %50, %51
 %53 = load i32, i32* %6
 %54 = mul i32 %52, %53
 %55 = icmp slt i32 %39, %54
 br i1 %55, label %56, label %99
56:
 %57 = load i8*, i8** %9
 %58 = load i32, i32* %12
 %59 = sext i32 %58 to i64
 %60 = getelementptr i8, i8* %57, i64 %59
 %61 = load i8, i8* %60
 %62 = trunc i8 %61 to i1
 br i1 %62, label %63, label %64
63:
 br label %64
64:
 %65 = load i8*, i8** %9
 %66 = load i32, i32* %12
 %67 = sext i32 %66 to i64
 %68 = getelementptr i8, i8* %65, i64 %67
 %69 = load i8, i8* %68
 %70 = trunc i8 %69 to i1
 br i1 %70, label %71, label %88
71:
 %72 = load i32, i32* %11
 %73 = load i8*, i8** %8
 %74 = load i32, i32* %12
 %75 = load i32, i32* %6
 %76 = load i32, i32* %6
 %77 = mul i32 %75, %76
 %78 = load i32, i32* %6
 %79 = mul i32 %77, %78
 %80 = load i32, i32* %6
 %81 = mul i32 %79, %80
 %82 = sdiv i32 %74, %81
 %83 = sext i32 %82 to i64
 %84 = getelementptr i32, i32* %73, i64 %83
 %85 = load i32, i32* %84
 %86 = icmp eq i32 %72, %85
 br i1 %86, label %87, label %88
87:
 br label %118
88:
 br label %89
89:
 %90 = load i32, i32* %6
 %91 = load i32, i32* %6
 %92 = mul i32 %90, %91
 %93 = load i32, i32* %6
 %94 = mul i32 %92, %93
 %95 = load i32, i32* %6
 %96 = mul i32 %94, %95
 %97 = load i32, i32* %12
 %98 = add i32 %97, %96
 store i32 %98, i32* %12
 br label %38
99:
 %100 = load i32, i32* %11
 %101 = load i8*, i8** %8
 %102 = load i32, i32* %10
 %103 = sext i32 %102 to i64
 %104 = getelementptr i32, i32* %101, i64 %103
 store i32 %100, i32* %104
 %105 = load i32, i32* %6
 %106 = load i8*, i8** %8
 call void @print_sudoku (i32 %105, i8* %106)
 %107 = load i32, i32* %6
 %108 = load i32, i32* %7
 %109 = load i8*, i8** %8
 %110 = load i8*, i8** %9
 %111 = call i1 @coloring (i32 %107, i32 %108, i8* %109, i8* %110)
 br i1 %111, label %112, label %113
112:
 store i1 1, i1* %5
 br label %151
113:
 %114 = load i8*, i8** %8
 %115 = load i32, i32* %10
 %116 = sext i32 %115 to i64
 %117 = getelementptr i32, i32* %114, i64 %116
 store i32 0, i32* %117
 br label %118
118:
 br label %119
119:
 %120 = load i32, i32* %11
 %121 = add i32 %120, 1
 store i32 %121, i32* %11
 br label %32
122:
 br label %127
123:
 br label %124
124:
 %125 = load i32, i32* %10
 %126 = add i32 %125, 1
 store i32 %126, i32* %10
 br label %14
127:
 store i32 0, i32* %13
 br label %128
128:
 %129 = load i32, i32* %13
 %130 = load i32, i32* %6
 %131 = load i32, i32* %6
 %132 = mul i32 %130, %131
 %133 = load i32, i32* %6
 %134 = mul i32 %132, %133
 %135 = load i32, i32* %6
 %136 = mul i32 %134, %135
 %137 = icmp slt i32 %129, %136
 br i1 %137, label %138, label %150
138:
 %139 = load i8*, i8** %8
 %140 = load i32, i32* %13
 %141 = sext i32 %140 to i64
 %142 = getelementptr i32, i32* %139, i64 %141
 %143 = load i32, i32* %142
 %144 = icmp eq i32 %143, 0
 br i1 %144, label %145, label %146
145:
 store i1 0, i1* %5
 br label %151
146:
 br label %147
147:
 %148 = load i32, i32* %13
 %149 = add i32 %148, 1
 store i32 %149, i32* %13
 br label %128
150:
 store i1 1, i1* %5
 br label %151
151:
 %152 = load i1, i1* %5
 ret i1 %152
}

define i1 @test (i32 %0) {
 %2 = alloca i32
 %3 = alloca i8*
 %4 = alloca i64
 %5 = alloca i64
 %6 = alloca i32
 %7 = alloca i8
 %8 = alloca i32
 store i32 %0, i32* %2
 %9 = load i32, i32* %2
 %10 = load i32, i32* %2
 %11 = mul i32 %9, %10
 %12 = load i32, i32* %2
 %13 = mul i32 %11, %12
 %14 = load i32, i32* %2
 %15 = mul i32 %13, %14
 %16 = zext i32 %15 to i64
 %17 = add i32 0, 0
 store i32 %17, i32* %3
 %18 = alloca i32, i64 %16
 store i64 %16, i64* %4
 %19 = load i32, i32* %2
 %20 = load i32, i32* %2
 %21 = mul i32 %19, %20
 %22 = load i32, i32* %2
 %23 = mul i32 %21, %22
 %24 = load i32, i32* %2
 %25 = mul i32 %23, %24
 %26 = load i32, i32* %2
 %27 = mul i32 %25, %26
 %28 = load i32, i32* %2
 %29 = mul i32 %27, %28
 %30 = load i32, i32* %2
 %31 = mul i32 %29, %30
 %32 = load i32, i32* %2
 %33 = mul i32 %31, %32
 %34 = zext i32 %33 to i64
 %35 = alloca i8, i64 %34
 store i64 %34, i64* %5
 %36 = load i32, i32* %2
 call void @init_sudoku (i32 %36, i8* %18, i8* %35)
 store i32 0, i32* %6
 br label %37
37:
 %38 = load i32, i32* %6
 %39 = load i32, i32* %2
 %40 = load i32, i32* %2
 %41 = mul i32 %39, %40
 %42 = load i32, i32* %2
 %43 = mul i32 %41, %42
 %44 = load i32, i32* %2
 %45 = mul i32 %43, %44
 %46 = icmp slt i32 %38, %45
 br i1 %46, label %47, label %91
47:
 %48 = call i32 @getchar ()
 %49 = trunc i32 %48 to i8
 store i8 %49, i8* %7
 store i32 0, i32* %8
 %50 = load i8, i8* %7
 %51 = sext i8 %50 to i32
 %52 = icmp sle i32 49, %51
 br i1 %52, label %53, label %57
53:
 %54 = load i8, i8* %7
 %55 = sext i8 %54 to i32
 %56 = icmp sle i32 %55, 57
 br i1 %56, label %65, label %57
57:
 %58 = load i8, i8* %7
 %59 = sext i8 %58 to i32
 %60 = icmp sle i32 97, %59
 br i1 %60, label %61, label %83
61:
 %62 = load i8, i8* %7
 %63 = sext i8 %62 to i32
 %64 = icmp sle i32 %63, 122
 br i1 %64, label %65, label %83
65:
 %66 = load i8, i8* %7
 %67 = sext i8 %66 to i32
 %68 = icmp sle i32 49, %67
 br i1 %68, label %69, label %77
69:
 %70 = load i8, i8* %7
 %71 = sext i8 %70 to i32
 %72 = icmp sle i32 %71, 57
 br i1 %72, label %73, label %77
73:
 %74 = load i8, i8* %7
 %75 = sext i8 %74 to i32
 %76 = sub i32 %75, 48
 store i32 %76, i32* %8
 br label %82
77:
 %78 = load i8, i8* %7
 %79 = sext i8 %78 to i32
 %80 = sub i32 %79, 97
 %81 = add i32 %80, 10
 store i32 %81, i32* %8
 br label %82
82:
 br label %83
83:
 %84 = load i32, i32* %8
 %85 = load i32, i32* %6
 %86 = sext i32 %85 to i64
 %87 = getelementptr i32, i32* %18, i64 %86
 store i32 %84, i32* %87
 br label %88
88:
 %89 = load i32, i32* %6
 %90 = add i32 %89, 1
 store i32 %90, i32* %6
 br label %37
91:
 %92 = load i32, i32* %2
 call void @print_sudoku (i32 %92, i8* %18)
 %93 = load i32, i32* %2
 %94 = load i32, i32* %2
 %95 = load i32, i32* %2
 %96 = mul i32 %94, %95
 %97 = call i1 @coloring (i32 %93, i32 %96, i8* %18, i8* %35)
 %98 = load i8*, i8** %3
 ret i1 %97
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = load i8*, i8** %5
 %7 = getelementptr i8*, i8** %6, i64 1
 %8 = load i8*, i8** %7
 %9 = call i32 @atoi (i8* %8)
 %10 = call i1 @test (i32 %9)
 %11 = xor i1 %10, 1
 %12 = zext i1 %11 to i32
 ret i32 %12
}
