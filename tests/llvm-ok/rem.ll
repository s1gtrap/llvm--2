@.str = global [37 x i8] c"Test #%u, failed in iteration #: %u\0A\00"
@.str.1 = global [22 x i8] c"Failing test vector:\0A\00"
@.str.2 = global [54 x i8] c"m=%u, x_u=%u, y_u=%u, z_u=%u, x_s=%d, y_s=%d, z_s=%d\0A\00"
@.str.3 = global [26 x i8] c"\0A *** REM test done! ***\0A\00"

declare i32 @rand()
declare i32 @printf(i8*, ...)

define i64 @gcd (i64 %0, i64 %1) {
 %3 = alloca i64
 %4 = alloca i64
 %5 = alloca i64
 store i64 %0, i64* %3
 store i64 %1, i64* %4
 br label %6
6:
 %7 = load i64, i64* %3
 %8 = load i64, i64* %4
 %9 = srem i64 %7, %8
 store i64 %9, i64* %5
 %10 = load i64, i64* %5
 %11 = icmp eq i64 %10, 0
 br i1 %11, label %12, label %14
12:
 %13 = load i64, i64* %4
 ret i64 %13
14:
 %15 = load i64, i64* %4
 store i64 %15, i64* %3
 %16 = load i64, i64* %5
 store i64 %16, i64* %4
 br label %6
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 %12 = alloca i32
 %13 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 0, i32* %6
 br label %14
14:
 %15 = load i32, i32* %6
 %16 = icmp ult i32 %15, 100
 br i1 %16, label %17, label %1499
17:
 %18 = call i32 @rand ()
 store i32 %18, i32* %7
 %19 = load i32, i32* %7
 %20 = icmp eq i32 %19, 0
 br i1 %20, label %21, label %24
21:
 %22 = load i32, i32* %6
 %23 = add i32 %22, -1
 store i32 %23, i32* %6
 br label %1496
24:
 %25 = call i32 @rand ()
 store i32 %25, i32* %8
 %26 = call i32 @rand ()
 store i32 %26, i32* %9
 %27 = call i32 @rand ()
 store i32 %27, i32* %10
 %28 = call i32 @rand ()
 %29 = srem i32 %28, 2
 %30 = icmp ne i32 %29, 0
 br i1 %30, label %31, label %33
31:
 %32 = call i32 @rand ()
 br label %36
33:
 %34 = call i32 @rand ()
 %35 = sub i32 0, %34
 br label %36
36:
 %37 = phi i32 [%32, %31], [%35, %33]
 store i32 %37, i32* %11
 %38 = call i32 @rand ()
 %39 = srem i32 %38, 2
 %40 = icmp ne i32 %39, 0
 br i1 %40, label %41, label %43
41:
 %42 = call i32 @rand ()
 br label %46
43:
 %44 = call i32 @rand ()
 %45 = sub i32 0, %44
 br label %46
46:
 %47 = phi i32 [%42, %41], [%45, %43]
 store i32 %47, i32* %12
 %48 = call i32 @rand ()
 %49 = srem i32 %48, 2
 %50 = icmp ne i32 %49, 0
 br i1 %50, label %51, label %53
51:
 %52 = call i32 @rand ()
 br label %56
53:
 %54 = call i32 @rand ()
 %55 = sub i32 0, %54
 br label %56
56:
 %57 = phi i32 [%52, %51], [%55, %53]
 store i32 %57, i32* %13
 %58 = load i32, i32* %11
 %59 = load i32, i32* %12
 %60 = icmp ne i32 %58, %59
 br i1 %60, label %81, label %61
61:
 %62 = load i32, i32* %11
 %63 = load i32, i32* %7
 %64 = urem i32 %62, %63
 %65 = load i32, i32* %12
 %66 = load i32, i32* %7
 %67 = urem i32 %65, %66
 %68 = icmp eq i32 %64, %67
 br i1 %68, label %81, label %69
69:
 %70 = load i32, i32* %6
 %71 = call i32 (i8*, ...) @printf (i8* @.str, i32 1, i32 %70)
 %72 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %73 = load i32, i32* %7
 %74 = load i32, i32* %8
 %75 = load i32, i32* %9
 %76 = load i32, i32* %10
 %77 = load i32, i32* %11
 %78 = load i32, i32* %12
 %79 = load i32, i32* %13
 %80 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %73, i32 %74, i32 %75, i32 %76, i32 %77, i32 %78, i32 %79)
 store i32 1, i32* %3
 br label %1501
81:
 %82 = load i32, i32* %11
 %83 = load i32, i32* %9
 %84 = icmp ne i32 %82, %83
 br i1 %84, label %105, label %85
85:
 %86 = load i32, i32* %11
 %87 = load i32, i32* %7
 %88 = urem i32 %86, %87
 %89 = load i32, i32* %9
 %90 = load i32, i32* %7
 %91 = urem i32 %89, %90
 %92 = icmp eq i32 %88, %91
 br i1 %92, label %105, label %93
93:
 %94 = load i32, i32* %6
 %95 = call i32 (i8*, ...) @printf (i8* @.str, i32 2, i32 %94)
 %96 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %97 = load i32, i32* %7
 %98 = load i32, i32* %8
 %99 = load i32, i32* %9
 %100 = load i32, i32* %10
 %101 = load i32, i32* %11
 %102 = load i32, i32* %12
 %103 = load i32, i32* %13
 %104 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %97, i32 %98, i32 %99, i32 %100, i32 %101, i32 %102, i32 %103)
 store i32 1, i32* %3
 br label %1501
105:
 %106 = load i32, i32* %8
 %107 = load i32, i32* %12
 %108 = icmp ne i32 %106, %107
 br i1 %108, label %129, label %109
109:
 %110 = load i32, i32* %8
 %111 = load i32, i32* %7
 %112 = urem i32 %110, %111
 %113 = load i32, i32* %12
 %114 = load i32, i32* %7
 %115 = urem i32 %113, %114
 %116 = icmp eq i32 %112, %115
 br i1 %116, label %129, label %117
117:
 %118 = load i32, i32* %6
 %119 = call i32 (i8*, ...) @printf (i8* @.str, i32 3, i32 %118)
 %120 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %121 = load i32, i32* %7
 %122 = load i32, i32* %8
 %123 = load i32, i32* %9
 %124 = load i32, i32* %10
 %125 = load i32, i32* %11
 %126 = load i32, i32* %12
 %127 = load i32, i32* %13
 %128 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %121, i32 %122, i32 %123, i32 %124, i32 %125, i32 %126, i32 %127)
 store i32 1, i32* %3
 br label %1501
129:
 %130 = load i32, i32* %8
 %131 = load i32, i32* %9
 %132 = icmp ne i32 %130, %131
 br i1 %132, label %153, label %133
133:
 %134 = load i32, i32* %8
 %135 = load i32, i32* %7
 %136 = urem i32 %134, %135
 %137 = load i32, i32* %9
 %138 = load i32, i32* %7
 %139 = urem i32 %137, %138
 %140 = icmp eq i32 %136, %139
 br i1 %140, label %153, label %141
141:
 %142 = load i32, i32* %6
 %143 = call i32 (i8*, ...) @printf (i8* @.str, i32 4, i32 %142)
 %144 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %145 = load i32, i32* %7
 %146 = load i32, i32* %8
 %147 = load i32, i32* %9
 %148 = load i32, i32* %10
 %149 = load i32, i32* %11
 %150 = load i32, i32* %12
 %151 = load i32, i32* %13
 %152 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %145, i32 %146, i32 %147, i32 %148, i32 %149, i32 %150, i32 %151)
 store i32 1, i32* %3
 br label %1501
153:
 %154 = load i32, i32* %8
 %155 = load i32, i32* %7
 %156 = urem i32 %154, %155
 %157 = load i32, i32* %9
 %158 = load i32, i32* %7
 %159 = urem i32 %157, %158
 %160 = add i32 %156, %159
 %161 = load i32, i32* %8
 %162 = load i32, i32* %7
 %163 = urem i32 %161, %162
 %164 = icmp ult i32 %160, %163
 br i1 %164, label %199, label %165
165:
 %166 = load i32, i32* %8
 %167 = load i32, i32* %9
 %168 = add i32 %166, %167
 %169 = load i32, i32* %8
 %170 = icmp ult i32 %168, %169
 br i1 %170, label %199, label %171
