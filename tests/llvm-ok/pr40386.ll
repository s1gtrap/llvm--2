@c = global i8 52
@s = global i16 -3532
@i = global i32 62004
@l = global i64 4063516280
@ll = global i64 1090791845765373680
@shift1 = global i32 4
@shift2 = global i32 60

declare void @abort()
declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i8, i8* @c
 %3 = sext i8 %2 to i32
 %4 = load i32, i32* @shift1
 %5 = ashr i32 %3, %4
 %6 = load i8, i8* @c
 %7 = sext i8 %6 to i32
 %8 = load i32, i32* @shift1
 %9 = sext i32 %8 to i64
 %10 = sub i64 8, %9
 %11 = trunc i64 %10 to i32
 %12 = shl i32 %7, %11
 %13 = or i32 %5, %12
 %14 = icmp ne i32 %13, 835
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 %17 = load i8, i8* @c
 %18 = sext i8 %17 to i32
 %19 = ashr i32 %18, 4
 %20 = load i8, i8* @c
 %21 = sext i8 %20 to i32
 %22 = shl i32 %21, 4
 %23 = or i32 %19, %22
 %24 = icmp ne i32 %23, 835
 br i1 %24, label %25, label %26
25:
 call void @abort ()
 unreachable
26:
 %27 = load i16, i16* @s
 %28 = sext i16 %27 to i32
 %29 = load i32, i32* @shift1
 %30 = ashr i32 %28, %29
 %31 = load i16, i16* @s
 %32 = sext i16 %31 to i32
 %33 = load i32, i32* @shift1
 %34 = sext i32 %33 to i64
 %35 = sub i64 16, %34
 %36 = trunc i64 %35 to i32
 %37 = shl i32 %32, %36
 %38 = or i32 %30, %37
 %39 = icmp ne i32 %38, -221
 br i1 %39, label %40, label %41
40:
 call void @abort ()
 unreachable
41:
 %42 = load i16, i16* @s
 %43 = sext i16 %42 to i32
 %44 = ashr i32 %43, 4
 %45 = load i16, i16* @s
 %46 = sext i16 %45 to i32
 %47 = shl i32 %46, 12
 %48 = or i32 %44, %47
 %49 = icmp ne i32 %48, -221
 br i1 %49, label %50, label %51
50:
 call void @abort ()
 unreachable
51:
 %52 = load i32, i32* @i
 %53 = load i32, i32* @shift1
 %54 = ashr i32 %52, %53
 %55 = load i32, i32* @i
 %56 = load i32, i32* @shift1
 %57 = sext i32 %56 to i64
 %58 = sub i64 32, %57
 %59 = trunc i64 %58 to i32
 %60 = shl i32 %55, %59
 %61 = or i32 %54, %60
 %62 = icmp ne i32 %61, 1073745699
 br i1 %62, label %63, label %64
63:
 call void @abort ()
 unreachable
64:
 %65 = load i32, i32* @i
 %66 = ashr i32 %65, 4
 %67 = load i32, i32* @i
 %68 = shl i32 %67, 28
 %69 = or i32 %66, %68
 %70 = icmp ne i32 %69, 1073745699
 br i1 %70, label %71, label %72
71:
 call void @abort ()
 unreachable
72:
 %73 = load i64, i64* @l
 %74 = load i32, i32* @shift1
 %75 = zext i32 %74 to i64
 %76 = ashr i64 %73, %75
 %77 = load i64, i64* @l
 %78 = load i32, i32* @shift1
 %79 = sext i32 %78 to i64
 %80 = sub i64 64, %79
 %81 = shl i64 %77, %80
 %82 = or i64 %76, %81
 %83 = icmp ne i64 %82, -9223372036600806041
 br i1 %83, label %84, label %85
84:
 call void @abort ()
 unreachable
