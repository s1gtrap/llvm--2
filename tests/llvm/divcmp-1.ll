declare void @abort()

define i32 @test1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp eq i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test1u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = udiv i32 %3, 10
 %5 = icmp eq i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp eq i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test2u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = udiv i32 %3, 10
 %5 = icmp eq i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp ne i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test3u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = udiv i32 %3, 10
 %5 = icmp ne i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test4 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp ne i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test4u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = udiv i32 %3, 10
 %5 = icmp ne i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test5 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp slt i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test5u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = udiv i32 %3, 10
 %5 = icmp ult i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test6 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp slt i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test7 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp sle i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test7u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = udiv i32 %3, 10
 %5 = icmp ule i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test8 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp sle i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test8u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = udiv i32 %3, 10
 %5 = icmp ule i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test9 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp sgt i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test9u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = udiv i32 %3, 10
 %5 = icmp ugt i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test10 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp sgt i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test10u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = udiv i32 %3, 10
 %5 = icmp ugt i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test11 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp sge i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test11u (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = udiv i32 %3, 10
 %5 = icmp uge i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test12 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 10
 %5 = icmp sge i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test1 (i32 19)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @test1 (i32 20)
 %7 = icmp ne i32 %6, 1
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @test1 (i32 29)
 %11 = icmp ne i32 %10, 1
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @test1 (i32 30)
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 %18 = call i32 @test1u (i32 19)
 %19 = icmp ne i32 %18, 0
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i32 @test1u (i32 20)
 %23 = icmp ne i32 %22, 1
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 %26 = call i32 @test1u (i32 29)
 %27 = icmp ne i32 %26, 1
 br i1 %27, label %28, label %29
28:
 call void @abort ()
 unreachable
29:
 %30 = call i32 @test1u (i32 30)
 %31 = icmp ne i32 %30, 0
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 %34 = call i32 @test2 (i32 0)
 %35 = icmp ne i32 %34, 1
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 %38 = call i32 @test2 (i32 9)
 %39 = icmp ne i32 %38, 1
 br i1 %39, label %40, label %41
40:
 call void @abort ()
 unreachable
41:
 %42 = call i32 @test2 (i32 10)
 %43 = icmp ne i32 %42, 0
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 %46 = call i32 @test2 (i32 -1)
 %47 = icmp ne i32 %46, 1
 br i1 %47, label %48, label %49
48:
 call void @abort ()
 unreachable
49:
 %50 = call i32 @test2 (i32 -9)
 %51 = icmp ne i32 %50, 1
 br i1 %51, label %52, label %53
52:
 call void @abort ()
 unreachable
53:
 %54 = call i32 @test2 (i32 -10)
 %55 = icmp ne i32 %54, 0
 br i1 %55, label %56, label %57
56:
 call void @abort ()
 unreachable
57:
 %58 = call i32 @test2u (i32 0)
 %59 = icmp ne i32 %58, 1
 br i1 %59, label %60, label %61
60:
 call void @abort ()
 unreachable
61:
 %62 = call i32 @test2u (i32 9)
 %63 = icmp ne i32 %62, 1
 br i1 %63, label %64, label %65
64:
 call void @abort ()
 unreachable
65:
 %66 = call i32 @test2u (i32 10)
 %67 = icmp ne i32 %66, 0
 br i1 %67, label %68, label %69
68:
 call void @abort ()
 unreachable
69:
 %70 = call i32 @test2u (i32 -1)
 %71 = icmp ne i32 %70, 0
 br i1 %71, label %72, label %73
72:
 call void @abort ()
 unreachable
73:
 %74 = call i32 @test2u (i32 -9)
 %75 = icmp ne i32 %74, 0
 br i1 %75, label %76, label %77
76:
 call void @abort ()
 unreachable
77:
 %78 = call i32 @test2u (i32 -10)
 %79 = icmp ne i32 %78, 0
 br i1 %79, label %80, label %81
80:
 call void @abort ()
 unreachable
81:
 %82 = call i32 @test3 (i32 19)
 %83 = icmp ne i32 %82, 1
 br i1 %83, label %84, label %85
84:
 call void @abort ()
 unreachable
85:
 %86 = call i32 @test3 (i32 20)
 %87 = icmp ne i32 %86, 0
 br i1 %87, label %88, label %89
88:
 call void @abort ()
 unreachable
89:
 %90 = call i32 @test3 (i32 29)
 %91 = icmp ne i32 %90, 0
 br i1 %91, label %92, label %93
92:
 call void @abort ()
 unreachable
93:
 %94 = call i32 @test3 (i32 30)
 %95 = icmp ne i32 %94, 1
 br i1 %95, label %96, label %97
96:
 call void @abort ()
 unreachable
97:
 %98 = call i32 @test3u (i32 19)
 %99 = icmp ne i32 %98, 1
 br i1 %99, label %100, label %101
100:
 call void @abort ()
 unreachable
101:
 %102 = call i32 @test3u (i32 20)
 %103 = icmp ne i32 %102, 0
 br i1 %103, label %104, label %105
104:
 call void @abort ()
 unreachable
105:
 %106 = call i32 @test3u (i32 29)
 %107 = icmp ne i32 %106, 0
 br i1 %107, label %108, label %109
108:
 call void @abort ()
 unreachable
109:
 %110 = call i32 @test3u (i32 30)
 %111 = icmp ne i32 %110, 1
 br i1 %111, label %112, label %113
112:
 call void @abort ()
 unreachable
113:
 %114 = call i32 @test4 (i32 0)
 %115 = icmp ne i32 %114, 0
 br i1 %115, label %116, label %117
116:
 call void @abort ()
 unreachable
117:
 %118 = call i32 @test4 (i32 9)
 %119 = icmp ne i32 %118, 0
 br i1 %119, label %120, label %121
120:
 call void @abort ()
 unreachable
121:
 %122 = call i32 @test4 (i32 10)
 %123 = icmp ne i32 %122, 1
 br i1 %123, label %124, label %125
124:
 call void @abort ()
 unreachable
125:
 %126 = call i32 @test4 (i32 -1)
 %127 = icmp ne i32 %126, 0
 br i1 %127, label %128, label %129
128:
 call void @abort ()
 unreachable
129:
 %130 = call i32 @test4 (i32 -9)
 %131 = icmp ne i32 %130, 0
 br i1 %131, label %132, label %133
132:
 call void @abort ()
 unreachable
133:
 %134 = call i32 @test4 (i32 -10)
 %135 = icmp ne i32 %134, 1
 br i1 %135, label %136, label %137
136:
 call void @abort ()
 unreachable
137:
 %138 = call i32 @test4u (i32 0)
 %139 = icmp ne i32 %138, 0
 br i1 %139, label %140, label %141
140:
 call void @abort ()
 unreachable
141:
 %142 = call i32 @test4u (i32 9)
 %143 = icmp ne i32 %142, 0
 br i1 %143, label %144, label %145
144:
 call void @abort ()
 unreachable
145:
 %146 = call i32 @test4u (i32 10)
 %147 = icmp ne i32 %146, 1
 br i1 %147, label %148, label %149
148:
 call void @abort ()
 unreachable
149:
 %150 = call i32 @test4u (i32 -1)
 %151 = icmp ne i32 %150, 1
 br i1 %151, label %152, label %153
152:
 call void @abort ()
 unreachable
153:
 %154 = call i32 @test4u (i32 -9)
 %155 = icmp ne i32 %154, 1
 br i1 %155, label %156, label %157
156:
 call void @abort ()
 unreachable
157:
 %158 = call i32 @test4u (i32 -10)
 %159 = icmp ne i32 %158, 1
 br i1 %159, label %160, label %161
160:
 call void @abort ()
 unreachable
161:
 %162 = call i32 @test5 (i32 19)
 %163 = icmp ne i32 %162, 1
 br i1 %163, label %164, label %165
164:
 call void @abort ()
 unreachable
165:
 %166 = call i32 @test5 (i32 20)
 %167 = icmp ne i32 %166, 0
 br i1 %167, label %168, label %169
168:
 call void @abort ()
 unreachable
169:
 %170 = call i32 @test5 (i32 29)
 %171 = icmp ne i32 %170, 0
 br i1 %171, label %172, label %173
172:
 call void @abort ()
 unreachable
173:
 %174 = call i32 @test5 (i32 30)
 %175 = icmp ne i32 %174, 0
 br i1 %175, label %176, label %177
176:
 call void @abort ()
 unreachable
177:
 %178 = call i32 @test5u (i32 19)
 %179 = icmp ne i32 %178, 1
 br i1 %179, label %180, label %181
180:
 call void @abort ()
 unreachable
181:
 %182 = call i32 @test5u (i32 20)
 %183 = icmp ne i32 %182, 0
 br i1 %183, label %184, label %185
184:
 call void @abort ()
 unreachable
185:
 %186 = call i32 @test5u (i32 29)
 %187 = icmp ne i32 %186, 0
 br i1 %187, label %188, label %189
188:
 call void @abort ()
 unreachable
189:
 %190 = call i32 @test5u (i32 30)
 %191 = icmp ne i32 %190, 0
 br i1 %191, label %192, label %193
192:
 call void @abort ()
 unreachable
193:
 %194 = call i32 @test6 (i32 0)
 %195 = icmp ne i32 %194, 0
 br i1 %195, label %196, label %197
196:
 call void @abort ()
 unreachable
197:
 %198 = call i32 @test6 (i32 9)
 %199 = icmp ne i32 %198, 0
 br i1 %199, label %200, label %201
200:
 call void @abort ()
 unreachable
201:
 %202 = call i32 @test6 (i32 10)
 %203 = icmp ne i32 %202, 0
 br i1 %203, label %204, label %205
204:
 call void @abort ()
 unreachable
205:
 %206 = call i32 @test6 (i32 -1)
 %207 = icmp ne i32 %206, 0
 br i1 %207, label %208, label %209
208:
 call void @abort ()
 unreachable
209:
 %210 = call i32 @test6 (i32 -9)
 %211 = icmp ne i32 %210, 0
 br i1 %211, label %212, label %213
212:
 call void @abort ()
 unreachable
213:
 %214 = call i32 @test6 (i32 -10)
 %215 = icmp ne i32 %214, 1
 br i1 %215, label %216, label %217
216:
 call void @abort ()
 unreachable
217:
 %218 = call i32 @test7 (i32 19)
 %219 = icmp ne i32 %218, 1
 br i1 %219, label %220, label %221
220:
 call void @abort ()
 unreachable
221:
 %222 = call i32 @test7 (i32 20)
 %223 = icmp ne i32 %222, 1
 br i1 %223, label %224, label %225
224:
 call void @abort ()
 unreachable
225:
 %226 = call i32 @test7 (i32 29)
 %227 = icmp ne i32 %226, 1
 br i1 %227, label %228, label %229
228:
 call void @abort ()
 unreachable
229:
 %230 = call i32 @test7 (i32 30)
 %231 = icmp ne i32 %230, 0
 br i1 %231, label %232, label %233
232:
 call void @abort ()
 unreachable
233:
 %234 = call i32 @test7u (i32 19)
 %235 = icmp ne i32 %234, 1
 br i1 %235, label %236, label %237
236:
 call void @abort ()
 unreachable
237:
 %238 = call i32 @test7u (i32 20)
 %239 = icmp ne i32 %238, 1
 br i1 %239, label %240, label %241
240:
 call void @abort ()
 unreachable
241:
 %242 = call i32 @test7u (i32 29)
 %243 = icmp ne i32 %242, 1
 br i1 %243, label %244, label %245
244:
 call void @abort ()
 unreachable
245:
 %246 = call i32 @test7u (i32 30)
 %247 = icmp ne i32 %246, 0
 br i1 %247, label %248, label %249
248:
 call void @abort ()
 unreachable
249:
 %250 = call i32 @test8 (i32 0)
 %251 = icmp ne i32 %250, 1
 br i1 %251, label %252, label %253
252:
 call void @abort ()
 unreachable
253:
 %254 = call i32 @test8 (i32 9)
 %255 = icmp ne i32 %254, 1
 br i1 %255, label %256, label %257
256:
 call void @abort ()
 unreachable
257:
 %258 = call i32 @test8 (i32 10)
 %259 = icmp ne i32 %258, 0
 br i1 %259, label %260, label %261
260:
 call void @abort ()
 unreachable
261:
 %262 = call i32 @test8 (i32 -1)
 %263 = icmp ne i32 %262, 1
 br i1 %263, label %264, label %265
264:
 call void @abort ()
 unreachable
265:
 %266 = call i32 @test8 (i32 -9)
 %267 = icmp ne i32 %266, 1
 br i1 %267, label %268, label %269
268:
 call void @abort ()
 unreachable
269:
 %270 = call i32 @test8 (i32 -10)
 %271 = icmp ne i32 %270, 1
 br i1 %271, label %272, label %273
272:
 call void @abort ()
 unreachable
273:
 %274 = call i32 @test8u (i32 0)
 %275 = icmp ne i32 %274, 1
 br i1 %275, label %276, label %277
276:
 call void @abort ()
 unreachable
277:
 %278 = call i32 @test8u (i32 9)
 %279 = icmp ne i32 %278, 1
 br i1 %279, label %280, label %281
280:
 call void @abort ()
 unreachable
281:
 %282 = call i32 @test8u (i32 10)
 %283 = icmp ne i32 %282, 0
 br i1 %283, label %284, label %285
284:
 call void @abort ()
 unreachable
285:
 %286 = call i32 @test8u (i32 -1)
 %287 = icmp ne i32 %286, 0
 br i1 %287, label %288, label %289
288:
 call void @abort ()
 unreachable
289:
 %290 = call i32 @test8u (i32 -9)
 %291 = icmp ne i32 %290, 0
 br i1 %291, label %292, label %293
292:
 call void @abort ()
 unreachable
293:
 %294 = call i32 @test8u (i32 -10)
 %295 = icmp ne i32 %294, 0
 br i1 %295, label %296, label %297
296:
 call void @abort ()
 unreachable
297:
 %298 = call i32 @test9 (i32 19)
 %299 = icmp ne i32 %298, 0
 br i1 %299, label %300, label %301
300:
 call void @abort ()
 unreachable
301:
 %302 = call i32 @test9 (i32 20)
 %303 = icmp ne i32 %302, 0
 br i1 %303, label %304, label %305
304:
 call void @abort ()
 unreachable
305:
 %306 = call i32 @test9 (i32 29)
 %307 = icmp ne i32 %306, 0
 br i1 %307, label %308, label %309
308:
 call void @abort ()
 unreachable
309:
 %310 = call i32 @test9 (i32 30)
 %311 = icmp ne i32 %310, 1
 br i1 %311, label %312, label %313
312:
 call void @abort ()
 unreachable
313:
 %314 = call i32 @test9u (i32 19)
 %315 = icmp ne i32 %314, 0
 br i1 %315, label %316, label %317
316:
 call void @abort ()
 unreachable
317:
 %318 = call i32 @test9u (i32 20)
 %319 = icmp ne i32 %318, 0
 br i1 %319, label %320, label %321
320:
 call void @abort ()
 unreachable
321:
 %322 = call i32 @test9u (i32 29)
 %323 = icmp ne i32 %322, 0
 br i1 %323, label %324, label %325
324:
 call void @abort ()
 unreachable
325:
 %326 = call i32 @test9u (i32 30)
 %327 = icmp ne i32 %326, 1
 br i1 %327, label %328, label %329
328:
 call void @abort ()
 unreachable
329:
 %330 = call i32 @test10 (i32 0)
 %331 = icmp ne i32 %330, 0
 br i1 %331, label %332, label %333
332:
 call void @abort ()
 unreachable
333:
 %334 = call i32 @test10 (i32 9)
 %335 = icmp ne i32 %334, 0
 br i1 %335, label %336, label %337
336:
 call void @abort ()
 unreachable
337:
 %338 = call i32 @test10 (i32 10)
 %339 = icmp ne i32 %338, 1
 br i1 %339, label %340, label %341
340:
 call void @abort ()
 unreachable
341:
 %342 = call i32 @test10 (i32 -1)
 %343 = icmp ne i32 %342, 0
 br i1 %343, label %344, label %345
344:
 call void @abort ()
 unreachable
345:
 %346 = call i32 @test10 (i32 -9)
 %347 = icmp ne i32 %346, 0
 br i1 %347, label %348, label %349
348:
 call void @abort ()
 unreachable
349:
 %350 = call i32 @test10 (i32 -10)
 %351 = icmp ne i32 %350, 0
 br i1 %351, label %352, label %353
352:
 call void @abort ()
 unreachable
353:
 %354 = call i32 @test10u (i32 0)
 %355 = icmp ne i32 %354, 0
 br i1 %355, label %356, label %357
356:
 call void @abort ()
 unreachable
357:
 %358 = call i32 @test10u (i32 9)
 %359 = icmp ne i32 %358, 0
 br i1 %359, label %360, label %361
360:
 call void @abort ()
 unreachable
361:
 %362 = call i32 @test10u (i32 10)
 %363 = icmp ne i32 %362, 1
 br i1 %363, label %364, label %365
364:
 call void @abort ()
 unreachable
365:
 %366 = call i32 @test10u (i32 -1)
 %367 = icmp ne i32 %366, 1
 br i1 %367, label %368, label %369
368:
 call void @abort ()
 unreachable
369:
 %370 = call i32 @test10u (i32 -9)
 %371 = icmp ne i32 %370, 1
 br i1 %371, label %372, label %373
372:
 call void @abort ()
 unreachable
373:
 %374 = call i32 @test10u (i32 -10)
 %375 = icmp ne i32 %374, 1
 br i1 %375, label %376, label %377
376:
 call void @abort ()
 unreachable
377:
 %378 = call i32 @test11 (i32 19)
 %379 = icmp ne i32 %378, 0
 br i1 %379, label %380, label %381
380:
 call void @abort ()
 unreachable
381:
 %382 = call i32 @test11 (i32 20)
 %383 = icmp ne i32 %382, 1
 br i1 %383, label %384, label %385
384:
 call void @abort ()
 unreachable
385:
 %386 = call i32 @test11 (i32 29)
 %387 = icmp ne i32 %386, 1
 br i1 %387, label %388, label %389
388:
 call void @abort ()
 unreachable
389:
 %390 = call i32 @test11 (i32 30)
 %391 = icmp ne i32 %390, 1
 br i1 %391, label %392, label %393
392:
 call void @abort ()
 unreachable
393:
 %394 = call i32 @test11u (i32 19)
 %395 = icmp ne i32 %394, 0
 br i1 %395, label %396, label %397
396:
 call void @abort ()
 unreachable
397:
 %398 = call i32 @test11u (i32 20)
 %399 = icmp ne i32 %398, 1
 br i1 %399, label %400, label %401
400:
 call void @abort ()
 unreachable
401:
 %402 = call i32 @test11u (i32 29)
 %403 = icmp ne i32 %402, 1
 br i1 %403, label %404, label %405
404:
 call void @abort ()
 unreachable
405:
 %406 = call i32 @test11u (i32 30)
 %407 = icmp ne i32 %406, 1
 br i1 %407, label %408, label %409
408:
 call void @abort ()
 unreachable
409:
 %410 = call i32 @test12 (i32 0)
 %411 = icmp ne i32 %410, 1
 br i1 %411, label %412, label %413
412:
 call void @abort ()
 unreachable
413:
 %414 = call i32 @test12 (i32 9)
 %415 = icmp ne i32 %414, 1
 br i1 %415, label %416, label %417
416:
 call void @abort ()
 unreachable
417:
 %418 = call i32 @test12 (i32 10)
 %419 = icmp ne i32 %418, 1
 br i1 %419, label %420, label %421
420:
 call void @abort ()
 unreachable
421:
 %422 = call i32 @test12 (i32 -1)
 %423 = icmp ne i32 %422, 1
 br i1 %423, label %424, label %425
424:
 call void @abort ()
 unreachable
425:
 %426 = call i32 @test12 (i32 -9)
 %427 = icmp ne i32 %426, 1
 br i1 %427, label %428, label %429
428:
 call void @abort ()
 unreachable
429:
 %430 = call i32 @test12 (i32 -10)
 %431 = icmp ne i32 %430, 0
 br i1 %431, label %432, label %433
432:
 call void @abort ()
 unreachable
433:
 ret i32 0
}