171:
 %172 = load i32, i32* %8
 %173 = load i32, i32* %7
 %174 = urem i32 %172, %173
 %175 = load i32, i32* %9
 %176 = load i32, i32* %7
 %177 = urem i32 %175, %176
 %178 = add i32 %174, %177
 %179 = load i32, i32* %7
 %180 = urem i32 %178, %179
 %181 = load i32, i32* %8
 %182 = load i32, i32* %9
 %183 = add i32 %181, %182
 %184 = load i32, i32* %7
 %185 = urem i32 %183, %184
 %186 = icmp eq i32 %180, %185
 br i1 %186, label %199, label %187
187:
 %188 = load i32, i32* %6
 %189 = call i32 (i8*, ...) @printf (i8* @.str, i32 5, i32 %188)
 %190 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %191 = load i32, i32* %7
 %192 = load i32, i32* %8
 %193 = load i32, i32* %9
 %194 = load i32, i32* %10
 %195 = load i32, i32* %11
 %196 = load i32, i32* %12
 %197 = load i32, i32* %13
 %198 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %191, i32 %192, i32 %193, i32 %194, i32 %195, i32 %196, i32 %197)
 store i32 1, i32* %3
 br label %1501
199:
 %200 = load i32, i32* %9
 %201 = load i32, i32* %10
 %202 = add i32 %200, %201
 %203 = load i32, i32* %9
 %204 = icmp ult i32 %202, %203
 br i1 %204, label %247, label %205
205:
 %206 = load i32, i32* %8
 %207 = load i32, i32* %10
 %208 = sub i32 %206, %207
 %209 = load i32, i32* %8
 %210 = icmp ugt i32 %208, %209
 br i1 %210, label %247, label %211
211:
 %212 = load i32, i32* %8
 %213 = load i32, i32* %7
 %214 = urem i32 %212, %213
 %215 = load i32, i32* %9
 %216 = load i32, i32* %10
 %217 = add i32 %215, %216
 %218 = load i32, i32* %7
 %219 = urem i32 %217, %218
 %220 = icmp eq i32 %214, %219
 %221 = zext i1 %220 to i32
 %222 = load i32, i32* %7
 %223 = urem i32 %221, %222
 %224 = load i32, i32* %8
 %225 = load i32, i32* %10
 %226 = sub i32 %224, %225
 %227 = load i32, i32* %7
 %228 = urem i32 %226, %227
 %229 = load i32, i32* %9
 %230 = load i32, i32* %7
 %231 = urem i32 %229, %230
 %232 = icmp eq i32 %228, %231
 %233 = zext i1 %232 to i32
 %234 = icmp eq i32 %223, %233
 br i1 %234, label %247, label %235
235:
 %236 = load i32, i32* %6
 %237 = call i32 (i8*, ...) @printf (i8* @.str, i32 6, i32 %236)
 %238 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %239 = load i32, i32* %7
 %240 = load i32, i32* %8
 %241 = load i32, i32* %9
 %242 = load i32, i32* %10
 %243 = load i32, i32* %11
 %244 = load i32, i32* %12
 %245 = load i32, i32* %13
 %246 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %239, i32 %240, i32 %241, i32 %242, i32 %243, i32 %244, i32 %245)
 store i32 1, i32* %3
 br label %1501
247:
 %248 = load i32, i32* %9
 %249 = load i32, i32* %7
 %250 = mul i32 %248, %249
 %251 = load i32, i32* %7
 %252 = udiv i32 %250, %251
 %253 = load i32, i32* %9
 %254 = icmp ne i32 %252, %253
 br i1 %254, label %287, label %255
255:
 %256 = load i32, i32* %8
 %257 = load i32, i32* %9
 %258 = load i32, i32* %7
 %259 = mul i32 %257, %258
 %260 = add i32 %256, %259
 %261 = load i32, i32* %8
 %262 = icmp ult i32 %260, %261
 br i1 %262, label %287, label %263
263:
 %264 = load i32, i32* %8
 %265 = load i32, i32* %7
 %266 = urem i32 %264, %265
 %267 = load i32, i32* %8
 %268 = load i32, i32* %9
 %269 = load i32, i32* %7
 %270 = mul i32 %268, %269
 %271 = add i32 %267, %270
 %272 = load i32, i32* %7
 %273 = urem i32 %271, %272
 %274 = icmp eq i32 %266, %273
 br i1 %274, label %287, label %275
275:
 %276 = load i32, i32* %6
 %277 = call i32 (i8*, ...) @printf (i8* @.str, i32 7, i32 %276)
 %278 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %279 = load i32, i32* %7
 %280 = load i32, i32* %8
 %281 = load i32, i32* %9
 %282 = load i32, i32* %10
 %283 = load i32, i32* %11
 %284 = load i32, i32* %12
 %285 = load i32, i32* %13
 %286 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %279, i32 %280, i32 %281, i32 %282, i32 %283, i32 %284, i32 %285)
 store i32 1, i32* %3
 br label %1501
287:
 %288 = load i32, i32* %13
 %289 = sext i32 %288 to i64
 %290 = load i32, i32* %7
 %291 = zext i32 %290 to i64
 %292 = call i64 @gcd (i64 %289, i64 %291)
 %293 = icmp ne i64 %292, 1
 br i1 %293, label %349, label %294
294:
 %295 = load i32, i32* %13
 %296 = icmp eq i32 %295, 0
 br i1 %296, label %349, label %297
297:
 %298 = load i32, i32* %11
 %299 = sext i32 %298 to i64
 %300 = load i32, i32* %13
 %301 = sext i32 %300 to i64
 %302 = call i64 @gcd (i64 %299, i64 %301)
 %303 = load i32, i32* %13
 %304 = sext i32 %303 to i64
 %305 = icmp ne i64 %302, %304
 br i1 %305, label %349, label %306
306:
 %307 = load i32, i32* %12
 %308 = sext i32 %307 to i64
 %309 = load i32, i32* %13
 %310 = sext i32 %309 to i64
 %311 = call i64 @gcd (i64 %308, i64 %310)
 %312 = load i32, i32* %13
 %313 = sext i32 %312 to i64
 %314 = icmp ne i64 %311, %313
 br i1 %314, label %349, label %315
315:
 %316 = load i32, i32* %11
 %317 = load i32, i32* %7
 %318 = urem i32 %316, %317
 %319 = load i32, i32* %12
 %320 = load i32, i32* %7
 %321 = urem i32 %319, %320
 %322 = icmp eq i32 %318, %321
 %323 = zext i1 %322 to i32
 %324 = load i32, i32* %11
 %325 = load i32, i32* %13
 %326 = sdiv i32 %324, %325
 %327 = load i32, i32* %7
 %328 = urem i32 %326, %327
 %329 = load i32, i32* %12
 %330 = load i32, i32* %13
 %331 = sdiv i32 %329, %330
 %332 = load i32, i32* %7
 %333 = urem i32 %331, %332
 %334 = icmp eq i32 %328, %333
 %335 = zext i1 %334 to i32
 %336 = icmp eq i32 %323, %335
 br i1 %336, label %349, label %337
337:
 %338 = load i32, i32* %6
 %339 = call i32 (i8*, ...) @printf (i8* @.str, i32 8, i32 %338)
 %340 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %341 = load i32, i32* %7
 %342 = load i32, i32* %8
 %343 = load i32, i32* %9
 %344 = load i32, i32* %10
 %345 = load i32, i32* %11
 %346 = load i32, i32* %12
 %347 = load i32, i32* %13
 %348 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %341, i32 %342, i32 %343, i32 %344, i32 %345, i32 %346, i32 %347)
 store i32 1, i32* %3
 br label %1501
349:
 %350 = load i32, i32* %10
 %351 = zext i32 %350 to i64
 %352 = load i32, i32* %7
 %353 = zext i32 %352 to i64
 %354 = call i64 @gcd (i64 %351, i64 %353)
 %355 = icmp ne i64 %354, 1
 br i1 %355, label %411, label %356
356:
 %357 = load i32, i32* %10
 %358 = icmp eq i32 %357, 0
 br i1 %358, label %411, label %359
359:
 %360 = load i32, i32* %11
 %361 = sext i32 %360 to i64
 %362 = load i32, i32* %10
 %363 = zext i32 %362 to i64
 %364 = call i64 @gcd (i64 %361, i64 %363)
 %365 = load i32, i32* %10
 %366 = zext i32 %365 to i64
 %367 = icmp ne i64 %364, %366
 br i1 %367, label %411, label %368
368:
 %369 = load i32, i32* %12
 %370 = sext i32 %369 to i64
 %371 = load i32, i32* %10
 %372 = zext i32 %371 to i64
 %373 = call i64 @gcd (i64 %370, i64 %372)
 %374 = load i32, i32* %10
 %375 = zext i32 %374 to i64
 %376 = icmp ne i64 %373, %375
 br i1 %376, label %411, label %377
