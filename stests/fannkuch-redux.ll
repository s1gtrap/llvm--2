@.str = global [28 x i8] c"%jd\0APfannkuchen(%jd) = %jd\0A\00"

declare i32 @atoi(i8*)
declare i8* @llvm.stacksave()
declare void @llvm.stackrestore(i8*)
declare i32 @printf(i8*)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i64
 %7 = alloca i8*
 %8 = alloca i64
 %9 = alloca i64
 %10 = alloca i64
 %11 = alloca i64
 %12 = alloca i64
 %13 = alloca i64
 %14 = alloca i8*
 %15 = alloca i64
 %16 = alloca i64
 %17 = alloca i64
 %18 = alloca i64
 %19 = alloca i64
 %20 = alloca i64
 %21 = alloca i64
 %22 = alloca i64
 %23 = alloca i64
 %24 = alloca i64
 %25 = alloca i64
 %26 = alloca i64
 %27 = alloca i64
 %28 = alloca i64
 %29 = alloca i8
 %30 = alloca i64
 %31 = alloca i64
 %32 = alloca i8
 %33 = alloca i8
 %34 = alloca i64
 %35 = alloca i8
 %36 = alloca i64
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %37 = load i8*, i8** %5
 %38 = getelementptr i8*, i8* %37, i64 1
 %39 = load i8*, i8** %38
 %40 = call i32 @atoi (i8* %39)
 %41 = sext i32 %40 to i64
 store i64 %41, i64* %6
 %42 = load i64, i64* %6
 %43 = add i64 %42, 1
 %44 = add i32 0, 0
 %45 = alloca i64, i64 %43
 store i64 %43, i64* %8
 %46 = getelementptr i64, i8* %45, i64 0
 store i64 1, i64* %46
 store i64 0, i64* %9
 br label %47
47:
 %48 = load i64, i64* %9
 %49 = add i64 %48, 1
 store i64 %49, i64* %9
 %50 = load i64, i64* %6
 %51 = icmp sle i64 %49, %50
 br i1 %51, label %52, label %61
52:
 %53 = load i64, i64* %9
 %54 = load i64, i64* %9
 %55 = sub i64 %54, 1
 %56 = getelementptr i64, i8* %45, i64 %55
 %57 = load i64, i64* %56
 %58 = mul i64 %53, %57
 %59 = load i64, i64* %9
 %60 = getelementptr i64, i8* %45, i64 %59
 store i64 %58, i64* %60
 br label %47
61:
 %62 = load i64, i64* %6
 %63 = getelementptr i64, i8* %45, i64 %62
 %64 = load i64, i64* %63
 %65 = load i64, i64* %6
 %66 = getelementptr i64, i8* %45, i64 %65
 %67 = load i64, i64* %66
 %68 = icmp slt i64 %67, 12
 %69 = zext i1 %68 to i64
 %70 = select i1 %68, i32 1, i32 12
 %71 = sext i32 %70 to i64
 %72 = sdiv i64 %64, %71
 store i64 %72, i64* %10
 store i64 0, i64* %11
 store i64 0, i64* %12
 store i64 0, i64* %13
 br label %73
73:
 %74 = load i64, i64* %13
 %75 = load i64, i64* %6
 %76 = getelementptr i64, i8* %45, i64 %75
 %77 = load i64, i64* %76
 %78 = icmp slt i64 %74, %77
 br i1 %78, label %79, label %324
79:
 %80 = load i64, i64* %6
 %81 = add i32 0, 0
 %82 = alloca i64, i64 %80
 store i64 %80, i64* %15
 %83 = load i64, i64* %6
 %84 = alloca i8, i64 %83
 store i64 %83, i64* %16
 %85 = load i64, i64* %6
 %86 = alloca i8, i64 %85
 store i64 %85, i64* %17
 %87 = getelementptr i64, i8* %82, i64 0
 store i64 0, i64* %87
 store i64 0, i64* %18
 br label %88
