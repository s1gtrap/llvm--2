@.str = global [23 x i8] c"Pfannkuchen(%d) = %ld\0A\00"
@.str.1 = global [3 x i8] c"%d\00"
@.str.2 = global [2 x i8] c"\0A\00"

declare i32 @printf(i8*, ...)
declare i8* @calloc(i64, i64)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 11, i32* %6
 %7 = load i32, i32* %6
 %8 = load i32, i32* %6
 %9 = call i64 @fannkuch (i32 %8)
 %10 = call i32 (i8*, ...) @printf (i8* @.str, i32 %7, i64 %9)
 ret i32 0
}

define i64 @fannkuch (i32 %0) {
 %2 = alloca i64
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i64
 %8 = alloca i64
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 %12 = alloca i32
 %13 = alloca i32
 %14 = alloca i32
 %15 = alloca i32
 %16 = alloca i32
 store i32 %0, i32* %3
 %17 = load i32, i32* %3
 %18 = sub i32 %17, 1
 store i32 %18, i32* %13
 %19 = load i32, i32* %3
 %20 = icmp slt i32 %19, 1
 br i1 %20, label %21, label %22
21:
 store i64 0, i64* %2
 br label %221
22:
 %23 = load i32, i32* %3
 %24 = sext i32 %23 to i64
 %25 = call i8* @calloc (i64 %24, i64 4)
 store i8* %25, i8** %4
 %26 = load i32, i32* %3
 %27 = sext i32 %26 to i64
 %28 = call i8* @calloc (i64 %27, i64 4)
 store i8* %28, i8** %5
 %29 = load i32, i32* %3
 %30 = sext i32 %29 to i64
 %31 = call i8* @calloc (i64 %30, i64 4)
 store i8* %31, i8** %6
 store i32 0, i32* %10
 br label %32
32:
 %33 = load i32, i32* %10
 %34 = load i32, i32* %3
 %35 = icmp slt i32 %33, %34
 br i1 %35, label %36, label %45
36:
 %37 = load i32, i32* %10
 %38 = load i8*, i8** %5
 %39 = load i32, i32* %10
 %40 = sext i32 %39 to i64
 %41 = getelementptr i32, i8* %38, i64 %40
 store i32 %37, i32* %41
 br label %42
42:
 %43 = load i32, i32* %10
 %44 = add i32 %43, 1
 store i32 %44, i32* %10
 br label %32
45:
 %46 = load i32, i32* %3
 store i32 %46, i32* %9
 store i32 0, i32* %12
 store i64 0, i64* %8
 br label %47
47:
 %48 = load i32, i32* %12
 %49 = icmp slt i32 %48, 30
 br i1 %49, label %50, label %70
50:
 store i32 0, i32* %10
 br label %51
51:
 %52 = load i32, i32* %10
 %53 = load i32, i32* %3
 %54 = icmp slt i32 %52, %53
 br i1 %54, label %55, label %66
55:
 %56 = load i8*, i8** %5
 %57 = load i32, i32* %10
 %58 = sext i32 %57 to i64
 %59 = getelementptr i32, i8* %56, i64 %58
 %60 = load i32, i32* %59
 %61 = add i32 1, %60
 %62 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %61)
 br label %63
63:
 %64 = load i32, i32* %10
 %65 = add i32 %64, 1
 store i32 %65, i32* %10
 br label %51
66:
 %67 = call i32 (i8*, ...) @printf (i8* @.str.2)
 %68 = load i32, i32* %12
 %69 = add i32 %68, 1
 store i32 %69, i32* %12
 br label %70
70:
 br label %71
71:
 %72 = load i32, i32* %9
 %73 = icmp ne i32 %72, 1
 br i1 %73, label %74, label %84
74:
 %75 = load i32, i32* %9
 %76 = load i8*, i8** %6
 %77 = load i32, i32* %9
 %78 = sub i32 %77, 1
 %79 = sext i32 %78 to i64
 %80 = getelementptr i32, i8* %76, i64 %79
 store i32 %75, i32* %80
 br label %81
81:
 %82 = load i32, i32* %9
 %83 = add i32 %82, -1
 store i32 %83, i32* %9
 br label %71
84:
 %85 = load i8*, i8** %5
 %86 = getelementptr i32, i8* %85, i64 0
 %87 = load i32, i32* %86
 %88 = icmp eq i32 %87, 0
 br i1 %88, label %175, label %89
89:
 %90 = load i8*, i8** %5
 %91 = load i32, i32* %13
 %92 = sext i32 %91 to i64
 %93 = getelementptr i32, i8* %90, i64 %92
 %94 = load i32, i32* %93
 %95 = load i32, i32* %13
 %96 = icmp eq i32 %94, %95
 br i1 %96, label %175, label %97
97:
 store i64 0, i64* %7
 store i32 1, i32* %10
 br label %98
98:
 %99 = load i32, i32* %10
 %100 = load i32, i32* %3
 %101 = icmp slt i32 %99, %100
 br i1 %101, label %102, label %115
102:
 %103 = load i8*, i8** %5
 %104 = load i32, i32* %10
 %105 = sext i32 %104 to i64
 %106 = getelementptr i32, i8* %103, i64 %105
 %107 = load i32, i32* %106
 %108 = load i8*, i8** %4
 %109 = load i32, i32* %10
 %110 = sext i32 %109 to i64
 %111 = getelementptr i32, i8* %108, i64 %110
 store i32 %107, i32* %111
 br label %112