377:
 %378 = load i32, i32* %11
 %379 = load i32, i32* %7
 %380 = urem i32 %378, %379
 %381 = load i32, i32* %12
 %382 = load i32, i32* %7
 %383 = urem i32 %381, %382
 %384 = icmp eq i32 %380, %383
 %385 = zext i1 %384 to i32
 %386 = load i32, i32* %11
 %387 = load i32, i32* %10
 %388 = udiv i32 %386, %387
 %389 = load i32, i32* %7
 %390 = urem i32 %388, %389
 %391 = load i32, i32* %12
 %392 = load i32, i32* %10
 %393 = udiv i32 %391, %392
 %394 = load i32, i32* %7
 %395 = urem i32 %393, %394
 %396 = icmp eq i32 %390, %395
 %397 = zext i1 %396 to i32
 %398 = icmp eq i32 %385, %397
 br i1 %398, label %411, label %399
399:
 %400 = load i32, i32* %6
 %401 = call i32 (i8*, ...) @printf (i8* @.str, i32 9, i32 %400)
 %402 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %403 = load i32, i32* %7
 %404 = load i32, i32* %8
 %405 = load i32, i32* %9
 %406 = load i32, i32* %10
 %407 = load i32, i32* %11
 %408 = load i32, i32* %12
 %409 = load i32, i32* %13
 %410 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %403, i32 %404, i32 %405, i32 %406, i32 %407, i32 %408, i32 %409)
 store i32 1, i32* %3
 br label %1501
411:
 %412 = load i32, i32* %13
 %413 = sext i32 %412 to i64
 %414 = load i32, i32* %7
 %415 = zext i32 %414 to i64
 %416 = call i64 @gcd (i64 %413, i64 %415)
 %417 = icmp ne i64 %416, 1
 br i1 %417, label %473, label %418
418:
 %419 = load i32, i32* %13
 %420 = icmp eq i32 %419, 0
 br i1 %420, label %473, label %421
421:
 %422 = load i32, i32* %11
 %423 = sext i32 %422 to i64
 %424 = load i32, i32* %13
 %425 = sext i32 %424 to i64
 %426 = call i64 @gcd (i64 %423, i64 %425)
 %427 = load i32, i32* %13
 %428 = sext i32 %427 to i64
 %429 = icmp ne i64 %426, %428
 br i1 %429, label %473, label %430
430:
 %431 = load i32, i32* %9
 %432 = zext i32 %431 to i64
 %433 = load i32, i32* %13
 %434 = sext i32 %433 to i64
 %435 = call i64 @gcd (i64 %432, i64 %434)
 %436 = load i32, i32* %13
 %437 = sext i32 %436 to i64
 %438 = icmp ne i64 %435, %437
 br i1 %438, label %473, label %439
439:
 %440 = load i32, i32* %11
 %441 = load i32, i32* %7
 %442 = urem i32 %440, %441
 %443 = load i32, i32* %9
 %444 = load i32, i32* %7
 %445 = urem i32 %443, %444
 %446 = icmp eq i32 %442, %445
 %447 = zext i1 %446 to i32
 %448 = load i32, i32* %11
 %449 = load i32, i32* %13
 %450 = sdiv i32 %448, %449
 %451 = load i32, i32* %7
 %452 = urem i32 %450, %451
 %453 = load i32, i32* %9
 %454 = load i32, i32* %13
 %455 = udiv i32 %453, %454
 %456 = load i32, i32* %7
 %457 = urem i32 %455, %456
 %458 = icmp eq i32 %452, %457
 %459 = zext i1 %458 to i32
 %460 = icmp eq i32 %447, %459
 br i1 %460, label %473, label %461
461:
 %462 = load i32, i32* %6
 %463 = call i32 (i8*, ...) @printf (i8* @.str, i32 10, i32 %462)
 %464 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %465 = load i32, i32* %7
 %466 = load i32, i32* %8
 %467 = load i32, i32* %9
 %468 = load i32, i32* %10
 %469 = load i32, i32* %11
 %470 = load i32, i32* %12
 %471 = load i32, i32* %13
 %472 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %465, i32 %466, i32 %467, i32 %468, i32 %469, i32 %470, i32 %471)
 store i32 1, i32* %3
 br label %1501
473:
 %474 = load i32, i32* %10
 %475 = zext i32 %474 to i64
 %476 = load i32, i32* %7
 %477 = zext i32 %476 to i64
 %478 = call i64 @gcd (i64 %475, i64 %477)
 %479 = icmp ne i64 %478, 1
 br i1 %479, label %535, label %480
480:
 %481 = load i32, i32* %10
 %482 = icmp eq i32 %481, 0
 br i1 %482, label %535, label %483
483:
 %484 = load i32, i32* %11
 %485 = sext i32 %484 to i64
 %486 = load i32, i32* %10
 %487 = zext i32 %486 to i64
 %488 = call i64 @gcd (i64 %485, i64 %487)
 %489 = load i32, i32* %10
 %490 = zext i32 %489 to i64
 %491 = icmp ne i64 %488, %490
 br i1 %491, label %535, label %492
492:
 %493 = load i32, i32* %9
 %494 = zext i32 %493 to i64
 %495 = load i32, i32* %10
 %496 = zext i32 %495 to i64
 %497 = call i64 @gcd (i64 %494, i64 %496)
 %498 = load i32, i32* %10
 %499 = zext i32 %498 to i64
 %500 = icmp ne i64 %497, %499
 br i1 %500, label %535, label %501
501:
 %502 = load i32, i32* %11
 %503 = load i32, i32* %7
 %504 = urem i32 %502, %503
 %505 = load i32, i32* %9
 %506 = load i32, i32* %7
 %507 = urem i32 %505, %506
 %508 = icmp eq i32 %504, %507
 %509 = zext i1 %508 to i32
 %510 = load i32, i32* %11
 %511 = load i32, i32* %10
 %512 = udiv i32 %510, %511
 %513 = load i32, i32* %7
 %514 = urem i32 %512, %513
 %515 = load i32, i32* %9
 %516 = load i32, i32* %10
 %517 = udiv i32 %515, %516
 %518 = load i32, i32* %7
 %519 = urem i32 %517, %518
 %520 = icmp eq i32 %514, %519
 %521 = zext i1 %520 to i32
 %522 = icmp eq i32 %509, %521
 br i1 %522, label %535, label %523
523:
 %524 = load i32, i32* %6
 %525 = call i32 (i8*, ...) @printf (i8* @.str, i32 11, i32 %524)
 %526 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %527 = load i32, i32* %7
 %528 = load i32, i32* %8
 %529 = load i32, i32* %9
 %530 = load i32, i32* %10
 %531 = load i32, i32* %11
 %532 = load i32, i32* %12
 %533 = load i32, i32* %13
 %534 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %527, i32 %528, i32 %529, i32 %530, i32 %531, i32 %532, i32 %533)
 store i32 1, i32* %3
 br label %1501
535:
 %536 = load i32, i32* %13
 %537 = sext i32 %536 to i64
 %538 = load i32, i32* %7
 %539 = zext i32 %538 to i64
 %540 = call i64 @gcd (i64 %537, i64 %539)
 %541 = icmp ne i64 %540, 1
 br i1 %541, label %597, label %542
542:
 %543 = load i32, i32* %13
 %544 = icmp eq i32 %543, 0
 br i1 %544, label %597, label %545
545:
 %546 = load i32, i32* %8
 %547 = zext i32 %546 to i64
 %548 = load i32, i32* %13
 %549 = sext i32 %548 to i64
 %550 = call i64 @gcd (i64 %547, i64 %549)
 %551 = load i32, i32* %13
 %552 = sext i32 %551 to i64
 %553 = icmp ne i64 %550, %552
 br i1 %553, label %597, label %554
554:
 %555 = load i32, i32* %12
 %556 = sext i32 %555 to i64
 %557 = load i32, i32* %13
 %558 = sext i32 %557 to i64
 %559 = call i64 @gcd (i64 %556, i64 %558)
 %560 = load i32, i32* %13
 %561 = sext i32 %560 to i64
 %562 = icmp ne i64 %559, %561
 br i1 %562, label %597, label %563