88:
 %89 = load i64, i64* %18
 %90 = load i64, i64* %6
 %91 = icmp slt i64 %89, %90
 br i1 %91, label %92, label %100
92:
 %93 = load i64, i64* %18
 %94 = trunc i64 %93 to i8
 %95 = load i64, i64* %18
 %96 = getelementptr i8, i8* %86, i64 %95
 store i8 %94, i8* %96
 br label %97
97:
 %98 = load i64, i64* %18
 %99 = add i64 %98, 1
 store i64 %99, i64* %18
 br label %88
100:
 %101 = load i64, i64* %6
 %102 = sub i64 %101, 1
 store i64 %102, i64* %19
 %103 = load i64, i64* %13
 store i64 %103, i64* %20
 br label %104
104:
 %105 = load i64, i64* %19
 %106 = icmp sgt i64 %105, 0
 br i1 %106, label %107, label %174
107:
 %108 = load i64, i64* %20
 %109 = load i64, i64* %19
 %110 = getelementptr i64, i8* %45, i64 %109
 %111 = load i64, i64* %110
 %112 = sdiv i64 %108, %111
 store i64 %112, i64* %21
 %113 = load i64, i64* %20
 %114 = load i64, i64* %19
 %115 = getelementptr i64, i8* %45, i64 %114
 %116 = load i64, i64* %115
 %117 = srem i64 %113, %116
 store i64 %117, i64* %20
 %118 = load i64, i64* %21
 %119 = load i64, i64* %19
 %120 = getelementptr i64, i8* %82, i64 %119
 store i64 %118, i64* %120
 store i64 0, i64* %22
 br label %121
121:
 %122 = load i64, i64* %22
 %123 = load i64, i64* %6
 %124 = icmp slt i64 %122, %123
 br i1 %124, label %125, label %134
125:
 %126 = load i64, i64* %22
 %127 = getelementptr i8, i8* %86, i64 %126
 %128 = load i8, i8* %127
 %129 = load i64, i64* %22
 %130 = getelementptr i8, i8* %84, i64 %129
 store i8 %128, i8* %130
 br label %131
131:
 %132 = load i64, i64* %22
 %133 = add i64 %132, 1
 store i64 %133, i64* %22
 br label %121
134:
 store i64 0, i64* %23
 br label %135
135:
 %136 = load i64, i64* %23
 %137 = load i64, i64* %19
 %138 = icmp sle i64 %136, %137
 br i1 %138, label %139, label %170
139:
 %140 = load i64, i64* %23
 %141 = load i64, i64* %21
 %142 = add i64 %140, %141
 %143 = load i64, i64* %19
 %144 = icmp sle i64 %142, %143
 br i1 %144, label %145, label %152
145:
 %146 = load i64, i64* %23
 %147 = load i64, i64* %21
 %148 = add i64 %146, %147
 %149 = getelementptr i8, i8* %84, i64 %148
 %150 = load i8, i8* %149
 %151 = sext i8 %150 to i32
 br label %162
152:
 %153 = load i64, i64* %23
 %154 = load i64, i64* %21
 %155 = add i64 %153, %154
 %156 = load i64, i64* %19
 %157 = sub i64 %155, %156
 %158 = sub i64 %157, 1
 %159 = getelementptr i8, i8* %84, i64 %158
 %160 = load i8, i8* %159
 %161 = sext i8 %160 to i32
 br label %162
162:
 %163 = phi i32 [%151, %145], [%161, %152]
 %164 = trunc i32 %163 to i8
 %165 = load i64, i64* %23
 %166 = getelementptr i8, i8* %86, i64 %165
 store i8 %164, i8* %166
 br label %167
167:
 %168 = load i64, i64* %23
 %169 = add i64 %168, 1
 store i64 %169, i64* %23
 br label %135
170:
 br label %171
171:
 %172 = load i64, i64* %19
 %173 = add i64 %172, -1
 store i64 %173, i64* %19
 br label %104