85:
 %86 = load i64, i64* @l
 %87 = ashr i64 %86, 4
 %88 = load i64, i64* @l
 %89 = shl i64 %88, 60
 %90 = or i64 %87, %89
 %91 = icmp ne i64 %90, -9223372036600806041
 br i1 %91, label %92, label %93
92:
 call void @abort ()
 unreachable
93:
 %94 = load i64, i64* @ll
 %95 = load i32, i32* @shift1
 %96 = zext i32 %95 to i64
 %97 = ashr i64 %94, %96
 %98 = load i64, i64* @ll
 %99 = load i32, i32* @shift1
 %100 = sext i32 %99 to i64
 %101 = sub i64 64, %100
 %102 = shl i64 %98, %101
 %103 = or i64 %97, %102
 %104 = icmp ne i64 %103, 68174490360335855
 br i1 %104, label %105, label %106
105:
 call void @abort ()
 unreachable
106:
 %107 = load i64, i64* @ll
 %108 = ashr i64 %107, 4
 %109 = load i64, i64* @ll
 %110 = shl i64 %109, 60
 %111 = or i64 %108, %110
 %112 = icmp ne i64 %111, 68174490360335855
 br i1 %112, label %113, label %114
113:
 call void @abort ()
 unreachable
114:
 %115 = load i64, i64* @ll
 %116 = load i32, i32* @shift2
 %117 = zext i32 %116 to i64
 %118 = ashr i64 %115, %117
 %119 = load i64, i64* @ll
 %120 = load i32, i32* @shift2
 %121 = sext i32 %120 to i64
 %122 = sub i64 64, %121
 %123 = shl i64 %119, %122
 %124 = or i64 %118, %123
 %125 = icmp ne i64 %124, -994074541463572736
 br i1 %125, label %126, label %127
126:
 call void @abort ()
 unreachable
127:
 %128 = load i64, i64* @ll
 %129 = ashr i64 %128, 60
 %130 = load i64, i64* @ll
 %131 = shl i64 %130, 4
 %132 = or i64 %129, %131
 %133 = icmp ne i64 %132, -994074541463572736
 br i1 %133, label %134, label %135
134:
 call void @abort ()
 unreachable
135:
 %136 = load i8, i8* @c
 %137 = sext i8 %136 to i32
 %138 = load i32, i32* @shift1
 %139 = shl i32 %137, %138
 %140 = load i8, i8* @c
 %141 = sext i8 %140 to i32
 %142 = load i32, i32* @shift1
 %143 = sext i32 %142 to i64
 %144 = sub i64 8, %143
 %145 = trunc i64 %144 to i32
 %146 = ashr i32 %141, %145
 %147 = or i32 %139, %146
 %148 = icmp ne i32 %147, 835
 br i1 %148, label %149, label %150
149:
 call void @abort ()
 unreachable
150:
 %151 = load i8, i8* @c
 %152 = sext i8 %151 to i32
 %153 = shl i32 %152, 4
 %154 = load i8, i8* @c
 %155 = sext i8 %154 to i32
 %156 = ashr i32 %155, 4
 %157 = or i32 %153, %156
 %158 = icmp ne i32 %157, 835
 br i1 %158, label %159, label %160
159:
 call void @abort ()
 unreachable
160:
 %161 = load i16, i16* @s
 %162 = sext i16 %161 to i32
 %163 = load i32, i32* @shift1
 %164 = shl i32 %162, %163
 %165 = load i16, i16* @s
 %166 = sext i16 %165 to i32
 %167 = load i32, i32* @shift1
 %168 = sext i32 %167 to i64
 %169 = sub i64 16, %168
 %170 = trunc i64 %169 to i32
 %171 = ashr i32 %166, %170
 %172 = or i32 %164, %171
 %173 = icmp ne i32 %172, -1
 br i1 %173, label %174, label %175
174:
 call void @abort ()
 unreachable