563:
 %564 = load i32, i32* %8
 %565 = load i32, i32* %7
 %566 = urem i32 %564, %565
 %567 = load i32, i32* %12
 %568 = load i32, i32* %7
 %569 = urem i32 %567, %568
 %570 = icmp eq i32 %566, %569
 %571 = zext i1 %570 to i32
 %572 = load i32, i32* %8
 %573 = load i32, i32* %13
 %574 = udiv i32 %572, %573
 %575 = load i32, i32* %7
 %576 = urem i32 %574, %575
 %577 = load i32, i32* %12
 %578 = load i32, i32* %13
 %579 = sdiv i32 %577, %578
 %580 = load i32, i32* %7
 %581 = urem i32 %579, %580
 %582 = icmp eq i32 %576, %581
 %583 = zext i1 %582 to i32
 %584 = icmp eq i32 %571, %583
 br i1 %584, label %597, label %585
585:
 %586 = load i32, i32* %6
 %587 = call i32 (i8*, ...) @printf (i8* @.str, i32 12, i32 %586)
 %588 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %589 = load i32, i32* %7
 %590 = load i32, i32* %8
 %591 = load i32, i32* %9
 %592 = load i32, i32* %10
 %593 = load i32, i32* %11
 %594 = load i32, i32* %12
 %595 = load i32, i32* %13
 %596 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %589, i32 %590, i32 %591, i32 %592, i32 %593, i32 %594, i32 %595)
 store i32 1, i32* %3
 br label %1501
597:
 %598 = load i32, i32* %10
 %599 = zext i32 %598 to i64
 %600 = load i32, i32* %7
 %601 = zext i32 %600 to i64
 %602 = call i64 @gcd (i64 %599, i64 %601)
 %603 = icmp ne i64 %602, 1
 br i1 %603, label %659, label %604
604:
 %605 = load i32, i32* %10
 %606 = icmp eq i32 %605, 0
 br i1 %606, label %659, label %607
607:
 %608 = load i32, i32* %8
 %609 = zext i32 %608 to i64
 %610 = load i32, i32* %10
 %611 = zext i32 %610 to i64
 %612 = call i64 @gcd (i64 %609, i64 %611)
 %613 = load i32, i32* %10
 %614 = zext i32 %613 to i64
 %615 = icmp ne i64 %612, %614
 br i1 %615, label %659, label %616
616:
 %617 = load i32, i32* %12
 %618 = sext i32 %617 to i64
 %619 = load i32, i32* %10
 %620 = zext i32 %619 to i64
 %621 = call i64 @gcd (i64 %618, i64 %620)
 %622 = load i32, i32* %10
 %623 = zext i32 %622 to i64
 %624 = icmp ne i64 %621, %623
 br i1 %624, label %659, label %625
625:
 %626 = load i32, i32* %8
 %627 = load i32, i32* %7
 %628 = urem i32 %626, %627
 %629 = load i32, i32* %12
 %630 = load i32, i32* %7
 %631 = urem i32 %629, %630
 %632 = icmp eq i32 %628, %631
 %633 = zext i1 %632 to i32
 %634 = load i32, i32* %8
 %635 = load i32, i32* %10
 %636 = udiv i32 %634, %635
 %637 = load i32, i32* %7
 %638 = urem i32 %636, %637
 %639 = load i32, i32* %12
 %640 = load i32, i32* %10
 %641 = udiv i32 %639, %640
 %642 = load i32, i32* %7
 %643 = urem i32 %641, %642
 %644 = icmp eq i32 %638, %643
 %645 = zext i1 %644 to i32
 %646 = icmp eq i32 %633, %645
 br i1 %646, label %659, label %647
647:
 %648 = load i32, i32* %6
 %649 = call i32 (i8*, ...) @printf (i8* @.str, i32 13, i32 %648)
 %650 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %651 = load i32, i32* %7
 %652 = load i32, i32* %8
 %653 = load i32, i32* %9
 %654 = load i32, i32* %10
 %655 = load i32, i32* %11
 %656 = load i32, i32* %12
 %657 = load i32, i32* %13
 %658 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %651, i32 %652, i32 %653, i32 %654, i32 %655, i32 %656, i32 %657)
 store i32 1, i32* %3
 br label %1501
659:
 %660 = load i32, i32* %13
 %661 = sext i32 %660 to i64
 %662 = load i32, i32* %7
 %663 = zext i32 %662 to i64
 %664 = call i64 @gcd (i64 %661, i64 %663)
 %665 = icmp ne i64 %664, 1
 br i1 %665, label %721, label %666
666:
 %667 = load i32, i32* %13
 %668 = icmp eq i32 %667, 0
 br i1 %668, label %721, label %669
669:
 %670 = load i32, i32* %8
 %671 = zext i32 %670 to i64
 %672 = load i32, i32* %13
 %673 = sext i32 %672 to i64
 %674 = call i64 @gcd (i64 %671, i64 %673)
 %675 = load i32, i32* %13
 %676 = sext i32 %675 to i64
 %677 = icmp ne i64 %674, %676
 br i1 %677, label %721, label %678
678:
 %679 = load i32, i32* %9
 %680 = zext i32 %679 to i64
 %681 = load i32, i32* %13
 %682 = sext i32 %681 to i64
 %683 = call i64 @gcd (i64 %680, i64 %682)
 %684 = load i32, i32* %13
 %685 = sext i32 %684 to i64
 %686 = icmp ne i64 %683, %685
 br i1 %686, label %721, label %687
687:
 %688 = load i32, i32* %8
 %689 = load i32, i32* %7
 %690 = urem i32 %688, %689
 %691 = load i32, i32* %9
 %692 = load i32, i32* %7
 %693 = urem i32 %691, %692
 %694 = icmp eq i32 %690, %693
 %695 = zext i1 %694 to i32
 %696 = load i32, i32* %8
 %697 = load i32, i32* %13
 %698 = udiv i32 %696, %697
 %699 = load i32, i32* %7
 %700 = urem i32 %698, %699
 %701 = load i32, i32* %9
 %702 = load i32, i32* %13
 %703 = udiv i32 %701, %702
 %704 = load i32, i32* %7
 %705 = urem i32 %703, %704
 %706 = icmp eq i32 %700, %705
 %707 = zext i1 %706 to i32
 %708 = icmp eq i32 %695, %707
 br i1 %708, label %721, label %709
709:
 %710 = load i32, i32* %6
 %711 = call i32 (i8*, ...) @printf (i8* @.str, i32 14, i32 %710)
 %712 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %713 = load i32, i32* %7
 %714 = load i32, i32* %8
 %715 = load i32, i32* %9
 %716 = load i32, i32* %10
 %717 = load i32, i32* %11
 %718 = load i32, i32* %12
 %719 = load i32, i32* %13
 %720 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %713, i32 %714, i32 %715, i32 %716, i32 %717, i32 %718, i32 %719)
 store i32 1, i32* %3
 br label %1501
721:
 %722 = load i32, i32* %10
 %723 = zext i32 %722 to i64
 %724 = load i32, i32* %7
 %725 = zext i32 %724 to i64
 %726 = call i64 @gcd (i64 %723, i64 %725)
 %727 = icmp ne i64 %726, 1
 br i1 %727, label %783, label %728
728:
 %729 = load i32, i32* %10
 %730 = icmp eq i32 %729, 0
 br i1 %730, label %783, label %731
731:
 %732 = load i32, i32* %8
 %733 = zext i32 %732 to i64
 %734 = load i32, i32* %10
 %735 = zext i32 %734 to i64
 %736 = call i64 @gcd (i64 %733, i64 %735)
 %737 = load i32, i32* %10
 %738 = zext i32 %737 to i64
 %739 = icmp ne i64 %736, %738
 br i1 %739, label %783, label %740
740:
 %741 = load i32, i32* %9
 %742 = zext i32 %741 to i64
 %743 = load i32, i32* %10
 %744 = zext i32 %743 to i64
 %745 = call i64 @gcd (i64 %742, i64 %744)
 %746 = load i32, i32* %10
 %747 = zext i32 %746 to i64
 %748 = icmp ne i64 %745, %747
 br i1 %748, label %783, label %749
749:
 %750 = load i32, i32* %8
 %751 = load i32, i32* %7
 %752 = urem i32 %750, %751
 %753 = load i32, i32* %9
 %754 = load i32, i32* %7
 %755 = urem i32 %753, %754
 %756 = icmp eq i32 %752, %755
 %757 = zext i1 %756 to i32
 %758 = load i32, i32* %8
 %759 = load i32, i32* %10
 %760 = udiv i32 %758, %759
 %761 = load i32, i32* %7
 %762 = urem i32 %760, %761
 %763 = load i32, i32* %9
 %764 = load i32, i32* %10
 %765 = udiv i32 %763, %764
 %766 = load i32, i32* %7
 %767 = urem i32 %765, %766
 %768 = icmp eq i32 %762, %767
 %769 = zext i1 %768 to i32
 %770 = icmp eq i32 %757, %769
 br i1 %770, label %783, label %771