174:
 %175 = load i64, i64* %13
 %176 = load i64, i64* %10
 %177 = add i64 %175, %176
 %178 = sub i64 %177, 1
 store i64 %178, i64* %24
 %179 = load i64, i64* %13
 store i64 %179, i64* %25
 br label %180
180:
 %181 = getelementptr i8, i8* %86, i64 0
 %182 = load i8, i8* %181
 %183 = sext i8 %182 to i32
 %184 = icmp sgt i32 %183, 0
 br i1 %184, label %185, label %270
185:
 store i64 0, i64* %26
 br label %186
186:
 %187 = load i64, i64* %26
 %188 = add i64 %187, 1
 store i64 %188, i64* %26
 %189 = load i64, i64* %6
 %190 = icmp slt i64 %188, %189
 br i1 %190, label %191, label %197
191:
 %192 = load i64, i64* %26
 %193 = getelementptr i8, i8* %86, i64 %192
 %194 = load i8, i8* %193
 %195 = load i64, i64* %26
 %196 = getelementptr i8, i8* %84, i64 %195
 store i8 %194, i8* %196
 br label %186
197:
 store i64 1, i64* %27
 %198 = getelementptr i8, i8* %86, i64 0
 %199 = load i8, i8* %198
 %200 = sext i8 %199 to i64
 store i64 %200, i64* %28
 br label %201
201:
 %202 = load i64, i64* %28
 %203 = getelementptr i8, i8* %84, i64 %202
 %204 = load i8, i8* %203
 %205 = sext i8 %204 to i32
 %206 = icmp sgt i32 %205, 0
 br i1 %206, label %207, label %251
207:
 %208 = load i64, i64* %28
 %209 = getelementptr i8, i8* %84, i64 %208
 %210 = load i8, i8* %209
 store i8 %210, i8* %29
 %211 = load i64, i64* %28
 %212 = trunc i64 %211 to i8
 %213 = load i64, i64* %28
 %214 = getelementptr i8, i8* %84, i64 %213
 store i8 %212, i8* %214
 %215 = load i64, i64* %28
 %216 = icmp sgt i64 %215, 2
 br i1 %216, label %217, label %245
217:
 store i64 1, i64* %30
 %218 = load i64, i64* %28
 %219 = sub i64 %218, 1
 store i64 %219, i64* %31
 br label %220
220:
 %221 = load i64, i64* %31
 %222 = getelementptr i8, i8* %84, i64 %221
 %223 = load i8, i8* %222
 store i8 %223, i8* %32
 %224 = load i64, i64* %30
 %225 = getelementptr i8, i8* %84, i64 %224
 %226 = load i8, i8* %225
 %227 = load i64, i64* %31
 %228 = getelementptr i8, i8* %84, i64 %227
 store i8 %226, i8* %228
 %229 = load i8, i8* %32
 %230 = load i64, i64* %30
 %231 = getelementptr i8, i8* %84, i64 %230
 store i8 %229, i8* %231
 br label %232
232:
 %233 = load i64, i64* %30
 %234 = add i64 %233, 1
 store i64 %234, i64* %30
 %235 = add i64 %233, 3
 %236 = load i64, i64* %31
 %237 = add i64 %236, -1
 store i64 %237, i64* %31
 %238 = icmp sle i64 %235, %236
 br i1 %238, label %239, label %242
239:
 %240 = load i64, i64* %30
 %241 = icmp slt i64 %240, 16
 br label %242
242:
 %243 = phi i1 [0, %232], [%241, %239]
 br i1 %243, label %220, label %244
244:
 br label %245
245:
 %246 = load i8, i8* %29
 %247 = sext i8 %246 to i64
 store i64 %247, i64* %28
 br label %248
248:
 %249 = load i64, i64* %27
 %250 = add i64 %249, 1
 store i64 %250, i64* %27
 br label %201
