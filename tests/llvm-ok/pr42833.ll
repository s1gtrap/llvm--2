%struct.neon_s8 = type { i8, i8, i8, i8 }
%union.anon = type { i32 }
%union.anon.0 = type { i32 }
%union.anon.1 = type { i32 }

declare void @memcpy(i8*, i8*, i64, i1)
declare void @abort()

define i32 @helper_neon_rshl_s8 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca %struct.neon_s8
 %7 = alloca %struct.neon_s8
 %8 = alloca %struct.neon_s8
 %9 = alloca %union.anon
 %10 = alloca %union.anon.0
 %11 = alloca i8
 %12 = alloca i8
 %13 = alloca i8
 %14 = alloca i8
 %15 = alloca %union.anon.1
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 br label %16
16:
 %17 = load i32, i32* %3
 store i32 %17, i32* %9
 call void @memcpy (i8* %6, i8* %9, i64 4, i1 0)
 br label %18
18:
 br label %19
19:
 %20 = load i32, i32* %4
 store i32 %20, i32* %10
 call void @memcpy (i8* %7, i8* %10, i64 4, i1 0)
 br label %21
21:
 br label %22
22:
 %23 = getelementptr %struct.neon_s8, i8* %7, i32 0, i32 0
 %24 = load i8, i8* %23
 store i8 %24, i8* %11
 %25 = load i8, i8* %11
 %26 = sext i8 %25 to i32
 %27 = icmp sge i32 %26, 8
 br i1 %27, label %28, label %30
28:
 %29 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 0
 store i8 0, i8* %29
 br label %94
30:
 %31 = load i8, i8* %11
 %32 = sext i8 %31 to i32
 %33 = icmp slt i32 %32, -8
 br i1 %33, label %34, label %41
34:
 %35 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 0
 %36 = load i8, i8* %35
 %37 = sext i8 %36 to i32
 %38 = ashr i32 %37, 7
 %39 = trunc i32 %38 to i8
 %40 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 0
 store i8 %39, i8* %40
 br label %93
41:
 %42 = load i8, i8* %11
 %43 = sext i8 %42 to i32
 %44 = icmp eq i32 %43, -8
 br i1 %44, label %45, label %63
45:
 %46 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 0
 %47 = load i8, i8* %46
 %48 = sext i8 %47 to i32
 %49 = load i8, i8* %11
 %50 = sext i8 %49 to i32
 %51 = sub i32 %50, 1
 %52 = ashr i32 %48, %51
 %53 = trunc i32 %52 to i8
 %54 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 0
 store i8 %53, i8* %54
 %55 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 0
 %56 = load i8, i8* %55
 %57 = add i8 %56, 1
 store i8 %57, i8* %55
 %58 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 0
 %59 = load i8, i8* %58
 %60 = sext i8 %59 to i32
 %61 = ashr i32 %60, 1
 %62 = trunc i32 %61 to i8
 store i8 %62, i8* %58
 br label %92
63:
 %64 = load i8, i8* %11
 %65 = sext i8 %64 to i32
 %66 = icmp slt i32 %65, 0
 br i1 %66, label %67, label %82
67:
 %68 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 0
 %69 = load i8, i8* %68
 %70 = sext i8 %69 to i32
 %71 = load i8, i8* %11
 %72 = sext i8 %71 to i32
 %73 = sub i32 -1, %72
 %74 = shl i32 1, %73
 %75 = add i32 %70, %74
 %76 = load i8, i8* %11
 %77 = sext i8 %76 to i32
 %78 = sub i32 0, %77
 %79 = ashr i32 %75, %78
 %80 = trunc i32 %79 to i8
 %81 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 0
 store i8 %80, i8* %81
 br label %91
82:
 %83 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 0
 %84 = load i8, i8* %83
 %85 = sext i8 %84 to i32
 %86 = load i8, i8* %11
 %87 = sext i8 %86 to i32
 %88 = shl i32 %85, %87
 %89 = trunc i32 %88 to i8
 %90 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 0
 store i8 %89, i8* %90
 br label %91
91:
 br label %92
92:
 br label %93
93:
 br label %94
94:
 br label %95
95:
 br label %96
96:
 %97 = getelementptr %struct.neon_s8, i8* %7, i32 0, i32 1
 %98 = load i8, i8* %97
 store i8 %98, i8* %12
 %99 = load i8, i8* %12
 %100 = sext i8 %99 to i32
 %101 = icmp sge i32 %100, 8
 br i1 %101, label %102, label %104
102:
 %103 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 1
 store i8 0, i8* %103
 br label %168