771:
 %772 = load i32, i32* %6
 %773 = call i32 (i8*, ...) @printf (i8* @.str, i32 15, i32 %772)
 %774 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %775 = load i32, i32* %7
 %776 = load i32, i32* %8
 %777 = load i32, i32* %9
 %778 = load i32, i32* %10
 %779 = load i32, i32* %11
 %780 = load i32, i32* %12
 %781 = load i32, i32* %13
 %782 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %775, i32 %776, i32 %777, i32 %778, i32 %779, i32 %780, i32 %781)
 store i32 1, i32* %3
 br label %1501
783:
 %784 = load i32, i32* %13
 %785 = icmp eq i32 %784, 0
 br i1 %785, label %851, label %786
786:
 %787 = load i32, i32* %11
 %788 = sext i32 %787 to i64
 %789 = load i32, i32* %13
 %790 = sext i32 %789 to i64
 %791 = call i64 @gcd (i64 %788, i64 %790)
 %792 = load i32, i32* %13
 %793 = sext i32 %792 to i64
 %794 = icmp ne i64 %791, %793
 br i1 %794, label %851, label %795
795:
 %796 = load i32, i32* %12
 %797 = sext i32 %796 to i64
 %798 = load i32, i32* %13
 %799 = sext i32 %798 to i64
 %800 = call i64 @gcd (i64 %797, i64 %799)
 %801 = load i32, i32* %13
 %802 = sext i32 %801 to i64
 %803 = icmp ne i64 %800, %802
 br i1 %803, label %851, label %804
804:
 %805 = load i32, i32* %7
 %806 = zext i32 %805 to i64
 %807 = load i32, i32* %13
 %808 = sext i32 %807 to i64
 %809 = call i64 @gcd (i64 %806, i64 %808)
 %810 = load i32, i32* %13
 %811 = sext i32 %810 to i64
 %812 = icmp ne i64 %809, %811
 br i1 %812, label %851, label %813
813:
 %814 = load i32, i32* %11
 %815 = load i32, i32* %7
 %816 = urem i32 %814, %815
 %817 = load i32, i32* %12
 %818 = load i32, i32* %7
 %819 = urem i32 %817, %818
 %820 = icmp eq i32 %816, %819
 %821 = zext i1 %820 to i32
 %822 = load i32, i32* %11
 %823 = load i32, i32* %13
 %824 = sdiv i32 %822, %823
 %825 = load i32, i32* %7
 %826 = load i32, i32* %13
 %827 = udiv i32 %825, %826
 %828 = urem i32 %824, %827
 %829 = load i32, i32* %12
 %830 = load i32, i32* %13
 %831 = sdiv i32 %829, %830
 %832 = load i32, i32* %7
 %833 = load i32, i32* %13
 %834 = udiv i32 %832, %833
 %835 = urem i32 %831, %834
 %836 = icmp eq i32 %828, %835
 %837 = zext i1 %836 to i32
 %838 = icmp eq i32 %821, %837
 br i1 %838, label %851, label %839
839:
 %840 = load i32, i32* %6
 %841 = call i32 (i8*, ...) @printf (i8* @.str, i32 16, i32 %840)
 %842 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %843 = load i32, i32* %7
 %844 = load i32, i32* %8
 %845 = load i32, i32* %9
 %846 = load i32, i32* %10
 %847 = load i32, i32* %11
 %848 = load i32, i32* %12
 %849 = load i32, i32* %13
 %850 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %843, i32 %844, i32 %845, i32 %846, i32 %847, i32 %848, i32 %849)
 store i32 1, i32* %3
 br label %1501
851:
 %852 = load i32, i32* %10
 %853 = icmp eq i32 %852, 0
 br i1 %853, label %919, label %854
854:
 %855 = load i32, i32* %11
 %856 = sext i32 %855 to i64
 %857 = load i32, i32* %10
 %858 = zext i32 %857 to i64
 %859 = call i64 @gcd (i64 %856, i64 %858)
 %860 = load i32, i32* %10
 %861 = zext i32 %860 to i64
 %862 = icmp ne i64 %859, %861
 br i1 %862, label %919, label %863
863:
 %864 = load i32, i32* %12
 %865 = sext i32 %864 to i64
 %866 = load i32, i32* %10
 %867 = zext i32 %866 to i64
 %868 = call i64 @gcd (i64 %865, i64 %867)
 %869 = load i32, i32* %10
 %870 = zext i32 %869 to i64
 %871 = icmp ne i64 %868, %870
 br i1 %871, label %919, label %872
872:
 %873 = load i32, i32* %7
 %874 = zext i32 %873 to i64
 %875 = load i32, i32* %10
 %876 = zext i32 %875 to i64
 %877 = call i64 @gcd (i64 %874, i64 %876)
 %878 = load i32, i32* %10
 %879 = zext i32 %878 to i64
 %880 = icmp ne i64 %877, %879
 br i1 %880, label %919, label %881
881:
 %882 = load i32, i32* %11
 %883 = load i32, i32* %7
 %884 = urem i32 %882, %883
 %885 = load i32, i32* %12
 %886 = load i32, i32* %7
 %887 = urem i32 %885, %886
 %888 = icmp eq i32 %884, %887
 %889 = zext i1 %888 to i32
 %890 = load i32, i32* %11
 %891 = load i32, i32* %10
 %892 = udiv i32 %890, %891
 %893 = load i32, i32* %7
 %894 = load i32, i32* %10
 %895 = udiv i32 %893, %894
 %896 = urem i32 %892, %895
 %897 = load i32, i32* %12
 %898 = load i32, i32* %10
 %899 = udiv i32 %897, %898
 %900 = load i32, i32* %7
 %901 = load i32, i32* %10
 %902 = udiv i32 %900, %901
 %903 = urem i32 %899, %902
 %904 = icmp eq i32 %896, %903
 %905 = zext i1 %904 to i32
 %906 = icmp eq i32 %889, %905
 br i1 %906, label %919, label %907
907:
 %908 = load i32, i32* %6
 %909 = call i32 (i8*, ...) @printf (i8* @.str, i32 17, i32 %908)
 %910 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %911 = load i32, i32* %7
 %912 = load i32, i32* %8
 %913 = load i32, i32* %9
 %914 = load i32, i32* %10
 %915 = load i32, i32* %11
 %916 = load i32, i32* %12
 %917 = load i32, i32* %13
 %918 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %911, i32 %912, i32 %913, i32 %914, i32 %915, i32 %916, i32 %917)
 store i32 1, i32* %3
 br label %1501
919:
 %920 = load i32, i32* %13
 %921 = icmp eq i32 %920, 0
 br i1 %921, label %987, label %922
922:
 %923 = load i32, i32* %11
 %924 = sext i32 %923 to i64
 %925 = load i32, i32* %13
 %926 = sext i32 %925 to i64
 %927 = call i64 @gcd (i64 %924, i64 %926)
 %928 = load i32, i32* %13
 %929 = sext i32 %928 to i64
 %930 = icmp ne i64 %927, %929
 br i1 %930, label %987, label %931
931:
 %932 = load i32, i32* %9
 %933 = zext i32 %932 to i64
 %934 = load i32, i32* %13
 %935 = sext i32 %934 to i64
 %936 = call i64 @gcd (i64 %933, i64 %935)
 %937 = load i32, i32* %13
 %938 = sext i32 %937 to i64
 %939 = icmp ne i64 %936, %938
 br i1 %939, label %987, label %940
940:
 %941 = load i32, i32* %7
 %942 = zext i32 %941 to i64
 %943 = load i32, i32* %13
 %944 = sext i32 %943 to i64
 %945 = call i64 @gcd (i64 %942, i64 %944)
 %946 = load i32, i32* %13
 %947 = sext i32 %946 to i64
 %948 = icmp ne i64 %945, %947
 br i1 %948, label %987, label %949
949:
 %950 = load i32, i32* %11
 %951 = load i32, i32* %7
 %952 = urem i32 %950, %951
 %953 = load i32, i32* %9
 %954 = load i32, i32* %7
 %955 = urem i32 %953, %954
 %956 = icmp eq i32 %952, %955
 %957 = zext i1 %956 to i32
 %958 = load i32, i32* %11
 %959 = load i32, i32* %13
 %960 = sdiv i32 %958, %959
 %961 = load i32, i32* %7
 %962 = load i32, i32* %13
 %963 = udiv i32 %961, %962
 %964 = urem i32 %960, %963
 %965 = load i32, i32* %9
 %966 = load i32, i32* %13
 %967 = udiv i32 %965, %966
 %968 = load i32, i32* %7
 %969 = load i32, i32* %13
 %970 = udiv i32 %968, %969
 %971 = urem i32 %967, %970
 %972 = icmp eq i32 %964, %971
 %973 = zext i1 %972 to i32
 %974 = icmp eq i32 %957, %973
 br i1 %974, label %987, label %975