251:
 %252 = load i64, i64* %25
 %253 = srem i64 %252, 2
 %254 = icmp eq i64 %253, 0
 br i1 %254, label %255, label %259
255:
 %256 = load i64, i64* %27
 %257 = load i64, i64* %12
 %258 = add i64 %257, %256
 store i64 %258, i64* %12
 br label %263
259:
 %260 = load i64, i64* %27
 %261 = load i64, i64* %12
 %262 = sub i64 %261, %260
 store i64 %262, i64* %12
 br label %263
263:
 %264 = load i64, i64* %27
 %265 = load i64, i64* %11
 %266 = icmp sgt i64 %264, %265
 br i1 %266, label %267, label %269
267:
 %268 = load i64, i64* %27
 store i64 %268, i64* %11
 br label %269
269:
 br label %270
270:
 %271 = load i64, i64* %25
 %272 = load i64, i64* %24
 %273 = icmp sge i64 %271, %272
 br i1 %273, label %274, label %275
274:
 br label %318
275:
 %276 = getelementptr i8, i8* %86, i64 1
 %277 = load i8, i8* %276
 store i8 %277, i8* %33
 %278 = getelementptr i8, i8* %86, i64 0
 %279 = load i8, i8* %278
 %280 = getelementptr i8, i8* %86, i64 1
 store i8 %279, i8* %280
 %281 = load i8, i8* %33
 %282 = getelementptr i8, i8* %86, i64 0
 store i8 %281, i8* %282
 store i64 1, i64* %34
 br label %283
283:
 %284 = load i64, i64* %34
 %285 = getelementptr i64, i8* %82, i64 %284
 %286 = load i64, i64* %285
 %287 = add i64 %286, 1
 store i64 %287, i64* %285
 %288 = load i64, i64* %34
 %289 = icmp sgt i64 %287, %288
 br i1 %289, label %290, label %314
290:
 %291 = load i64, i64* %34
 %292 = add i64 %291, 1
 store i64 %292, i64* %34
 %293 = getelementptr i64, i8* %82, i64 %291
 store i64 0, i64* %293
 %294 = getelementptr i8, i8* %86, i64 1
 %295 = load i8, i8* %294
 %296 = getelementptr i8, i8* %86, i64 0
 store i8 %295, i8* %296
 store i8 %295, i8* %35
 store i64 0, i64* %36
 br label %297
297:
 %298 = load i64, i64* %36
 %299 = add i64 %298, 1
 store i64 %299, i64* %36
 %300 = load i64, i64* %34
 %301 = icmp slt i64 %299, %300
 br i1 %301, label %302, label %309
302:
 %303 = load i64, i64* %36
 %304 = add i64 %303, 1
 %305 = getelementptr i8, i8* %86, i64 %304
 %306 = load i8, i8* %305
 %307 = load i64, i64* %36
 %308 = getelementptr i8, i8* %86, i64 %307
 store i8 %306, i8* %308
 br label %297
309:
 %310 = load i8, i8* %33
 %311 = load i64, i64* %34
 %312 = getelementptr i8, i8* %86, i64 %311
 store i8 %310, i8* %312
 %313 = load i8, i8* %35
 store i8 %313, i8* %33
 br label %283
314:
 br label %315
315:
 %316 = load i64, i64* %25
 %317 = add i64 %316, 1
 store i64 %317, i64* %25
 br label %180
318:
 %319 = load i8*, i8** %14
 br label %320
320:
 %321 = load i64, i64* %10
 %322 = load i64, i64* %13
 %323 = add i64 %322, %321
 store i64 %323, i64* %13
 br label %73
324:
 %325 = load i64, i64* %12
 %326 = load i64, i64* %6
 %327 = load i64, i64* %11
 %328 = call i32 (i8*, ...) @printf (i8* @.str, i64 %325, i64 %326, i64 %327)
 store i32 0, i32* %3
 %329 = load i8*, i8** %7
 %330 = load i32, i32* %3
 ret i32 %330
}