104:
 %105 = load i8, i8* %12
 %106 = sext i8 %105 to i32
 %107 = icmp slt i32 %106, -8
 br i1 %107, label %108, label %115
108:
 %109 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 1
 %110 = load i8, i8* %109
 %111 = sext i8 %110 to i32
 %112 = ashr i32 %111, 7
 %113 = trunc i32 %112 to i8
 %114 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 1
 store i8 %113, i8* %114
 br label %167
115:
 %116 = load i8, i8* %12
 %117 = sext i8 %116 to i32
 %118 = icmp eq i32 %117, -8
 br i1 %118, label %119, label %137
119:
 %120 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 1
 %121 = load i8, i8* %120
 %122 = sext i8 %121 to i32
 %123 = load i8, i8* %12
 %124 = sext i8 %123 to i32
 %125 = sub i32 %124, 1
 %126 = ashr i32 %122, %125
 %127 = trunc i32 %126 to i8
 %128 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 1
 store i8 %127, i8* %128
 %129 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 1
 %130 = load i8, i8* %129
 %131 = add i8 %130, 1
 store i8 %131, i8* %129
 %132 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 1
 %133 = load i8, i8* %132
 %134 = sext i8 %133 to i32
 %135 = ashr i32 %134, 1
 %136 = trunc i32 %135 to i8
 store i8 %136, i8* %132
 br label %166
137:
 %138 = load i8, i8* %12
 %139 = sext i8 %138 to i32
 %140 = icmp slt i32 %139, 0
 br i1 %140, label %141, label %156
141:
 %142 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 1
 %143 = load i8, i8* %142
 %144 = sext i8 %143 to i32
 %145 = load i8, i8* %12
 %146 = sext i8 %145 to i32
 %147 = sub i32 -1, %146
 %148 = shl i32 1, %147
 %149 = add i32 %144, %148
 %150 = load i8, i8* %12
 %151 = sext i8 %150 to i32
 %152 = sub i32 0, %151
 %153 = ashr i32 %149, %152
 %154 = trunc i32 %153 to i8
 %155 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 1
 store i8 %154, i8* %155
 br label %165
156:
 %157 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 1
 %158 = load i8, i8* %157
 %159 = sext i8 %158 to i32
 %160 = load i8, i8* %12
 %161 = sext i8 %160 to i32
 %162 = shl i32 %159, %161
 %163 = trunc i32 %162 to i8
 %164 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 1
 store i8 %163, i8* %164
 br label %165
165:
 br label %166
166:
 br label %167
167:
 br label %168
168:
 br label %169
169:
 br label %170
170:
 %171 = getelementptr %struct.neon_s8, i8* %7, i32 0, i32 2
 %172 = load i8, i8* %171
 store i8 %172, i8* %13
 %173 = load i8, i8* %13
 %174 = sext i8 %173 to i32
 %175 = icmp sge i32 %174, 8
 br i1 %175, label %176, label %178
176:
 %177 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 2
 store i8 0, i8* %177
 br label %242
178:
 %179 = load i8, i8* %13
 %180 = sext i8 %179 to i32
 %181 = icmp slt i32 %180, -8
 br i1 %181, label %182, label %189
182:
 %183 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 2
 %184 = load i8, i8* %183
 %185 = sext i8 %184 to i32
 %186 = ashr i32 %185, 7
 %187 = trunc i32 %186 to i8
 %188 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 2
 store i8 %187, i8* %188
 br label %241
189:
 %190 = load i8, i8* %13
 %191 = sext i8 %190 to i32
 %192 = icmp eq i32 %191, -8
 br i1 %192, label %193, label %211
193:
 %194 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 2
 %195 = load i8, i8* %194
 %196 = sext i8 %195 to i32
 %197 = load i8, i8* %13
 %198 = sext i8 %197 to i32
 %199 = sub i32 %198, 1
 %200 = ashr i32 %196, %199
 %201 = trunc i32 %200 to i8
 %202 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 2
 store i8 %201, i8* %202
 %203 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 2
 %204 = load i8, i8* %203
 %205 = add i8 %204, 1
 store i8 %205, i8* %203
 %206 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 2
 %207 = load i8, i8* %206
 %208 = sext i8 %207 to i32
 %209 = ashr i32 %208, 1
 %210 = trunc i32 %209 to i8
 store i8 %210, i8* %206
 br label %240
211:
 %212 = load i8, i8* %13
 %213 = sext i8 %212 to i32
 %214 = icmp slt i32 %213, 0
 br i1 %214, label %215, label %230