975:
 %976 = load i32, i32* %6
 %977 = call i32 (i8*, ...) @printf (i8* @.str, i32 18, i32 %976)
 %978 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %979 = load i32, i32* %7
 %980 = load i32, i32* %8
 %981 = load i32, i32* %9
 %982 = load i32, i32* %10
 %983 = load i32, i32* %11
 %984 = load i32, i32* %12
 %985 = load i32, i32* %13
 %986 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %979, i32 %980, i32 %981, i32 %982, i32 %983, i32 %984, i32 %985)
 store i32 1, i32* %3
 br label %1501
987:
 %988 = load i32, i32* %10
 %989 = icmp eq i32 %988, 0
 br i1 %989, label %1055, label %990
990:
 %991 = load i32, i32* %11
 %992 = sext i32 %991 to i64
 %993 = load i32, i32* %10
 %994 = zext i32 %993 to i64
 %995 = call i64 @gcd (i64 %992, i64 %994)
 %996 = load i32, i32* %10
 %997 = zext i32 %996 to i64
 %998 = icmp ne i64 %995, %997
 br i1 %998, label %1055, label %999
999:
 %1000 = load i32, i32* %9
 %1001 = zext i32 %1000 to i64
 %1002 = load i32, i32* %10
 %1003 = zext i32 %1002 to i64
 %1004 = call i64 @gcd (i64 %1001, i64 %1003)
 %1005 = load i32, i32* %10
 %1006 = zext i32 %1005 to i64
 %1007 = icmp ne i64 %1004, %1006
 br i1 %1007, label %1055, label %1008
1008:
 %1009 = load i32, i32* %7
 %1010 = zext i32 %1009 to i64
 %1011 = load i32, i32* %10
 %1012 = zext i32 %1011 to i64
 %1013 = call i64 @gcd (i64 %1010, i64 %1012)
 %1014 = load i32, i32* %10
 %1015 = zext i32 %1014 to i64
 %1016 = icmp ne i64 %1013, %1015
 br i1 %1016, label %1055, label %1017
1017:
 %1018 = load i32, i32* %11
 %1019 = load i32, i32* %7
 %1020 = urem i32 %1018, %1019
 %1021 = load i32, i32* %9
 %1022 = load i32, i32* %7
 %1023 = urem i32 %1021, %1022
 %1024 = icmp eq i32 %1020, %1023
 %1025 = zext i1 %1024 to i32
 %1026 = load i32, i32* %11
 %1027 = load i32, i32* %10
 %1028 = udiv i32 %1026, %1027
 %1029 = load i32, i32* %7
 %1030 = load i32, i32* %10
 %1031 = udiv i32 %1029, %1030
 %1032 = urem i32 %1028, %1031
 %1033 = load i32, i32* %9
 %1034 = load i32, i32* %10
 %1035 = udiv i32 %1033, %1034
 %1036 = load i32, i32* %7
 %1037 = load i32, i32* %10
 %1038 = udiv i32 %1036, %1037
 %1039 = urem i32 %1035, %1038
 %1040 = icmp eq i32 %1032, %1039
 %1041 = zext i1 %1040 to i32
 %1042 = icmp eq i32 %1025, %1041
 br i1 %1042, label %1055, label %1043
1043:
 %1044 = load i32, i32* %6
 %1045 = call i32 (i8*, ...) @printf (i8* @.str, i32 19, i32 %1044)
 %1046 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %1047 = load i32, i32* %7
 %1048 = load i32, i32* %8
 %1049 = load i32, i32* %9
 %1050 = load i32, i32* %10
 %1051 = load i32, i32* %11
 %1052 = load i32, i32* %12
 %1053 = load i32, i32* %13
 %1054 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %1047, i32 %1048, i32 %1049, i32 %1050, i32 %1051, i32 %1052, i32 %1053)
 store i32 1, i32* %3
 br label %1501
1055:
 %1056 = load i32, i32* %13
 %1057 = icmp eq i32 %1056, 0
 br i1 %1057, label %1123, label %1058
1058:
 %1059 = load i32, i32* %8
 %1060 = zext i32 %1059 to i64
 %1061 = load i32, i32* %13
 %1062 = sext i32 %1061 to i64
 %1063 = call i64 @gcd (i64 %1060, i64 %1062)
 %1064 = load i32, i32* %13
 %1065 = sext i32 %1064 to i64
 %1066 = icmp ne i64 %1063, %1065
 br i1 %1066, label %1123, label %1067
1067:
 %1068 = load i32, i32* %12
 %1069 = sext i32 %1068 to i64
 %1070 = load i32, i32* %13
 %1071 = sext i32 %1070 to i64
 %1072 = call i64 @gcd (i64 %1069, i64 %1071)
 %1073 = load i32, i32* %13
 %1074 = sext i32 %1073 to i64
 %1075 = icmp ne i64 %1072, %1074
 br i1 %1075, label %1123, label %1076
1076:
 %1077 = load i32, i32* %7
 %1078 = zext i32 %1077 to i64
 %1079 = load i32, i32* %13
 %1080 = sext i32 %1079 to i64
 %1081 = call i64 @gcd (i64 %1078, i64 %1080)
 %1082 = load i32, i32* %13
 %1083 = sext i32 %1082 to i64
 %1084 = icmp ne i64 %1081, %1083
 br i1 %1084, label %1123, label %1085
1085:
 %1086 = load i32, i32* %8
 %1087 = load i32, i32* %7
 %1088 = urem i32 %1086, %1087
 %1089 = load i32, i32* %12
 %1090 = load i32, i32* %7
 %1091 = urem i32 %1089, %1090
 %1092 = icmp eq i32 %1088, %1091
 %1093 = zext i1 %1092 to i32
 %1094 = load i32, i32* %8
 %1095 = load i32, i32* %13
 %1096 = udiv i32 %1094, %1095
 %1097 = load i32, i32* %7
 %1098 = load i32, i32* %13
 %1099 = udiv i32 %1097, %1098
 %1100 = urem i32 %1096, %1099
 %1101 = load i32, i32* %12
 %1102 = load i32, i32* %13
 %1103 = sdiv i32 %1101, %1102
 %1104 = load i32, i32* %7
 %1105 = load i32, i32* %13
 %1106 = udiv i32 %1104, %1105
 %1107 = urem i32 %1103, %1106
 %1108 = icmp eq i32 %1100, %1107
 %1109 = zext i1 %1108 to i32
 %1110 = icmp eq i32 %1093, %1109
 br i1 %1110, label %1123, label %1111
1111:
 %1112 = load i32, i32* %6
 %1113 = call i32 (i8*, ...) @printf (i8* @.str, i32 20, i32 %1112)
 %1114 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %1115 = load i32, i32* %7
 %1116 = load i32, i32* %8
 %1117 = load i32, i32* %9
 %1118 = load i32, i32* %10
 %1119 = load i32, i32* %11
 %1120 = load i32, i32* %12
 %1121 = load i32, i32* %13
 %1122 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %1115, i32 %1116, i32 %1117, i32 %1118, i32 %1119, i32 %1120, i32 %1121)
 store i32 1, i32* %3
 br label %1501
1123:
 %1124 = load i32, i32* %10
 %1125 = icmp eq i32 %1124, 0
 br i1 %1125, label %1191, label %1126
1126:
 %1127 = load i32, i32* %8
 %1128 = zext i32 %1127 to i64
 %1129 = load i32, i32* %10
 %1130 = zext i32 %1129 to i64
 %1131 = call i64 @gcd (i64 %1128, i64 %1130)
 %1132 = load i32, i32* %10
 %1133 = zext i32 %1132 to i64
 %1134 = icmp ne i64 %1131, %1133
 br i1 %1134, label %1191, label %1135
1135:
 %1136 = load i32, i32* %12
 %1137 = sext i32 %1136 to i64
 %1138 = load i32, i32* %10
 %1139 = zext i32 %1138 to i64
 %1140 = call i64 @gcd (i64 %1137, i64 %1139)
 %1141 = load i32, i32* %10
 %1142 = zext i32 %1141 to i64
 %1143 = icmp ne i64 %1140, %1142
 br i1 %1143, label %1191, label %1144