112:
 %113 = load i32, i32* %10
 %114 = add i32 %113, 1
 store i32 %114, i32* %10
 br label %98
115:
 %116 = load i8*, i8** %5
 %117 = getelementptr i32, i8* %116, i64 0
 %118 = load i32, i32* %117
 store i32 %118, i32* %11
 br label %119
119:
 store i32 1, i32* %10
 %120 = load i32, i32* %11
 %121 = sub i32 %120, 1
 store i32 %121, i32* %14
 br label %122
122:
 %123 = load i32, i32* %10
 %124 = load i32, i32* %14
 %125 = icmp slt i32 %123, %124
 br i1 %125, label %126, label %151
126:
 %127 = load i8*, i8** %4
 %128 = load i32, i32* %10
 %129 = sext i32 %128 to i64
 %130 = getelementptr i32, i8* %127, i64 %129
 %131 = load i32, i32* %130
 store i32 %131, i32* %15
 %132 = load i8*, i8** %4
 %133 = load i32, i32* %14
 %134 = sext i32 %133 to i64
 %135 = getelementptr i32, i8* %132, i64 %134
 %136 = load i32, i32* %135
 %137 = load i8*, i8** %4
 %138 = load i32, i32* %10
 %139 = sext i32 %138 to i64
 %140 = getelementptr i32, i8* %137, i64 %139
 store i32 %136, i32* %140
 %141 = load i32, i32* %15
 %142 = load i8*, i8** %4
 %143 = load i32, i32* %14
 %144 = sext i32 %143 to i64
 %145 = getelementptr i32, i8* %142, i64 %144
 store i32 %141, i32* %145
 br label %146
146:
 %147 = load i32, i32* %10
 %148 = add i32 %147, 1
 store i32 %148, i32* %10
 %149 = load i32, i32* %14
 %150 = add i32 %149, -1
 store i32 %150, i32* %14
 br label %122
151:
 %152 = load i64, i64* %7
 %153 = add i64 %152, 1
 store i64 %153, i64* %7
 %154 = load i8*, i8** %4
 %155 = load i32, i32* %11
 %156 = sext i32 %155 to i64
 %157 = getelementptr i32, i8* %154, i64 %156
 %158 = load i32, i32* %157
 store i32 %158, i32* %14
 %159 = load i32, i32* %11
 %160 = load i8*, i8** %4
 %161 = load i32, i32* %11
 %162 = sext i32 %161 to i64
 %163 = getelementptr i32, i8* %160, i64 %162
 store i32 %159, i32* %163
 %164 = load i32, i32* %14
 store i32 %164, i32* %11
 br label %165
165:
 %166 = load i32, i32* %11
 %167 = icmp ne i32 %166, 0
 br i1 %167, label %119, label %168
168:
 %169 = load i64, i64* %8
 %170 = load i64, i64* %7
 %171 = icmp slt i64 %169, %170
 br i1 %171, label %172, label %174
172:
 %173 = load i64, i64* %7
 store i64 %173, i64* %8
 br label %174
174:
 br label %175
175:
 br label %176
176:
 %177 = load i32, i32* %9
 %178 = load i32, i32* %3
 %179 = icmp eq i32 %177, %178
 br i1 %179, label %180, label %182
180:
 %181 = load i64, i64* %8
 store i64 %181, i64* %2
 br label %221
182:
 %183 = load i8*, i8** %5
 %184 = getelementptr i32, i8* %183, i64 0
 %185 = load i32, i32* %184
 store i32 %185, i32* %16
 store i32 0, i32* %10
 br label %186
186:
 %187 = load i32, i32* %10
 %188 = load i32, i32* %9
 %189 = icmp slt i32 %187, %188
 br i1 %189, label %190, label %203
190:
 %191 = load i32, i32* %10
 %192 = add i32 %191, 1
 store i32 %192, i32* %11
 %193 = load i8*, i8** %5
 %194 = load i32, i32* %11
 %195 = sext i32 %194 to i64
 %196 = getelementptr i32, i8* %193, i64 %195
 %197 = load i32, i32* %196
 %198 = load i8*, i8** %5
 %199 = load i32, i32* %10
 %200 = sext i32 %199 to i64
 %201 = getelementptr i32, i8* %198, i64 %200
 store i32 %197, i32* %201
 %202 = load i32, i32* %11
 store i32 %202, i32* %10
 br label %186
203:
 %204 = load i32, i32* %16
 %205 = load i8*, i8** %5
 %206 = load i32, i32* %9
 %207 = sext i32 %206 to i64
 %208 = getelementptr i32, i8* %205, i64 %207
 store i32 %204, i32* %208
 %209 = load i8*, i8** %6
 %210 = load i32, i32* %9
 %211 = sext i32 %210 to i64
 %212 = getelementptr i32, i8* %209, i64 %211
 %213 = load i32, i32* %212
 %214 = sub i32 %213, 1
 store i32 %214, i32* %212
 %215 = icmp sgt i32 %214, 0
 br i1 %215, label %216, label %217
216:
 br label %220
217:
 %218 = load i32, i32* %9
 %219 = add i32 %218, 1
 store i32 %219, i32* %9
 br label %176
220:
 br label %47
221:
 %222 = load i64, i64* %2
 ret i64 %222
}