175:
 %176 = load i16, i16* @s
 %177 = sext i16 %176 to i32
 %178 = shl i32 %177, 4
 %179 = load i16, i16* @s
 %180 = sext i16 %179 to i32
 %181 = ashr i32 %180, 12
 %182 = or i32 %178, %181
 %183 = icmp ne i32 %182, -1
 br i1 %183, label %184, label %185
184:
 call void @abort ()
 unreachable
185:
 %186 = load i32, i32* @i
 %187 = load i32, i32* @shift1
 %188 = shl i32 %186, %187
 %189 = load i32, i32* @i
 %190 = load i32, i32* @shift1
 %191 = sext i32 %190 to i64
 %192 = sub i64 32, %191
 %193 = trunc i64 %192 to i32
 %194 = ashr i32 %189, %193
 %195 = or i32 %188, %194
 %196 = icmp ne i32 %195, 992064
 br i1 %196, label %197, label %198
197:
 call void @abort ()
 unreachable
198:
 %199 = load i32, i32* @i
 %200 = shl i32 %199, 4
 %201 = load i32, i32* @i
 %202 = ashr i32 %201, 28
 %203 = or i32 %200, %202
 %204 = icmp ne i32 %203, 992064
 br i1 %204, label %205, label %206
205:
 call void @abort ()
 unreachable
206:
 %207 = load i64, i64* @l
 %208 = load i32, i32* @shift1
 %209 = zext i32 %208 to i64
 %210 = shl i64 %207, %209
 %211 = load i64, i64* @l
 %212 = load i32, i32* @shift1
 %213 = sext i32 %212 to i64
 %214 = sub i64 64, %213
 %215 = ashr i64 %211, %214
 %216 = or i64 %210, %215
 %217 = icmp ne i64 %216, 65016260480
 br i1 %217, label %218, label %219
218:
 call void @abort ()
 unreachable
219:
 %220 = load i64, i64* @l
 %221 = shl i64 %220, 4
 %222 = load i64, i64* @l
 %223 = ashr i64 %222, 60
 %224 = or i64 %221, %223
 %225 = icmp ne i64 %224, 65016260480
 br i1 %225, label %226, label %227
226:
 call void @abort ()
 unreachable
227:
 %228 = load i64, i64* @ll
 %229 = load i32, i32* @shift1
 %230 = zext i32 %229 to i64
 %231 = shl i64 %228, %230
 %232 = load i64, i64* @ll
 %233 = load i32, i32* @shift1
 %234 = sext i32 %233 to i64
 %235 = sub i64 64, %234
 %236 = ashr i64 %232, %235
 %237 = or i64 %231, %236
 %238 = icmp ne i64 %237, -994074541463572736
 br i1 %238, label %239, label %240
239:
 call void @abort ()
 unreachable
240:
 %241 = load i64, i64* @ll
 %242 = shl i64 %241, 4
 %243 = load i64, i64* @ll
 %244 = ashr i64 %243, 60
 %245 = or i64 %242, %244
 %246 = icmp ne i64 %245, -994074541463572736
 br i1 %246, label %247, label %248
247:
 call void @abort ()
 unreachable
248:
 %249 = load i64, i64* @ll
 %250 = load i32, i32* @shift2
 %251 = zext i32 %250 to i64
 %252 = shl i64 %249, %251
 %253 = load i64, i64* @ll
 %254 = load i32, i32* @shift2
 %255 = sext i32 %254 to i64
 %256 = sub i64 64, %255
 %257 = ashr i64 %253, %256
 %258 = or i64 %252, %257
 %259 = icmp ne i64 %258, 68174490360335855
 br i1 %259, label %260, label %261
260:
 call void @abort ()
 unreachable
261:
 %262 = load i64, i64* @ll
 %263 = shl i64 %262, 60
 %264 = load i64, i64* @ll
 %265 = ashr i64 %264, 4
 %266 = or i64 %263, %265
 %267 = icmp ne i64 %266, 68174490360335855
 br i1 %267, label %268, label %269
268:
 call void @abort ()
 unreachable
269:
 call void @exit (i32 0)
 unreachable
}