1144:
 %1145 = load i32, i32* %7
 %1146 = zext i32 %1145 to i64
 %1147 = load i32, i32* %10
 %1148 = zext i32 %1147 to i64
 %1149 = call i64 @gcd (i64 %1146, i64 %1148)
 %1150 = load i32, i32* %10
 %1151 = zext i32 %1150 to i64
 %1152 = icmp ne i64 %1149, %1151
 br i1 %1152, label %1191, label %1153
1153:
 %1154 = load i32, i32* %8
 %1155 = load i32, i32* %7
 %1156 = urem i32 %1154, %1155
 %1157 = load i32, i32* %12
 %1158 = load i32, i32* %7
 %1159 = urem i32 %1157, %1158
 %1160 = icmp eq i32 %1156, %1159
 %1161 = zext i1 %1160 to i32
 %1162 = load i32, i32* %8
 %1163 = load i32, i32* %10
 %1164 = udiv i32 %1162, %1163
 %1165 = load i32, i32* %7
 %1166 = load i32, i32* %10
 %1167 = udiv i32 %1165, %1166
 %1168 = urem i32 %1164, %1167
 %1169 = load i32, i32* %12
 %1170 = load i32, i32* %10
 %1171 = udiv i32 %1169, %1170
 %1172 = load i32, i32* %7
 %1173 = load i32, i32* %10
 %1174 = udiv i32 %1172, %1173
 %1175 = urem i32 %1171, %1174
 %1176 = icmp eq i32 %1168, %1175
 %1177 = zext i1 %1176 to i32
 %1178 = icmp eq i32 %1161, %1177
 br i1 %1178, label %1191, label %1179
1179:
 %1180 = load i32, i32* %6
 %1181 = call i32 (i8*, ...) @printf (i8* @.str, i32 21, i32 %1180)
 %1182 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %1183 = load i32, i32* %7
 %1184 = load i32, i32* %8
 %1185 = load i32, i32* %9
 %1186 = load i32, i32* %10
 %1187 = load i32, i32* %11
 %1188 = load i32, i32* %12
 %1189 = load i32, i32* %13
 %1190 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %1183, i32 %1184, i32 %1185, i32 %1186, i32 %1187, i32 %1188, i32 %1189)
 store i32 1, i32* %3
 br label %1501
1191:
 %1192 = load i32, i32* %13
 %1193 = icmp eq i32 %1192, 0
 br i1 %1193, label %1259, label %1194
1194:
 %1195 = load i32, i32* %8
 %1196 = zext i32 %1195 to i64
 %1197 = load i32, i32* %13
 %1198 = sext i32 %1197 to i64
 %1199 = call i64 @gcd (i64 %1196, i64 %1198)
 %1200 = load i32, i32* %13
 %1201 = sext i32 %1200 to i64
 %1202 = icmp ne i64 %1199, %1201
 br i1 %1202, label %1259, label %1203
1203:
 %1204 = load i32, i32* %9
 %1205 = zext i32 %1204 to i64
 %1206 = load i32, i32* %13
 %1207 = sext i32 %1206 to i64
 %1208 = call i64 @gcd (i64 %1205, i64 %1207)
 %1209 = load i32, i32* %13
 %1210 = sext i32 %1209 to i64
 %1211 = icmp ne i64 %1208, %1210
 br i1 %1211, label %1259, label %1212
1212:
 %1213 = load i32, i32* %7
 %1214 = zext i32 %1213 to i64
 %1215 = load i32, i32* %13
 %1216 = sext i32 %1215 to i64
 %1217 = call i64 @gcd (i64 %1214, i64 %1216)
 %1218 = load i32, i32* %13
 %1219 = sext i32 %1218 to i64
 %1220 = icmp ne i64 %1217, %1219
 br i1 %1220, label %1259, label %1221
1221:
 %1222 = load i32, i32* %8
 %1223 = load i32, i32* %7
 %1224 = urem i32 %1222, %1223
 %1225 = load i32, i32* %9
 %1226 = load i32, i32* %7
 %1227 = urem i32 %1225, %1226
 %1228 = icmp eq i32 %1224, %1227
 %1229 = zext i1 %1228 to i32
 %1230 = load i32, i32* %8
 %1231 = load i32, i32* %13
 %1232 = udiv i32 %1230, %1231
 %1233 = load i32, i32* %7
 %1234 = load i32, i32* %13
 %1235 = udiv i32 %1233, %1234
 %1236 = urem i32 %1232, %1235
 %1237 = load i32, i32* %9
 %1238 = load i32, i32* %13
 %1239 = udiv i32 %1237, %1238
 %1240 = load i32, i32* %7
 %1241 = load i32, i32* %13
 %1242 = udiv i32 %1240, %1241
 %1243 = urem i32 %1239, %1242
 %1244 = icmp eq i32 %1236, %1243
 %1245 = zext i1 %1244 to i32
 %1246 = icmp eq i32 %1229, %1245
 br i1 %1246, label %1259, label %1247
1247:
 %1248 = load i32, i32* %6
 %1249 = call i32 (i8*, ...) @printf (i8* @.str, i32 22, i32 %1248)
 %1250 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %1251 = load i32, i32* %7
 %1252 = load i32, i32* %8
 %1253 = load i32, i32* %9
 %1254 = load i32, i32* %10
 %1255 = load i32, i32* %11
 %1256 = load i32, i32* %12
 %1257 = load i32, i32* %13
 %1258 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %1251, i32 %1252, i32 %1253, i32 %1254, i32 %1255, i32 %1256, i32 %1257)
 store i32 1, i32* %3
 br label %1501
1259:
 %1260 = load i32, i32* %10
 %1261 = icmp eq i32 %1260, 0
 br i1 %1261, label %1327, label %1262
1262:
 %1263 = load i32, i32* %8
 %1264 = zext i32 %1263 to i64
 %1265 = load i32, i32* %10
 %1266 = zext i32 %1265 to i64
 %1267 = call i64 @gcd (i64 %1264, i64 %1266)
 %1268 = load i32, i32* %10
 %1269 = zext i32 %1268 to i64
 %1270 = icmp ne i64 %1267, %1269
 br i1 %1270, label %1327, label %1271
1271:
 %1272 = load i32, i32* %9
 %1273 = zext i32 %1272 to i64
 %1274 = load i32, i32* %10
 %1275 = zext i32 %1274 to i64
 %1276 = call i64 @gcd (i64 %1273, i64 %1275)
 %1277 = load i32, i32* %10
 %1278 = zext i32 %1277 to i64
 %1279 = icmp ne i64 %1276, %1278
 br i1 %1279, label %1327, label %1280
1280:
 %1281 = load i32, i32* %7
 %1282 = zext i32 %1281 to i64
 %1283 = load i32, i32* %10
 %1284 = zext i32 %1283 to i64
 %1285 = call i64 @gcd (i64 %1282, i64 %1284)
 %1286 = load i32, i32* %10
 %1287 = zext i32 %1286 to i64
 %1288 = icmp ne i64 %1285, %1287
 br i1 %1288, label %1327, label %1289
1289:
 %1290 = load i32, i32* %8
 %1291 = load i32, i32* %7
 %1292 = urem i32 %1290, %1291
 %1293 = load i32, i32* %9
 %1294 = load i32, i32* %7
 %1295 = urem i32 %1293, %1294
 %1296 = icmp eq i32 %1292, %1295
 %1297 = zext i1 %1296 to i32
 %1298 = load i32, i32* %8
 %1299 = load i32, i32* %10
 %1300 = udiv i32 %1298, %1299
 %1301 = load i32, i32* %7
 %1302 = load i32, i32* %10
 %1303 = udiv i32 %1301, %1302
 %1304 = urem i32 %1300, %1303
 %1305 = load i32, i32* %9
 %1306 = load i32, i32* %10
 %1307 = udiv i32 %1305, %1306
 %1308 = load i32, i32* %7
 %1309 = load i32, i32* %10
 %1310 = udiv i32 %1308, %1309
 %1311 = urem i32 %1307, %1310
 %1312 = icmp eq i32 %1304, %1311
 %1313 = zext i1 %1312 to i32
 %1314 = icmp eq i32 %1297, %1313
 br i1 %1314, label %1327, label %1315
1315:
 %1316 = load i32, i32* %6
 %1317 = call i32 (i8*, ...) @printf (i8* @.str, i32 23, i32 %1316)
 %1318 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %1319 = load i32, i32* %7
 %1320 = load i32, i32* %8
 %1321 = load i32, i32* %9
 %1322 = load i32, i32* %10
 %1323 = load i32, i32* %11
 %1324 = load i32, i32* %12
 %1325 = load i32, i32* %13
 %1326 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %1319, i32 %1320, i32 %1321, i32 %1322, i32 %1323, i32 %1324, i32 %1325)
 store i32 1, i32* %3
 br label %1501