215:
 %216 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 2
 %217 = load i8, i8* %216
 %218 = sext i8 %217 to i32
 %219 = load i8, i8* %13
 %220 = sext i8 %219 to i32
 %221 = sub i32 -1, %220
 %222 = shl i32 1, %221
 %223 = add i32 %218, %222
 %224 = load i8, i8* %13
 %225 = sext i8 %224 to i32
 %226 = sub i32 0, %225
 %227 = ashr i32 %223, %226
 %228 = trunc i32 %227 to i8
 %229 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 2
 store i8 %228, i8* %229
 br label %239
230:
 %231 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 2
 %232 = load i8, i8* %231
 %233 = sext i8 %232 to i32
 %234 = load i8, i8* %13
 %235 = sext i8 %234 to i32
 %236 = shl i32 %233, %235
 %237 = trunc i32 %236 to i8
 %238 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 2
 store i8 %237, i8* %238
 br label %239
239:
 br label %240
240:
 br label %241
241:
 br label %242
242:
 br label %243
243:
 br label %244
244:
 %245 = getelementptr %struct.neon_s8, i8* %7, i32 0, i32 3
 %246 = load i8, i8* %245
 store i8 %246, i8* %14
 %247 = load i8, i8* %14
 %248 = sext i8 %247 to i32
 %249 = icmp sge i32 %248, 8
 br i1 %249, label %250, label %252
250:
 %251 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 3
 store i8 0, i8* %251
 br label %316
252:
 %253 = load i8, i8* %14
 %254 = sext i8 %253 to i32
 %255 = icmp slt i32 %254, -8
 br i1 %255, label %256, label %263
256:
 %257 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 3
 %258 = load i8, i8* %257
 %259 = sext i8 %258 to i32
 %260 = ashr i32 %259, 7
 %261 = trunc i32 %260 to i8
 %262 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 3
 store i8 %261, i8* %262
 br label %315
263:
 %264 = load i8, i8* %14
 %265 = sext i8 %264 to i32
 %266 = icmp eq i32 %265, -8
 br i1 %266, label %267, label %285
267:
 %268 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 3
 %269 = load i8, i8* %268
 %270 = sext i8 %269 to i32
 %271 = load i8, i8* %14
 %272 = sext i8 %271 to i32
 %273 = sub i32 %272, 1
 %274 = ashr i32 %270, %273
 %275 = trunc i32 %274 to i8
 %276 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 3
 store i8 %275, i8* %276
 %277 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 3
 %278 = load i8, i8* %277
 %279 = add i8 %278, 1
 store i8 %279, i8* %277
 %280 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 3
 %281 = load i8, i8* %280
 %282 = sext i8 %281 to i32
 %283 = ashr i32 %282, 1
 %284 = trunc i32 %283 to i8
 store i8 %284, i8* %280
 br label %314
285:
 %286 = load i8, i8* %14
 %287 = sext i8 %286 to i32
 %288 = icmp slt i32 %287, 0
 br i1 %288, label %289, label %304
289:
 %290 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 3
 %291 = load i8, i8* %290
 %292 = sext i8 %291 to i32
 %293 = load i8, i8* %14
 %294 = sext i8 %293 to i32
 %295 = sub i32 -1, %294
 %296 = shl i32 1, %295
 %297 = add i32 %292, %296
 %298 = load i8, i8* %14
 %299 = sext i8 %298 to i32
 %300 = sub i32 0, %299
 %301 = ashr i32 %297, %300
 %302 = trunc i32 %301 to i8
 %303 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 3
 store i8 %302, i8* %303
 br label %313
304:
 %305 = getelementptr %struct.neon_s8, i8* %6, i32 0, i32 3
 %306 = load i8, i8* %305
 %307 = sext i8 %306 to i32
 %308 = load i8, i8* %14
 %309 = sext i8 %308 to i32
 %310 = shl i32 %307, %309
 %311 = trunc i32 %310 to i8
 %312 = getelementptr %struct.neon_s8, i8* %8, i32 0, i32 3
 store i8 %311, i8* %312
 br label %313
313:
 br label %314
314:
 br label %315
315:
 br label %316
316:
 br label %317
317:
 br label %318
318:
 call void @memcpy (i8* %15, i8* %8, i64 4, i1 0)
 %319 = load i32, i32* %15
 store i32 %319, i32* %5
 br label %320
320:
 %321 = load i32, i32* %5
 ret i32 %321
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = call i32 @helper_neon_rshl_s8 (i32 84215045, i32 16843009)
 store i32 %3, i32* %2
 %4 = load i32, i32* %2
 %5 = icmp ne i32 %4, 168430090
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}