1327:
 %1328 = load i32, i32* %10
 %1329 = icmp eq i32 %1328, 0
 br i1 %1329, label %1369, label %1330
1330:
 %1331 = load i32, i32* %7
 %1332 = zext i32 %1331 to i64
 %1333 = load i32, i32* %10
 %1334 = zext i32 %1333 to i64
 %1335 = call i64 @gcd (i64 %1332, i64 %1334)
 %1336 = load i32, i32* %10
 %1337 = zext i32 %1336 to i64
 %1338 = icmp ne i64 %1335, %1337
 br i1 %1338, label %1369, label %1339
1339:
 %1340 = load i32, i32* %11
 %1341 = load i32, i32* %7
 %1342 = urem i32 %1340, %1341
 %1343 = load i32, i32* %12
 %1344 = load i32, i32* %7
 %1345 = urem i32 %1343, %1344
 %1346 = icmp eq i32 %1342, %1345
 %1347 = zext i1 %1346 to i32
 %1348 = load i32, i32* %11
 %1349 = load i32, i32* %10
 %1350 = urem i32 %1348, %1349
 %1351 = load i32, i32* %12
 %1352 = load i32, i32* %10
 %1353 = urem i32 %1351, %1352
 %1354 = icmp eq i32 %1350, %1353
 %1355 = zext i1 %1354 to i32
 %1356 = icmp eq i32 %1347, %1355
 br i1 %1356, label %1369, label %1357
1357:
 %1358 = load i32, i32* %6
 %1359 = call i32 (i8*, ...) @printf (i8* @.str, i32 25, i32 %1358)
 %1360 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %1361 = load i32, i32* %7
 %1362 = load i32, i32* %8
 %1363 = load i32, i32* %9
 %1364 = load i32, i32* %10
 %1365 = load i32, i32* %11
 %1366 = load i32, i32* %12
 %1367 = load i32, i32* %13
 %1368 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %1361, i32 %1362, i32 %1363, i32 %1364, i32 %1365, i32 %1366, i32 %1367)
 store i32 1, i32* %3
 br label %1501
1369:
 %1370 = load i32, i32* %10
 %1371 = icmp eq i32 %1370, 0
 br i1 %1371, label %1411, label %1372
1372:
 %1373 = load i32, i32* %7
 %1374 = zext i32 %1373 to i64
 %1375 = load i32, i32* %10
 %1376 = zext i32 %1375 to i64
 %1377 = call i64 @gcd (i64 %1374, i64 %1376)
 %1378 = load i32, i32* %10
 %1379 = zext i32 %1378 to i64
 %1380 = icmp ne i64 %1377, %1379
 br i1 %1380, label %1411, label %1381
1381:
 %1382 = load i32, i32* %11
 %1383 = load i32, i32* %7
 %1384 = urem i32 %1382, %1383
 %1385 = load i32, i32* %9
 %1386 = load i32, i32* %7
 %1387 = urem i32 %1385, %1386
 %1388 = icmp eq i32 %1384, %1387
 %1389 = zext i1 %1388 to i32
 %1390 = load i32, i32* %11
 %1391 = load i32, i32* %10
 %1392 = urem i32 %1390, %1391
 %1393 = load i32, i32* %9
 %1394 = load i32, i32* %10
 %1395 = urem i32 %1393, %1394
 %1396 = icmp eq i32 %1392, %1395
 %1397 = zext i1 %1396 to i32
 %1398 = icmp eq i32 %1389, %1397
 br i1 %1398, label %1411, label %1399
1399:
 %1400 = load i32, i32* %6
 %1401 = call i32 (i8*, ...) @printf (i8* @.str, i32 27, i32 %1400)
 %1402 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %1403 = load i32, i32* %7
 %1404 = load i32, i32* %8
 %1405 = load i32, i32* %9
 %1406 = load i32, i32* %10
 %1407 = load i32, i32* %11
 %1408 = load i32, i32* %12
 %1409 = load i32, i32* %13
 %1410 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %1403, i32 %1404, i32 %1405, i32 %1406, i32 %1407, i32 %1408, i32 %1409)
 store i32 1, i32* %3
 br label %1501
1411:
 %1412 = load i32, i32* %10
 %1413 = icmp eq i32 %1412, 0
 br i1 %1413, label %1453, label %1414
1414:
 %1415 = load i32, i32* %7
 %1416 = zext i32 %1415 to i64
 %1417 = load i32, i32* %10
 %1418 = zext i32 %1417 to i64
 %1419 = call i64 @gcd (i64 %1416, i64 %1418)
 %1420 = load i32, i32* %10
 %1421 = zext i32 %1420 to i64
 %1422 = icmp ne i64 %1419, %1421
 br i1 %1422, label %1453, label %1423
1423:
 %1424 = load i32, i32* %8
 %1425 = load i32, i32* %7
 %1426 = urem i32 %1424, %1425
 %1427 = load i32, i32* %12
 %1428 = load i32, i32* %7
 %1429 = urem i32 %1427, %1428
 %1430 = icmp eq i32 %1426, %1429
 %1431 = zext i1 %1430 to i32
 %1432 = load i32, i32* %8
 %1433 = load i32, i32* %10
 %1434 = urem i32 %1432, %1433
 %1435 = load i32, i32* %12
 %1436 = load i32, i32* %10
 %1437 = urem i32 %1435, %1436
 %1438 = icmp eq i32 %1434, %1437
 %1439 = zext i1 %1438 to i32
 %1440 = icmp eq i32 %1431, %1439
 br i1 %1440, label %1453, label %1441
1441:
 %1442 = load i32, i32* %6
 %1443 = call i32 (i8*, ...) @printf (i8* @.str, i32 29, i32 %1442)
 %1444 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %1445 = load i32, i32* %7
 %1446 = load i32, i32* %8
 %1447 = load i32, i32* %9
 %1448 = load i32, i32* %10
 %1449 = load i32, i32* %11
 %1450 = load i32, i32* %12
 %1451 = load i32, i32* %13
 %1452 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %1445, i32 %1446, i32 %1447, i32 %1448, i32 %1449, i32 %1450, i32 %1451)
 store i32 1, i32* %3
 br label %1501
1453:
 %1454 = load i32, i32* %10
 %1455 = icmp eq i32 %1454, 0
 br i1 %1455, label %1495, label %1456
1456:
 %1457 = load i32, i32* %7
 %1458 = zext i32 %1457 to i64
 %1459 = load i32, i32* %10
 %1460 = zext i32 %1459 to i64
 %1461 = call i64 @gcd (i64 %1458, i64 %1460)
 %1462 = load i32, i32* %10
 %1463 = zext i32 %1462 to i64
 %1464 = icmp ne i64 %1461, %1463
 br i1 %1464, label %1495, label %1465
1465:
 %1466 = load i32, i32* %8
 %1467 = load i32, i32* %7
 %1468 = urem i32 %1466, %1467
 %1469 = load i32, i32* %9
 %1470 = load i32, i32* %7
 %1471 = urem i32 %1469, %1470
 %1472 = icmp eq i32 %1468, %1471
 %1473 = zext i1 %1472 to i32
 %1474 = load i32, i32* %8
 %1475 = load i32, i32* %10
 %1476 = urem i32 %1474, %1475
 %1477 = load i32, i32* %9
 %1478 = load i32, i32* %10
 %1479 = urem i32 %1477, %1478
 %1480 = icmp eq i32 %1476, %1479
 %1481 = zext i1 %1480 to i32
 %1482 = icmp eq i32 %1473, %1481
 br i1 %1482, label %1495, label %1483
1483:
 %1484 = load i32, i32* %6
 %1485 = call i32 (i8*, ...) @printf (i8* @.str, i32 31, i32 %1484)
 %1486 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %1487 = load i32, i32* %7
 %1488 = load i32, i32* %8
 %1489 = load i32, i32* %9
 %1490 = load i32, i32* %10
 %1491 = load i32, i32* %11
 %1492 = load i32, i32* %12
 %1493 = load i32, i32* %13
 %1494 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %1487, i32 %1488, i32 %1489, i32 %1490, i32 %1491, i32 %1492, i32 %1493)
 store i32 1, i32* %3
 br label %1501
1495:
 br label %1496
1496:
 %1497 = load i32, i32* %6
 %1498 = add i32 %1497, 1
 store i32 %1498, i32* %6
 br label %14
1499:
 %1500 = call i32 (i8*, ...) @printf (i8* @.str.3)
 store i32 0, i32* %3
 br label %1501
1501:
 %1502 = load i32, i32* %3
 ret i32 %1502
}
